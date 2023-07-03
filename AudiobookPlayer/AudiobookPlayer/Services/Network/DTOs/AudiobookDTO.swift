//
//  AudiobookDTO.swift
//  AudiobookPlayer
//
//  Author:  Mykhailo Yeroshenko
//  Created: 03.07.2023
//

import Foundation

struct AudiobookDTO {
    let bookTitle: String
    let bookCover: String
    let chapters: [ChapterDTO]
}

extension AudiobookDTO: Decodable {}
