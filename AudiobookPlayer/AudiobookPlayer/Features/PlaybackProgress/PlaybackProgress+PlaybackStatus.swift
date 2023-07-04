//
//  PlaybackProgress+PlaybackStatus.swift
//  AudiobookPlayer
//
//  Author:  Mykhailo Yeroshenko
//  Created: 04.07.2023
//

import Foundation

extension PlaybackProgress {
    struct TimeIntervals: Equatable {
        let duration: Double
        let step: Double
    }

    enum PlaybackStatus: Equatable {
        case disabled
        case enabled(TimeIntervals)

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
