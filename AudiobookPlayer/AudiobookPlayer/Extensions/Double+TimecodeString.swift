//
//  Double+TimecodeString.swift
//  AudiobookPlayer
//
//  Author:  Mykhailo Yeroshenko
//  Created: 04.07.2023
//

import Foundation

extension Double {
    public var timeCode: String {
        guard self != .infinity else { return "--:--" }

        let totalSeconds = Int(self)
        let hours: Int = Int(totalSeconds / 3600)
        let minutes: Int = Int(totalSeconds % 3600 / 60)
        let seconds: Int = Int((totalSeconds % 3600) % 60)

        if hours > 0 {
            return String(format: "%i:%02i:%02i", hours, minutes, seconds)
        } else {
            return String(format: "%02i:%02i", minutes, seconds)
        }
    }
}
