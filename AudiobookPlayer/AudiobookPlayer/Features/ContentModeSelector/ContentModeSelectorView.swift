//
//  ContentModeSelectorView.swift
//  AudiobookPlayer
//
//  Author:  Mykhailo Yeroshenko
//  Created: 30.06.2023
//

import ComposableArchitecture
import SwiftUI

private enum Constants {
    enum Icons {
        static let text: String = "text.alignleft"
        static let audio: String = "headphones"
        static let font: Font = .system(size: 17.0, weight: .semibold)
        static let spacing: CGFloat = 30.0
    }

    enum IDs {
        static let audio: Int = 0
        static let text: Int = 1
    }

    enum Background {
        static let color: Color = .white
        static let padding: CGFloat = 15.0
        static let cornerRadius: CGFloat = 6.0
    }

    enum Thumb {
        static let color: Color = Color(uiColor: .systemBlue)
        static let width: CGFloat = 45.0
    }
}

struct ContentModeSelectorView: View {
    @Namespace private var nameSpace
    let store: StoreOf<ContentModeSelector>

    var body: some View {
        WithViewStore(self.store) { $0 } content: { viewStore in
            ZStack {
                Circle()
                    .fill(Constants.Thumb.color)
                    .frame(width: Constants.Thumb.width)
                    .matchedGeometryEffect(
                        id: viewStore.mode == .player ? Constants.IDs.audio : Constants.IDs.text,
                        in: nameSpace,
                        properties: .position,
                        anchor: .center,
                        isSource: false
                    )

                HStack(spacing: Constants.Icons.spacing) {
                    Image(systemName: Constants.Icons.audio)
                        .font(Constants.Icons.font)
                        .matchedGeometryEffect(id: Constants.IDs.audio, in: nameSpace)
                        .foregroundColor(viewStore.mode == .player ? .white : .black)
                    Image(systemName: Constants.Icons.text)
                        .font(Constants.Icons.font)
                        .matchedGeometryEffect(id: Constants.IDs.text, in: nameSpace)
                        .foregroundColor(viewStore.mode == .text ? .white : .black)
                }
                .padding(Constants.Background.padding)
            }
            .animation(.easeInOut, value: viewStore.mode)
            .background {
                Capsule()
                    .fill(.white)
            }
            .onTapGesture {
                viewStore.send(.viewTapped)
            }
        }
    }
}

#if DEBUG
    struct ContentModeSelectorView_Previews: PreviewProvider {
        static var previews: some View {
            ZStack {
                Color(uiColor: .secondarySystemFill)
                    .ignoresSafeArea()
                ContentModeSelectorView(
                    store: Store(
                        initialState: ContentModeSelector.State(mode: .player),
                        reducer: ContentModeSelector()
                    )
                )
            }
        }
    }
#endif
