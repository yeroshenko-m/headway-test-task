//
//  Retry.swift
//  AudiobookPlayer
//
//  Author:  Mykhailo Yeroshenko
//  Created: 05.07.2023
//

import ComposableArchitecture
import Foundation

struct Retry: ReducerProtocol {
    struct State: Equatable {
        let title: String
    }

    enum Action: Equatable {
        case retryTapped
    }

    func reduce(into _: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .retryTapped:
            return .none
        }
    }
}
