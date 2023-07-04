//
//  AudiobookProvider.swift
//  AudiobookPlayer
//
//  Author:  Mykhailo Yeroshenko
//  Created: 03.07.2023
//

import ComposableArchitecture
import Foundation

struct AudiobookProvider {
    var audiobook: @Sendable () async throws -> Audiobook
}

// MARK: - Live

extension AudiobookProvider {
    static let live = AudiobookProvider {
        let (data, _) = try await URLSession.shared.data(from: AudiobookAPI.url)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let dtoModel = try decoder.decode(AudiobookDTO.self, from: data)
        return Audiobook(from: dtoModel)
    }
}

// MARK: - AudiobookProvider + DependencyValues

extension DependencyValues {
    var audiobookProvider: AudiobookProvider {
        get { self[AudiobookProvider.self] }
        set { self[AudiobookProvider.self] = newValue }
    }
}

// MARK: - AudiobookProvider + DependencyKey

extension AudiobookProvider: DependencyKey {
    static var liveValue: AudiobookProvider {
        .live
    }

    static var testValue: AudiobookProvider {
        AudiobookProvider {
            unimplemented("\(AudiobookProvider.self)")
        }
    }
}
