//
//  AudioPlayerClient.swift
//  AudiobookPlayer
//
//  Author:  Mykhailo Yeroshenko
//  Created: 03.07.2023
//

import AVFoundation
import Foundation

struct AudioPlayerClient {
    var loadItemAt: @Sendable (URL) async throws -> Double
    var play: @Sendable () async -> Void
    var pause: @Sendable () async -> Void
    var progress: @Sendable () async -> AsyncStream<Double>
    var seekTo: @Sendable (Double) async -> Double
    var seekForwardBy: @Sendable (Double) async -> Double
    var seekBackwardBy: @Sendable (Double) async -> Double
}

extension AudioPlayerClient {
    static let live: Self = {
        let controller = PlayerController()

        return AudioPlayerClient { url in
            let playerItem = AVPlayerItem(url: url)
            controller.player.replaceCurrentItem(with: playerItem)

            let stream = AsyncThrowingStream<Double, Error> { continuation in
                controller.fetchDuration(of: playerItem, into: continuation)
            }

            guard let itemDuration = try await stream.first(where: { _ in true }) else {
                throw AudioPlayerClientError.invalidItemDuration
            }

            return itemDuration
        } play: {
            controller.player.play()
        } pause: {
            controller.player.pause()
        } progress: {
            AsyncStream<Double> { continuation in
                controller.streamPlaybackProgress(into: continuation)
            }
        } seekTo: { timecode in
            let currentTimecode = controller.player.currentTime()
            guard await controller.player.seek(to: timecode.cmTime()) else {
                return currentTimecode.seconds
            }

            return timecode
        } seekForwardBy: { timeInterval in
            let duration = controller.player.currentItem?.duration.seconds ?? .zero
            let currentTimecode = controller.player.currentTime()
            let targetTimecode = min(currentTimecode.seconds + timeInterval, duration)

            guard await controller.player.seek(to: targetTimecode.cmTime()) else {
                return currentTimecode.seconds
            }

            return targetTimecode
        } seekBackwardBy: { timeInterval in
            let currentTimecode = controller.player.currentTime()
            let targetTimecode = max(currentTimecode.seconds - timeInterval, .zero)

            guard await controller.player.seek(to: targetTimecode.cmTime()) else {
                return currentTimecode.seconds
            }

            return targetTimecode
        }
    }()
}
