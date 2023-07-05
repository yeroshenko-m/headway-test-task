//
//  ContentModeSelector.swift
//  AudiobookPlayer
//
//  Author:  Mykhailo Yeroshenko
//  Created: 05.07.2023
//

import ComposableArchitecture
import Foundation

struct ContentModeSelector: ReducerProtocol {
    enum ContentMode {
        case player
        case text

        mutating func toggle() {
            switch self {
            case .player:
                self = .text

            case .text:
                self = .player
            }
        }
    }

    struct State: Equatable {
        var mode: ContentMode = .player
    }

    enum Action: Equatable {
        case viewTapped
    }

    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .viewTapped:
            state.mode.toggle()
            return .none
        }
    }
}
