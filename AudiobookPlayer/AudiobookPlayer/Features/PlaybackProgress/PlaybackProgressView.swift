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
                    get: \.current,
                    send: PlaybackProgress.Action.progressUpdated
                ),
                in: .zero ... viewStore.duration,
                step: viewStore.step
            ) {
                Text(Constants.Progress.title)
            } minimumValueLabel: {
                Text(viewStore.current.timeCode)
                    .font(Constants.Labels.font)
                    .foregroundColor(Constants.Labels.color)
                    .frame(width: 50.0)
                    .fixedSize()
            } maximumValueLabel: {
                Text(viewStore.duration.timeCode)
                    .font(Constants.Labels.font)
                    .foregroundColor(Constants.Labels.color)
                    .frame(width: 50.0)
                    .fixedSize()
            } onEditingChanged: { isEditing in
                print(isEditing)
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
