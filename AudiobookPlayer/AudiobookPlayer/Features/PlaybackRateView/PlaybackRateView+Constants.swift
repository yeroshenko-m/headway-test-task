//
//  PlaybackRateView+Constants.swift
//  AudiobookPlayer
//
//  Author:  Mykhailo Yeroshenko
//  Created: 30.06.2023
//

import SwiftUI

// swiftlint:disable nesting
extension PlaybackRateView {
    enum Constants {
        enum Label {
            static let color: Color = .init(uiColor: .label)
            static let font: Font = .system(size: 12.0, weight: .medium)
            static let padding: CGFloat = 10.0
        }

        enum Background {
            static let cornerRadius: CGFloat = 6.0
            static let color: Color = .gray.opacity(0.15)
        }
    }
}

// swiftlint:enable nesting
