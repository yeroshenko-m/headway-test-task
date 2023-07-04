//
//  Audiobook.swift
//  AudiobookPlayer
//
//  Author:  Mykhailo Yeroshenko
//  Created: 03.07.2023
//

import Foundation

struct Audiobook {
    let title: String
    let imageURL: URL?
    let chapters: [Chapter]
}

extension Audiobook {
    init(from dtoModel: AudiobookDTO) {
        title = dtoModel.bookTitle
        imageURL = URL(string: dtoModel.bookCover)
        chapters = dtoModel.chapters
            .sorted { $0.order < $1.order }
            .compactMap { Chapter(from: $0) }
    }
}

extension Audiobook: Equatable {}
