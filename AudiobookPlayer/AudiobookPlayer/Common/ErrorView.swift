//
//  ErrorView.swift
//  AudiobookPlayer
//
//  Author:  Mykhailo Yeroshenko
//  Created: 04.07.2023
//

import SwiftUI

private enum Constants {
    static let titleFont: Font = .title
    static let titleColor: Color = .black
    static let buttonColor: Color = .blue
    static let buttonTitleColor: Color = .white
    static let buttonHeight: CGFloat = 50.0
    static let cornerRadius: CGFloat = 6.0
    static let buttonPadding: CGFloat = 20.0
    static let retryButtonTitle: String = "Retry"
}

struct ErrorView: View {
    let title: String
    let onRetry: () -> Void

    var body: some View {
        VStack {
            Spacer()
            Text(title)
                .font(Constants.titleFont)
                .foregroundColor(Constants.titleColor)
            Button(action: onRetry) {
                Text(Constants.retryButtonTitle)
                    .foregroundColor(Constants.buttonTitleColor)
                    .frame(maxWidth: .infinity)
                    .frame(height: Constants.buttonHeight)
                    .background(Constants.buttonColor)
                    .cornerRadius(Constants.cornerRadius)
                    .padding(.horizontal, Constants.buttonPadding)
            }
            .padding(.bottom, Constants.buttonPadding)
        }
    }
}

#if DEBUG
    struct AnimalsListRetryView_Previews: PreviewProvider {
        static var previews: some View {
            ErrorView(title: "Audiobook loading failed ☹️") {}
        }
    }
#endif
