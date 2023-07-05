//
//  PlayerView+Constants.swift
//  AudiobookPlayer
//
//  Author:  Mykhailo Yeroshenko
//  Created: 04.07.2023
//

import SwiftUI

// swiftlint:disable nesting
extension PlayerView {
    enum Constants {
        enum Content {
            static let background: Color = .init(uiColor: .tertiarySystemGroupedBackground)
            static let padding: CGFloat = 10.0
        }

        enum ChaptersCountLabel {
            static let font: Font = .system(size: 13.0, weight: .medium, design: .rounded)
            static let color: Color = .gray
            static let topPadding: CGFloat = 35.0
        }

        enum ChapterTitleLabel {
            static let font: Font = .system(size: 17.0, design: .rounded)
            static let height: CGFloat = 45.0
            static let lineLimit: Int = 2
            static let topPadding: CGFloat = 10.0
        }

        enum Controls {
            static let topPadding: CGFloat = 50.0
        }

        enum Cover {
            static let scale: CGFloat = 0.4
        }

        enum Progress {
            static let topPadding: CGFloat = 25.0
        }

        enum Rate {
            static let topPadding: CGFloat = 15.0
        }
    }
}

// swiftlint:enable nesting
