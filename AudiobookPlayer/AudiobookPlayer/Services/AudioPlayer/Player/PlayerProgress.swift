//
//  PlayerProgress.swift
//  AudiobookPlayer
//
//  Author:  Mykhailo Yeroshenko
//  Created: 05.07.2023
//

import AVFoundation

enum PlayerProgress: Equatable {
    case value(Double)
    case ended
}
