//
//  IntroView.swift
//  Dietto
//
//  Created by InTak Han on 5/15/25.
//

import SwiftUI

struct IntroView: View {
    
    @State private var first : Bool = false
    @State private var second : Bool = false
    
    @State private var isAnimating : Bool = false
    
    var body: some View {
        ZStack {
            if first {
                Text("안녕하세요! 환영합니다 !")
                    .foregroundColor(.appMain)
                    .font(.pretendardBlack24)
                    .opacity(first ? 1 : 0)
                    .transition(.opacity)
                    .animation(.easeInOut(duration: 1), value: first)
            }
            
            if second {
                Text("프로필을 설정해주세요!")
                    .foregroundColor(.appMain)
                    .font(.pretendardBlack24)
                    .opacity(second ? 1 : 0)
                    .transition(.opacity)
                    .animation(.easeInOut(duration: 1), value: second)
            }
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 1)) {
                first = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                withAnimation(.easeInOut(duration: 1)) {
                    first = false
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                withAnimation(.easeInOut(duration: 1)) {
                    second = true
                }
            }
        }
    }
}

#Preview {
    IntroView()
}
