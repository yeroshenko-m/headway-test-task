//
//  AudioPlayerController.swift
//  AudiobookPlayer
//
//  Author:  Mykhailo Yeroshenko
//  Created: 03.07.2023
//

import AVFoundation
import Foundation

private enum Constants {
    static let progressInterval: CMTime = .init(
        seconds: 0.5,
        preferredTimescale: CMTimeScale(NSEC_PER_SEC)
    )
}

final class PlayerController {
    let player: AVPlayer

    init(player: AVPlayer = .init()) {
        self.player = player
    }

    func fetchDuration(
        of playerItem: AVPlayerItem,
        into continuation: AsyncThrowingStream<Double, Error>.Continuation
    ) {
        let observation = playerItem.observe(\.status) { item, _ in
            switch item.status {
            case .readyToPlay:
                continuation.yield(item.duration.seconds)
                continuation.finish()
            default:
                continuation.finish(throwing: PlayerControllerError.itemLoadingFailed)
            }
        }

        continuation.onTermination = { _ in
            observation.invalidate()
        }
    }

    func streamPlaybackProgress(into continuation: AsyncStream<Double>.Continuation) {
        let progressObserer = player.addPeriodicTimeObserver(
            forInterval: Constants.progressInterval,
            queue: .main
        ) { progress in
            continuation.yield(progress.seconds)
        }

        continuation.onTermination = { [weak self] _ in
            self?.player.removeTimeObserver(progressObserer)
        }
    }
}
