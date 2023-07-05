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
            static let color: Color = .init(uiColor: .label)
            static let spacing: CGFloat = 25.0
        }

        enum Size {
            static let playbackButton: CGFloat = 35.0
            static let progressButtons: CGFloat = 30.0
            static let trackButton: CGFloat = 20.0
        }

        enum Colors {
            static let enabled: Color = .init(uiColor: .label)
            static let disabled: Color = .init(uiColor: .label).opacity(0.25)
        }
    }
}

// swiftlint:enable nesting
