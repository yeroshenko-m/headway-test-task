//
//  PlaybackProgressView.swift
//  AudiobookPlayer
//
//  Author:  Mykhailo Yeroshenko
//  Created: 30.06.2023
//

import SwiftUI
import UIKit

private enum Constants {
    enum Labels {
        static let font: Font = .system(size: 15.0, weight: .regular)
        static let color: Color = Color(uiColor: .lightGray)
    }

    enum Progress {
        static let color: UIColor = .systemBlue
    }

    enum Thumb {
        static let color: Color = Color(uiColor: .systemBlue)
        static let image: UIImage? = UIImage(
            systemName: "circle.fill",
            withConfiguration: UIImage.SymbolConfiguration(scale: .medium)
        )
    }
}

struct PlaybackProgressView: View {
    @State private var progress: CGFloat = 0.0

    var body: some View {
        Slider(value: $progress, in: 0.0 ... 120.0, step: 1.0) {
            Text("Slider")
        } minimumValueLabel: {
            Text("00:00")
                .font(Constants.Labels.font)
                .foregroundColor(Constants.Labels.color)
        } maximumValueLabel: {
            Text("02:00")
                .font(Constants.Labels.font)
                .foregroundColor(Constants.Labels.color)
        } onEditingChanged: { _ in
            return
        }
        .tint(Constants.Thumb.color)
        .onAppear {
            setupAppearance()
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
        PlaybackProgressView()
    }
}
