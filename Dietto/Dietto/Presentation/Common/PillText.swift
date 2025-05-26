//
//  PillText.swift
//  Dietto
//
//  Created by 안세훈 on 5/15/25.
//

import SwiftUI

struct PillText: View {
    var text: String
    var onAdd: (() -> Void)? = nil     // 텍스트 버튼 클릭 액션
    var onDelete: (() -> Void)? = nil  // X 버튼 클릭 액션
    
    var body: some View {
        HStack() {
            Button(action: {
                onAdd?()
            }) {
                Text(text)
                    .font(.pretendardBold14)
                    .foregroundStyle(.white)
            }
            .buttonStyle(PlainButtonStyle())
            
            Button(action: {
                onDelete?()
            }) {
                Image(systemName: "xmark")
                    .font(.pretendardBold12)
                    .foregroundStyle(.white)
                    .padding(4)
            }
            .buttonStyle(PlainButtonStyle())
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 4)
        .background(Capsule().fill(Color.appMain))
        .fixedSize()
    }
}

#Preview {
    PillText(
        text: "오리고기",
        onAdd: { print("추가됨") },
        onDelete: { print("삭제됨") }
    )
}

