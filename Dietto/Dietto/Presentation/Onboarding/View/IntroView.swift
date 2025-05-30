//
//  IntroView.swift
//  Dietto
//
//  Created by InTak Han on 5/15/25.
//

import SwiftUI

struct IntroView: View {
    
    @Environment(DIContainer.self) private var diContainer
    
    @State private var first: Bool = false
    @State private var second: Bool = false
    @State private var nextbtn: Bool = false
    @State private var navigate: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.backGround)
                    .ignoresSafeArea()
                
                // 텍스트는 항상 중앙에 고정
                ZStack {
                    if first {
                        Text("안녕하세요! 환영합니다 !")
                            .foregroundColor(.appMain)
                            .font(.pretendardBlack24)
                            .transition(.opacity)
                    }
                    
                    if second {
                        Text("프로필을 설정해주세요!")
                            .foregroundColor(.appMain)
                            .font(.pretendardBlack24)
                            .transition(.opacity)
                    }
                }
                .animation(.easeInOut(duration: 1), value: first)
                .animation(.easeInOut(duration: 1), value: second)
                
                VStack {
                    
                    Spacer()
                    
                    if nextbtn {
                        NavigationLink(destination: TutorialView(viewModel: diContainer.getOnboardingViewModel())
                            .navigationBarBackButtonHidden(true)) {
                                Text("다음")
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.appMain)
                                    .foregroundColor(.white)
                                    .cornerRadius(13)
                                    .font(.pretendardMedium16)
                            }
                            .padding(.horizontal, 20)
                            .padding(.bottom, 20)
                            .transition(.opacity)
                    }
                }
            }
            .animation(.easeInOut(duration: 1), value: nextbtn)
        }
        .onAppear {
            first = true
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                first = false
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                second = true
                nextbtn = true
            }
        }
    }
}



#Preview {
    IntroView()
}
