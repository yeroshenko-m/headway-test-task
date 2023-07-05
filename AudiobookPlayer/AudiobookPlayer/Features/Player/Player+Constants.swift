//
//  Player+Constants.swift
//  AudiobookPlayer
//
//  Author:  Mykhailo Yeroshenko
//  Created: 04.07.2023
//

import Foundation

// swiftlint:disable nesting
extension Player {
    enum Constants {
        enum Rate {
            static let max: Float = 2.0
            static let min: Float = 0.25
            static let step: Float = 0.25
            static let standart: Float = 1.0
        }

        enum Progress {
            static let step: Double = 1.0
            static let seekForwardInterval: Double = 10.0
            static let seekBackwardInterval: Double = 5.0
        }

        enum Alert {
            static let bookLoadingFailed: String = "Audiobook loading failed ☹️"
            static let chapterLoadingFailed: String = "Sorry, chapter audio loading failed ☹️"
            static let chapterAudioUnavailable: String = "Sorry, the audio for this chaptes is unavailable ☹️"
            static let dismiss: String = "OK"
            static let retry: String = "Retry"
        }

        static let defaultChapterIndex: Int = 0
    }
}
// swiftlint:enable nesting
