//
//  AudiobooksClient.swift
//  AudiobookPlayer
//
//  Author:  Mykhailo Yeroshenko
//  Created: 03.07.2023
//

import ComposableArchitecture
import Foundation

struct AudiobookClient {
    var audiobook: @Sendable () async throws -> Audiobook
}

extension AudiobookClient {
    static let live = AudiobookClient {
        let (data, _) = try await URLSession.shared.data(from: AudiobooksAPI.url)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let dtoModel = try decoder.decode(AudiobookDTO.self, from: data)
        return Audiobook(from: dtoModel)
    }
}

// MARK: - AudiobookClient + DependencyValues

extension DependencyValues {
    var factsClient: AudiobookClient {
        get { self[AudiobookClient.self] }
        set { self[AudiobookClient.self] = newValue }
    }
}

// MARK: - AudiobookClient + DependencyKey

extension AudiobookClient: DependencyKey {
    static var liveValue: AudiobookClient {
        .live
    }

    static var testValue: AudiobookClient {
        AudiobookClient {
            unimplemented("\(AudiobookClient.self)")
        }
    }
}
