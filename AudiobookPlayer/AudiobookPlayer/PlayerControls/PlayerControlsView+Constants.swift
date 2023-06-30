//
//  PlayerControlsView+Constants.swift
//  AudiobookPlayer
//
//  Author:  Mykhailo Yeroshenko
//  Created: 30.06.2023
//

import Foundation
import SwiftUI

// swiftlint:disable nesting
extension PlayerControlsView {
    enum Constants {
        enum Icons {
            static let play = "play.fill"
            static let pause = "pause.fill"
            static let goBackward = "gobackward.5"
            static let goForward = "goforward.10"
            static let previous = "backward.end.fill"
            static let next = "forward.end.fill"
            static let color: Color = Color(uiColor: .label)
            static let spacing: CGFloat = 20.0
        }

        enum Fonts {
            static let playbackButton: Font = .system(size: 30.0)
            static let progressButtons: Font = .system(size: 25.0)
            static let trackButton: Font = .system(size: 20.0)
        }

        enum Colors {
            static let enabled: Color = Color(uiColor: .label)
            static let disabled: Color = Color(uiColor: .label).opacity(0.25)
        }
    }
}
// swiftlint:enable nesting
