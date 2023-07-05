//
//  Player.swift
//  AudiobookPlayer
//
//  Author:  Mykhailo Yeroshenko
//  Created: 04.07.2023
//

import ComposableArchitecture
import Foundation
import UIKit.UIImage

struct Player: ReducerProtocol {
    @Dependency(\.audiobookProvider) var audiobookProvider
    @Dependency(\.audioplayer) var audioplayer

    var body: some ReducerProtocolOf<Self> {
        Scope(state: \.progress, action: /Action.progress) {
            PlaybackProgress()
        }

        Scope(state: \.controls, action: /Action.controls) {
            PlayerControls()
        }

        Scope(state: \.mode, action: /Action.mode) {
            ContentModeSelector()
        }

        Reduce { state, action in
            switch action {
            case .viewAppeared:
                return loadAudiobook()

            case let .audiobookLoaded(.success(audiobook)):
                state.imageURL = audiobook.imageURL
                state.chapters = audiobook.chapters

                return loadCurrentChapter(for: &state)

            case .audiobookLoaded(.failure):
                state.alert = alert(
                    with: Constants.Alert.bookLoadingFailed,
                    retryAction: .retryAudiobookLoadingTapped
                )

                return .none

            case let .chapterLoaded(.success(duration)):
                state.progress.status = .enabled(.init(duration: duration, step: Constants.Progress.step))
                state.controls.playbackState = .paused
                state.controls.hasNextItem = state.hasNextChapter
                state.controls.hasPreviousItem = state.hasPreviousChapter

                return .run { send in
                    for await progress in await audioplayer.progress() {
                        await send(.playbackProgressUpdated(progress))
                    }
                }

            case .chapterLoaded(.failure):
                state.progress.status = .disabled
                state.controls.playbackState = .disabled
                state.controls.hasNextItem = state.hasNextChapter
                state.controls.hasPreviousItem = state.hasPreviousChapter
                state.alert = alert(
                    with: Constants.Alert.chapterLoadingFailed,
                    retryAction: .retryChapterLoadingTapped
                )

                return .none

            case .chapterChanged:
                state.controls.playbackState = .disabled
                state.progress.status = .disabled
                return loadCurrentChapter(for: &state)

            case let .playbackProgressUpdated(progress):
                switch progress {
                case let .value(progress):
                    state.progress.current = progress
                    return .none

                case .ended:
                    state.progress.current = .zero
                    state.controls.playbackState = .paused
                    return loadCurrentChapter(for: &state)
                }

            case .rateButtonTapped:
                state.playbackRate = nextPlaybackRate(for: state.playbackRate)
                guard state.controls.playbackState.isPlaying else { return .none }

                return .run { [rate = state.playbackRate] _ in
                    await audioplayer.setPlaybackRate(rate)
                }

            case .alertDismissed:
                state.alert = nil
                return .none

            case .modeAlertDismissed:
                state.mode.mode = .player
                return .none

            case .retryChapterLoadingTapped:
                state.alert = nil
                return loadCurrentChapter(for: &state)

            case .retryAudiobookLoadingTapped:
                state.alert = nil
                return loadAudiobook()

            case let .progress(action):
                return reduce(into: &state, progressAction: action)

            case let .controls(action):
                return reduce(into: &state, controlsAction: action)

            case let .mode(action):
                return reduce(into: &state, modeAction: action)
            }
        }
    }

    // MARK: - Private helpers

    private func reduce(into state: inout State, controlsAction: PlayerControls.Action) -> EffectTask<Action> {
        switch controlsAction {
        case .nextButtonTapped:
            state.currentChapterIndex += 1

            return .run { send in
                await send(.chapterChanged)
            }

        case .previousButtonTapped:
            state.currentChapterIndex -= 1

            return .run { send in
                await send(.chapterChanged)
            }

        case .playButtonTapped:
            let playbackState = state.controls.playbackState
            guard playbackState.isEnabled else { return .none }
            state.controls.playbackState = playbackState.isPlaying ? .paused : .playing

            return .run { [rate = state.playbackRate] _ in
                if playbackState.isPlaying {
                    await audioplayer.pause()
                } else {
                    await audioplayer.play(rate)
                }
            }

        case .seekBackwardButtonTapped:
            return .run { _ in
                await audioplayer.seekBackwardBy(Constants.Progress.seekBackwardInterval)
            }

        case .seekForwardButtonTapped:
            return .run { _ in
                await audioplayer.seekForwardBy(Constants.Progress.seekForwardInterval)
            }
        }
    }

    private func reduce(into _: inout State, progressAction: PlaybackProgress.Action) -> EffectTask<Action> {
        switch progressAction {
        case let .progressUpdated(progress):
            return .run { _ in
                await audioplayer.seekTo(progress)
            }
        }
    }

    private func reduce(into state: inout State, modeAction: ContentModeSelector.Action) -> EffectTask<Action> {
        switch modeAction {
        case .viewTapped:
            state.alert = alert(
                with: Constants.Alert.modeUnavailable,
                dismissAction: .modeAlertDismissed
            )
        }

        return .none
    }

    private func loadAudiobook() -> EffectTask<Action> {
        .run { send in
            await send(
                .audiobookLoaded(
                    TaskResult { try await audiobookProvider.audiobook() }
                )
            )
        }
    }

    private func loadCurrentChapter(for state: inout State) -> EffectTask<Action> {
        guard let chapterUrl = state.chapters[state.currentChapterIndex].audioURL
        else {
            state.alert = alert(with: Constants.Alert.chapterAudioUnavailable)
            return .none
        }

        return .run { send in
            await audioplayer.pause()

            await send(
                .chapterLoaded(
                    TaskResult { try await audioplayer.loadItemAt(chapterUrl) }
                )
            )
        }
    }

    private func nextPlaybackRate(for currentRate: Float) -> Float {
        if currentRate < Constants.Rate.max {
            return currentRate + Constants.Rate.step
        } else {
            return Constants.Rate.min
        }
    }

    private func alert(
        with title: String,
        dismissAction: Action = .alertDismissed
    ) -> AlertState<Action> {
        AlertState {
            TextState(title)
        } actions: {
            ButtonState(action: dismissAction) {
                TextState(Constants.Alert.dismiss)
            }
        }
    }

    private func alert(
        with title: String,
        retryAction: Action
    ) -> AlertState<Action> {
        AlertState {
            TextState(title)
        } actions: {
            ButtonState(action: retryAction) {
                TextState(Constants.Alert.retry)
            }

            ButtonState(action: .alertDismissed) {
                TextState(Constants.Alert.dismiss)
            }
        }
    }
}
