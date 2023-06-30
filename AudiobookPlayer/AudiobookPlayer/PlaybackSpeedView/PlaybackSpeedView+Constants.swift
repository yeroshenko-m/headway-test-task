//
//  PlaybackSpeedView+Constants.swift
//  AudiobookPlayer
//
//  Author:  Mykhailo Yeroshenko
//  Created: 30.06.2023
//

import SwiftUI

// swiftlint:disable nesting
extension PlaybackSpeedView {
    enum Constants {
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
}
// swiftlint:enable nesting
