//
//  AudioplayerTests.swift
//  AudiobookPlayerTests
//
//  Author:  Mykhailo Yeroshenko
//  Created: 05.07.2023
//

@testable import AudiobookPlayer
import ComposableArchitecture
import XCTest

@MainActor
final class PlayerTests: XCTestCase {
    func testLoadingChapter() async {
        // GIVEN
        let store = TestStore(initialState: Player.State()) {
            Player()
        }

        // WHEN
        await store.send(.audiobookLoaded(.success(.mock))) {
            $0.imageURL = Audiobook.mock.imageURL
            $0.chapters = Audiobook.mock.chapters
        }

        // THEN
        await store.receive(.chapterLoaded(.success(100.0))) {
            $0.progress.status = .enabled(.init(duration: 100.0, step: 1.0))
            $0.controls.playbackState = .paused
            $0.controls.hasNextItem = true
            $0.controls.hasPreviousItem = false
        }
    }

    func testLoadingChapterFailure() async {
        // GIVEN
        let store = TestStore(initialState: Player.State()) {
            Player()
        } withDependencies: {
            $0.audioplayer.loadItemAt = { _ in throw AudioPlayerError.invalidItemDuration }
        }

        // WHEN
        await store.send(.audiobookLoaded(.success(.mock))) {
            $0.imageURL = Audiobook.mock.imageURL
            $0.chapters = Audiobook.mock.chapters
        }

        // THEN
        await store.receive(.chapterLoaded(.failure(AudioPlayerError.invalidItemDuration))) {
            $0.progress.status = .disabled
            $0.controls.playbackState = .disabled
            $0.controls.hasNextItem = true
            $0.controls.hasPreviousItem = false
            $0.alert = AlertState {
                TextState(Player.Constants.Alert.chapterLoadingFailed)
            } actions: {
                ButtonState(action: .retryChapterLoadingTapped) {
                    TextState(Player.Constants.Alert.retry)
                }

                ButtonState(action: .alertDismissed) {
                    TextState(Player.Constants.Alert.dismiss)
                }
            }
        }
    }

    func testProgressUpdates() async {
        // GIVEN
        let store = TestStore(initialState: Player.State()) {
            Player()
        } withDependencies: {
            $0.audioplayer.progress = { .init {
                for progress in 1 ... 3 {
                    $0.yield(.value(Double(progress)))
                }
                $0.finish()
            } }
        }

        // WHEN
        await store.send(.chapterLoaded(.success(100.0))) {
            $0.progress.status = .enabled(.init(duration: 100.0, step: 1.0))
            $0.controls.playbackState = .paused
            $0.controls.hasNextItem = false
            $0.controls.hasPreviousItem = false
        }

        // THEN
        await store.receive(.playbackProgressUpdated(.value(1.0))) {
            $0.progress.current = 1.0
        }

        await store.receive(.playbackProgressUpdated(.value(2.0))) {
            $0.progress.current = 2.0
        }

        await store.receive(.playbackProgressUpdated(.value(3.0))) {
            $0.progress.current = 3.0
        }
    }
}
