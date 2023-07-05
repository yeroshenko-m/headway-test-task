//
//  ErrorView.swift
//  AudiobookPlayer
//
//  Author:  Mykhailo Yeroshenko
//  Created: 04.07.2023
//

import ComposableArchitecture
import SwiftUI

struct RetryView: View {
    let store: StoreOf<Retry>

    var body: some View {
        WithViewStore(self.store) { $0 } content: { viewStore in
            VStack {
                Spacer()
                Text(viewStore.title)
                    .font(Constants.Title.font)
                    .foregroundColor(Constants.Title.color)
                Button {
                    viewStore.send(.retryTapped)
                } label: {
                    Text(Constants.Button.title)
                        .foregroundColor(Constants.Button.titleColor)
                        .frame(maxWidth: .infinity)
                        .frame(height: Constants.Button.height)
                        .background(Constants.Button.color)
                        .cornerRadius(Constants.Button.cornerRadius)
                        .padding(.horizontal, Constants.Button.padding)
                }
                .padding(.bottom, Constants.Button.padding)
            }
        }
    }
}

#if DEBUG
    struct AnimalsListRetryView_Previews: PreviewProvider {
        static var previews: some View {
            RetryView(
                store: Store(
                    initialState: Retry.State(title: "Audiobook loading failed ☹️"),
                    reducer: Retry()
                )
            )
        }
    }
#endif
