//
//  ChapterDTO.swift
//  AudiobookPlayer
//
//  Author:  Mykhailo Yeroshenko
//  Created: 03.07.2023
//

import Foundation

struct ChapterDTO {
    let order: Int
    let name: String
    let audio: String
}

extension ChapterDTO: Decodable {}
