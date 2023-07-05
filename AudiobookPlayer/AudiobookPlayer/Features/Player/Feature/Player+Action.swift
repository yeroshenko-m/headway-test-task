//
//  Player+Action.swift
//  AudiobookPlayer
//
//  Author:  Mykhailo Yeroshenko
//  Created: 05.07.2023
//

import ComposableArchitecture
import Foundation

extension Player {
    enum Action: Equatable {
        case viewAppeared
        case audiobookLoaded(TaskResult<Audiobook>)
        case chapterLoaded(TaskResult<Double>)
        case playbackProgressUpdated(PlayerProgress)

        case chapterChanged
        case rateButtonTapped
        case progress(PlaybackProgress.Action)
        case controls(PlayerControls.Action)
        case mode(ContentModeSelector.Action)

        case alertDismissed
        case modeAlertDismissed
        case retryChapterLoadingTapped
        case retryAudiobookLoadingTapped
    }
}
