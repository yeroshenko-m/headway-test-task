//
//  PlayerView.swift
//  AudiobookPlayer
//
//  Author:  Mykhailo Yeroshenko
//  Created: 30.06.2023
//

import ComposableArchitecture
import SwiftUI

struct PlayerView: View {
    let store: StoreOf<Player>

    var body: some View {
        WithViewStore(self.store) { $0 } content: { viewStore in
            GeometryReader { proxy in
                VStack(spacing: .zero) {
                    RemoteImage(url: viewStore.imageURL)
                        .scaledToFit()
                        .frame(height: proxy.size.height * Constants.Cover.scale)

                    Text(viewStore.chaptersCountTitle.uppercased())
                        .font(Constants.ChaptersCountLabel.font)
                        .foregroundColor(Constants.ChaptersCountLabel.color)
                        .padding(.top, Constants.ChaptersCountLabel.topPadding)

                    Text(viewStore.chapterTitle )
                        .font(Constants.ChapterTitleLabel.font)
                        .multilineTextAlignment(.center)
                        .frame(height: Constants.ChapterTitleLabel.height)
                        .lineLimit(Constants.ChapterTitleLabel.lineLimit)
                        .padding(.top, Constants.ChapterTitleLabel.topPadding)

                    PlaybackProgressView(
                        store: store.scope(
                            state: \.progress,
                            action: Player.Action.progress
                        )
                    )
                    .padding(.top, Constants.Progress.topPadding)

                    PlaybackRateView(title: viewStore.rateTitle) {
                        viewStore.send(.rateButtonTapped)
                    }
                    .padding(.top, Constants.Rate.topPadding)

                    PlayerControlsView(
                        store: store.scope(
                            state: \.controls,
                            action: Player.Action.controls
                        )
                    )
                    .padding(.top, Constants.Controls.topPadding)
                }
                .onAppear {
                    viewStore.send(.viewAppeared)
                }
                .alert(
                    self.store.scope(state: \.alert, action: { $0 }),
                    dismiss: .alertDismissed
                )
            }
            .padding(Constants.Content.padding)
            .background(Constants.Content.background.ignoresSafeArea())
        }
    }
}

#if DEBUG
    struct PlayerView_Previews: PreviewProvider {
        static var previews: some View {
            PlayerView(
                store: Store(
                    initialState: Player.State(),
                    reducer: Player()
                )
            )
        }
    }
#endif
