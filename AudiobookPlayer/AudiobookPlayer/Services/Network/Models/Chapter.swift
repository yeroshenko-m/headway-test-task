//
//  Chapter.swift
//  AudiobookPlayer
//
//  Author:  Mykhailo Yeroshenko
//  Created: 03.07.2023
//

import Foundation

struct Chapter {
    let title: String
    let audioURL: URL?
}

extension Chapter {
    init(from dtoModel: ChapterDTO) {
        title = dtoModel.name
        audioURL = URL(string: dtoModel.audio)
    }
}
