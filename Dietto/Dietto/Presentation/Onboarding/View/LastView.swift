//
//  LastView.swift
//  Dietto
//
//  Created by InTak Han on 5/14/25.
//

import SwiftUI

struct LastView: View {
    
    var nickName = ""
    
    @State private var animating : Bool = false
    
    var body: some View {
        ZStack {
            Color.backGround
                .ignoresSafeArea(.all)
            ZStack {
                VStack{
                    if animating {
                        Text("\(nickName)님의 ")
                        + Text("Challenge")
                            .foregroundStyle(.text)
                        + Text("를\n 응원합니다!")
                    }
                }.multilineTextAlignment(.center)
                    .foregroundStyle(.appMain)
                    .font(.pretendardBlack24)
                //            VStack {
                //                Spacer()
                //                withAnimation(.easeInOut) {
                //                    Text("\(nickName)님의 Challenge를 응원합니다!")
                //                        .multilineTextAlignment(.center)
                //                        .foregroundColor(.appMain)
                //                        .font(.pretendardBlack24)
                //                        .padding()
                //                }
                //                Spacer()
                //                Button {
                //                    // 다음으로 넘어가는 함수
                //                } label: {
                //                    Text("시작하기")
                //                        .frame(maxWidth: .infinity)
                //                        .padding()
                //                        .background(Color.appMain)
                //                        .foregroundColor(.white)
                //                        .cornerRadius(13)
                //                        .font(.pretendardMedium16)
                //                }
                //                .padding(.horizontal, 20)
                //                .padding(.bottom, 20)
                //            }
                //            .frame(maxHeight: .infinity, alignment: .center)
            }
            .animation(.easeInOut(duration: 1), value: animating)
        }.onAppear{
            animating = true
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                animating = false
            }
        }
    }
}


#Preview {
    LastView()
}
