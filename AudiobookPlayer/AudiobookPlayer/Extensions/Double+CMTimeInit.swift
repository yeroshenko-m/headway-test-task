//
//  Double+CMTimeInit.swift
//  AudiobookPlayer
//
//  Author:  Mykhailo Yeroshenko
//  Created: 03.07.2023
//

import CoreMedia.CMTime
import Foundation

extension Double {
    func cmTime(timescale: UInt64 = NSEC_PER_SEC) -> CMTime {
        CMTime(seconds: self, preferredTimescale: CMTimeScale(timescale))
    }
}
