//
//  FirstView.swift
//  Dietto
//
//  Created by InTak Han on 5/15/25.
//

import SwiftUI

struct FirstView: View {
    
    @State private var first : Bool = false
    @State private var second : Bool = false
    
    @State private var isAnimating : Bool = false
    
    var body: some View {
        ZStack {
            if first {
                Text("로그인 성공!")
                    .foregroundColor(.accent)
                    .font(.pretendardBlack24)
                    .opacity(first ? 1 : 0)
                    .transition(.opacity)
                    .animation(.easeInOut(duration: 3), value: first)
            }
            
            if second {
                Text("프로필을 설정해주세요!")
                    .foregroundColor(.accent)
                    .font(.pretendardBlack24)
                    .opacity(second ? 1 : 0)
                    .transition(.opacity)
                    .animation(.easeInOut(duration: 3), value: second)
            }
        }
        .onAppear {
            first = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                second = true
            }
        }
    }
}

#Preview {
    FirstView()
}
