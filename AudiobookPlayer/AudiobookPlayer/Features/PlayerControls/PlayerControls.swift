//
//  PlayerControls.swift
//  AudiobookPlayer
//
//  Author:  Mykhailo Yeroshenko
//  Created: 30.06.2023
//

import ComposableArchitecture
import Foundation

struct PlayerControls: ReducerProtocol {
    struct State: Equatable {
        // swiftlint:disable nesting
        enum PlaybackState: Equatable {
            case playing
            case paused
            case disabled

            var isEnabled: Bool { self != .disabled }
            var isPlaying: Bool { self == .playing }
        }
        // swiftlint:enable nesting

        var playbackState: PlaybackState = .disabled
        var hasPreviousItem: Bool = false
        var hasNextItem: Bool = false

        var canSeekBackward: Bool { playbackState != .disabled }
        var canSeekForward: Bool { playbackState != .disabled }
    }

    enum Action {
        case playButtonTapped
        case previousButtonTapped
        case nextButtonTapped
        case seekForwardButtonTapped
        case seekBackwardButtonTapped
    }

    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        .none
    }
}
