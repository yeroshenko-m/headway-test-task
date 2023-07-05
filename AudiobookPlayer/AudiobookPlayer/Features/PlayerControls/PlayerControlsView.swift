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
        WithViewStore(self.store) { $0 } content: { viewStore in
            HStack(spacing: Constants.Icons.spacing) {
                button(
                    with: Constants.Icons.previous,
                    size: Constants.Size.trackButton,
                    isEnabled: viewStore.hasPreviousItem
                ) {
                    viewStore.send(.previousButtonTapped)
                }

                button(
                    with: Constants.Icons.goBackward,
                    size: Constants.Size.progressButtons,
                    isEnabled: viewStore.canSeekBackward
                ) {
                    viewStore.send(.seekBackwardButtonTapped)
                }

                button(
                    with: viewStore.playbackState.isPlaying ? Constants.Icons.pause : Constants.Icons.play,
                    size: Constants.Size.playbackButton,
                    isEnabled: viewStore.playbackState.isEnabled
                ) {
                    viewStore.send(.playButtonTapped)
                }

                button(
                    with: Constants.Icons.goForward,
                    size: Constants.Size.progressButtons,
                    isEnabled: viewStore.canSeekForward
                ) {
                    viewStore.send(.seekForwardButtonTapped)
                }

                button(
                    with: Constants.Icons.next,
                    size: Constants.Size.trackButton,
                    isEnabled: viewStore.hasNextItem
                ) {
                    viewStore.send(.nextButtonTapped)
                }
            }
        }
    }

    // MARK: - Private helpers

    @ViewBuilder
    private func button(
        with image: String,
        size: CGFloat,
        isEnabled: Bool,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            Image(systemName: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: size, height: size)
        }
        .foregroundColor(isEnabled ? Constants.Colors.enabled : Constants.Colors.disabled)
        .disabled(!isEnabled)
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
