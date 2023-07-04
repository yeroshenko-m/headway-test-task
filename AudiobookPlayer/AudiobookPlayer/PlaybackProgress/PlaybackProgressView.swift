//
//  PlaybackProgressView.swift
//  AudiobookPlayer
//
//  Author:  Mykhailo Yeroshenko
//  Created: 30.06.2023
//

import ComposableArchitecture
import SwiftUI
import UIKit

struct PlaybackProgressView: View {
    let store: StoreOf<PlaybackProgress>

    var body: some View {
        WithViewStore(self.store) { $0 } content: { viewStore in
            Slider(
                value: viewStore.binding(
                    get: \.currentTimecode,
                    send: PlaybackProgress.Action.progressChanged
                ),
                in: .zero ... viewStore.duration,
                step: viewStore.step
            ) {
                Text(Constants.Progress.title)
            } minimumValueLabel: {
                Text(viewStore.currentTimecode.timeCode)
                    .font(Constants.Labels.font)
                    .foregroundColor(Constants.Labels.color)
            } maximumValueLabel: {
                Text(viewStore.duration.timeCode)
                    .font(Constants.Labels.font)
                    .foregroundColor(Constants.Labels.color)
            }
            .disabled(!viewStore.isEnabled)
            .tint(Constants.Thumb.color)
            .onAppear(perform: setupAppearance)
        }
    }

    private func setupAppearance() {
        UISlider.appearance()
            .setThumbImage(Constants.Thumb.image, for: .normal)
        UISlider.appearance()
            .minimumTrackTintColor = Constants.Progress.color
    }
}

struct PlaybackProgressView_Previews: PreviewProvider {
    static var previews: some View {
        PlaybackProgressView(
            store: Store(
                initialState: PlaybackProgress.State(),
                reducer: PlaybackProgress()
            )
        )
    }
}
