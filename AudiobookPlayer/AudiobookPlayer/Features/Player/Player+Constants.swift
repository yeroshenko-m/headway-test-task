//
//  Player+Constants.swift
//  AudiobookPlayer
//
//  Author:  Mykhailo Yeroshenko
//  Created: 04.07.2023
//

import Foundation

extension Player {
    enum Constants {
        static let maxRate: Float = 2.0
        static let minRate: Float = 0.25
        static let rateStep: Float = 0.25
        static let progressStep: Double = 1.0
        static let seekForwardInterval: Double = 10.0
        static let seekBackwardInterval: Double = 5.0
    }
}
