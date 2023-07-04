//
//  PlayerControlsView.swift
//  AudiobookPlayer
//
//  Author:  Mykhailo Yeroshenko
//  Created: 30.06.2023
//

import ComposableArchitecture
import SwiftUI

struct PlayerControlsView: View {
    let store: StoreOf<PlayerControls>

    var body: some View {
        WithViewStore(self.store) { $0 }  content: { viewStore in
            HStack(spacing: Constants.Icons.spacing) {
                Button {
                    viewStore.send(.previousButtonTapped)
                } label: {
                    Image(systemName: Constants.Icons.previous)
                        .font(Constants.Fonts.trackButton)
                }
                .foregroundColor(
                    viewStore.hasPreviousItem ? Constants.Colors.enabled : Constants.Colors.disabled
                )
                .disabled(!viewStore.hasPreviousItem)

                Button {
                    viewStore.send(.seekBackwardButtonTapped)
                } label: {
                    Image(systemName: Constants.Icons.goBackward)
                        .font(Constants.Fonts.progressButtons)
                }
                .foregroundColor(
                    viewStore.canSeekBackward ? Constants.Colors.enabled : Constants.Colors.disabled
                )
                .disabled(!viewStore.canSeekBackward)

                Button {
                    viewStore.send(.playButtonTapped)
                } label: {
                    Image(systemName: viewStore.playbackState.isPlaying ?
                          Constants.Icons.pause :
                            Constants.Icons.play)
                        .font(Constants.Fonts.playbackButton)
                }
                .foregroundColor(
                    viewStore.playbackState.isEnabled ? Constants.Colors.enabled : Constants.Colors.disabled
                )
                .disabled(!viewStore.playbackState.isEnabled)

                Button {
                    viewStore.send(.seekForwardButtonTapped)
                } label: {
                    Image(systemName: Constants.Icons.goForward)
                        .font(Constants.Fonts.progressButtons)
                }
                .foregroundColor(
                    viewStore.canSeekForward ? Constants.Colors.enabled : Constants.Colors.disabled
                )
                .disabled(!viewStore.canSeekForward)

                Button {
                    viewStore.send(.nextButtonTapped)
                } label: {
                    Image(systemName: Constants.Icons.next)
                        .font(Constants.Fonts.trackButton)
                }
                .foregroundColor(
                    viewStore.hasNextItem ? Constants.Colors.enabled : Constants.Colors.disabled
                )
                .disabled(!viewStore.hasNextItem)
            }
        }
    }
}

#if DEBUG
    struct PlayerControlsView_Previews: PreviewProvider {
        static var previews: some View {
            PlayerControlsView(
                store: Store(
                    initialState: PlayerControls.State(
                        playbackState: .paused,
                        hasPreviousItem: false,
                        hasNextItem: true
                    ),
                    reducer: PlayerControls()
                )
            )
        }
    }
#endif
