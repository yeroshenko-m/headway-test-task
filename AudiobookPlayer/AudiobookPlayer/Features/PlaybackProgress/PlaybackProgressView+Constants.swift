//
//  PlaybackProgressView+Constants.swift
//  AudiobookPlayer
//
//  Author:  Mykhailo Yeroshenko
//  Created: 04.07.2023
//

import SwiftUI

// swiftlint:disable nesting
extension PlaybackProgressView {
    enum Constants {
        enum Labels {
            static let font: Font = .system(size: 13.0, weight: .regular, design: .rounded)
            static let color: Color = .init(uiColor: .gray)
            static let width: CGFloat = 50.0
        }

        enum Progress {
            static let title: String = "Progress"
            static let color: UIColor = .systemBlue
            static let step: Double = 1.0
            static let minimumValue: Double = .zero
        }

        enum Thumb {
            static let color: Color = .init(uiColor: .systemBlue)
            static let image: UIImage? = UIImage(
                systemName: "circle.fill",
                withConfiguration: UIImage.SymbolConfiguration(scale: .medium)
            )
        }
    }
}

// swiftlint:enable nesting
