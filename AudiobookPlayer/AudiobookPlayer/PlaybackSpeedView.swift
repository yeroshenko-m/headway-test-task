//
//  PlaybackSpeedView.swift
//  AudiobookPlayer
//
//  Author:  Mykhailo Yeroshenko
//  Created: 30.06.2023
//

import SwiftUI

private enum Constants {
    enum Label {
        static let color: Color = Color(uiColor: .label)
        static let font: Font = .system(size: 15.0, weight: .medium)
        static let padding: CGFloat = 10.0
    }

    enum Background {
        static let cornerRadius: CGFloat = 6.0
        static let color: Color = Color(uiColor: .systemGray6)
    }
}

struct PlaybackSpeedView: View {
    var body: some View {
        Button {} label: {
            Text("Speed 1x")
                .padding(Constants.Label.padding)
                .background(Constants.Background.color)
                .cornerRadius(Constants.Background.cornerRadius)
                .font(Constants.Label.font)
        }
        .buttonStyle(.plain)
    }
}

struct PlaybackSpeedView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color(uiColor: .tertiarySystemBackground).ignoresSafeArea()
            PlaybackSpeedView()
        }
    }
}
