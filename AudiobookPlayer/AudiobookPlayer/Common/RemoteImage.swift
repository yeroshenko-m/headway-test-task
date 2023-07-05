//
//  RemoteImage.swift
//  AudiobookPlayer
//
//  Author:  Mykhailo Yeroshenko
//  Created: 04.07.2023
//

import Foundation
import SwiftUI

struct RemoteImage: View {
    let url: URL?

    var body: some View {
        AsyncImage(url: url) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .failure:
                Image(systemName: Constants.placeholderImage)
                    .resizable()
                    .foregroundColor(Constants.foregroundColor)
            case let .success(image):
                image.resizable()
            @unknown default:
                Image(Constants.placeholderImage)
                    .resizable()
            }
        }
    }
}

extension RemoteImage {
    enum Constants {
        static let placeholderImage: String = "doc.plaintext.fill"
        static let backgroundColor: Color = .init(uiColor: .systemGray5)
        static let foregroundColor: Color = .init(uiColor: .gray)
    }
}
