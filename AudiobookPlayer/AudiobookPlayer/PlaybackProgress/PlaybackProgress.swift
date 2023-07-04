//
//  PlaybackProgress.swift
//  AudiobookPlayer
//
//  Author:  Mykhailo Yeroshenko
//  Created: 03.07.2023
//

import ComposableArchitecture
import Foundation

struct PlaybackProgress: ReducerProtocol {
    struct State: Equatable {
        var currentTimecode: Double = .zero
        var configuration: PlaybackConfiguration = .disabled

        var isEnabled: Bool { configuration.isEnabled }
        var duration: Double { configuration.duration }
        var step: Double { configuration.step }
    }

    enum Action: Equatable {
        case progressChanged(Double)
    }

    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case let .progressChanged(timeCode):
            state.currentTimecode = timeCode
            return .none
        }
    }
}
