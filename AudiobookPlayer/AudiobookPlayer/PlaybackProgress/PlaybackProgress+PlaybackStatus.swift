//
//  PlaybackProgress+PlaybackStatus.swift
//  AudiobookPlayer
//
//  Author:  Mykhailo Yeroshenko
//  Created: 04.07.2023
//

import Foundation

extension PlaybackProgress {
    struct PlaybackTime: Equatable {
        let duration: Double
        let step: Double
    }

    enum PlaybackConfiguration: Equatable {
        case disabled
        case enabled(PlaybackTime)

        var isEnabled: Bool {
            self != .disabled
        }

        var duration: Double {
            switch self {
            case .disabled:
                return .leastNonzeroMagnitude
            case let .enabled(playbackTime):
                return playbackTime.duration
            }
        }

        var step: Double {
            switch self {
            case .disabled:
                return .leastNonzeroMagnitude
            case let .enabled(playbackTime):
                return playbackTime.step
            }
        }
    }
}
