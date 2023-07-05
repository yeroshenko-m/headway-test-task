//
//  RetryView+Constants.swift
//  AudiobookPlayer
//
//  Author:  Mykhailo Yeroshenko
//  Created: 05.07.2023
//

import SwiftUI

// swiftlint:disable nesting
extension RetryView {
    enum Constants {
        enum Title {
            static let font: Font = .title
            static let color: Color = .black
        }

        enum Button {
            static let title: String = "Retry"
            static let titleColor: Color = .white
            static let color: Color = .blue
            static let height: CGFloat = 50.0
            static let padding: CGFloat = 20.0
            static let cornerRadius: CGFloat = 6.0
        }
    }
}

// swiftlint:enable nesting
