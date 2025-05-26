//
//  Interests.swift
//  Dietto
//
//  Created by 안세훈 on 5/26/25.
//

import SwiftUI

struct Interests: View {
    var topic: String
    var titles: [String]
    var onClicked: (String) -> Void
    var isSelected: (String) -> Bool

    @State private var contentHeight: CGFloat = 0

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(topic)
                .font(.pretendardBold16)

            FlowLayout(spacing: 8, lineSpacing: 8, contentHeight: $contentHeight) {
                ForEach(titles, id: \.self) { title in
                    let selected = isSelected(title)

                    Button(action: {
                        onClicked(title)
                    }) {
                        Text(title)
                            .font(.pretendardBold14)
                            .foregroundColor(selected ? .white : .text)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 4)
                    }
                    .background(
                        Capsule().fill(selected ? Color.appMain : Color.backGround)
                    )
                    .overlay(
                        Capsule().stroke(Color.appMain, lineWidth: 1)
                    )
                    .fixedSize()
                }
            }
        }
    }
}
