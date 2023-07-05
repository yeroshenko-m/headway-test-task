//
//  Player+State.swift
//  AudiobookPlayer
//
//  Author:  Mykhailo Yeroshenko
//  Created: 05.07.2023
//

import ComposableArchitecture
import Foundation

extension Player {
    struct State: Equatable {
        var imageURL: URL?
        var chapters: [Chapter] = []
        var currentChapterIndex: Int = Constants.defaultChapterIndex
        var playbackRate: Float = Constants.Rate.standart

        var progress: PlaybackProgress.State = .init()
        var controls: PlayerControls.State = .init()
        var mode: ContentModeSelector.State = .init()

        var alert: AlertState<Action>?

        var chaptersCountTitle: String {
            guard !chapters.isEmpty else { return "No keypoints available" }
            return "Key point \(currentChapterIndex + 1) of \(chapters.count)"
        }

        var chapterTitle: String {
            guard chapters.count > currentChapterIndex else { return "Description unavailable" }
            return chapters[currentChapterIndex].title
        }

        var rateTitle: String { "Rate \(playbackRate.stringWithTruncatedZero)x" }
        var hasNextChapter: Bool { chapters.count > currentChapterIndex }
        var hasPreviousChapter: Bool { currentChapterIndex > .zero }
    }
}
