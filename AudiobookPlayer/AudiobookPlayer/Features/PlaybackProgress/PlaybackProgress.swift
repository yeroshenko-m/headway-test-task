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
        var current: Double = .zero
        var status: PlaybackStatus = .disabled

        var isEnabled: Bool { status.isEnabled }
        var duration: Double { status.duration }
        var step: Double { status.step }
    }

    enum Action: Equatable {
        case progressUpdated(Double)
    }

    func reduce(into _: inout State, action _: Action) -> EffectTask<Action> {
        .none
    }
}
