//
//  PlaybackRateView.swift
//  AudiobookPlayer
//
//  Author:  Mykhailo Yeroshenko
//  Created: 30.06.2023
//

import SwiftUI

struct PlaybackRateView: View {
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

#if DEBUG
    struct PlaybackRateView_Previews: PreviewProvider {
        static var previews: some View {
            ZStack {
                Color(uiColor: .tertiarySystemBackground).ignoresSafeArea()
                PlaybackRateView(title: "Speed 1x") {}
            }
        }
    }
#endif
