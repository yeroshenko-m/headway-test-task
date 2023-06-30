//
//  PlaybackSpeedView.swift
//  AudiobookPlayer
//
//  Author:  Mykhailo Yeroshenko
//  Created: 30.06.2023
//

import SwiftUI

struct PlaybackSpeedView: View {
    let title: String
    let onTapped: () -> Void

    var body: some View {
        Button(action: onTapped) {
            Text(title)
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
            PlaybackSpeedView(title: "Speed 1x") {}
        }
    }
}
