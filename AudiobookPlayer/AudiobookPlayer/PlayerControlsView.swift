//
//  PlayerControlsView.swift
//  AudiobookPlayer
//
//  Author:  Mykhailo Yeroshenko
//  Created: 30.06.2023
//

import SwiftUI

enum Constants {
    enum Icons {
        static let play = "play.fill"
        static let pause = "pause.fill"
        static let goBackward = "gobackward.5"
        static let goForward = "goforward.10"
        static let previous = "backward.end.fill"
        static let next = "forward.end.fill"
    }

    enum Fonts {
        static let playbackButton: Font = .system(size: 30.0)
        static let progressButtons: Font = .system(size: 25.0)
        static let trackButton: Font = .system(size: 20.0)
    }

    enum Colors {
        static let enabled: Color = .black
        static let disabled: Color = .black.opacity(0.5)
    }

    static let spacing: CGFloat = 20.0
}

struct PlayerControlsView: View {
    var body: some View {
        HStack(spacing: Constants.spacing) {
            Button {} label: {
                Image(systemName: Constants.Icons.previous)
                    .font(Constants.Fonts.trackButton)
            }
            Button {} label: {
                Image(systemName: Constants.Icons.goBackward)
                    .font(Constants.Fonts.progressButtons)
            }
            Button {} label: {
                Image(systemName: Constants.Icons.play)
                    .font(Constants.Fonts.playbackButton)
            }
            Button {} label: {
                Image(systemName: Constants.Icons.goForward)
                    .font(Constants.Fonts.progressButtons)
            }
            Button {} label: {
                Image(systemName: Constants.Icons.next)
                    .font(Constants.Fonts.trackButton)
            }
        }
    }
}

struct PlayerControlsView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerControlsView()
    }
}
