//
//  AudiobookPlayerApp.swift
//  AudiobookPlayer
//
//  Author:  Mykhailo Yeroshenko
//  Created: 30.06.2023
//

import ComposableArchitecture
import SwiftUI

@main
struct AudiobookPlayerApp: App {
    var body: some Scene {
        WindowGroup {
            PlayerView(
                store: Store(
                    initialState: Player.State(),
                    reducer: Player()
                )
            )
        }
    }
}
