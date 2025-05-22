//
//  LastView.swift
//  HelloSwiftUI
//
//  Created by InTak Han on 5/14/25.
//

import SwiftUI

struct LastView: View {
    var nickName = "lee"
    
    var body: some View {
        VStack{
            HStack{
                Text("\(nickName)님의 Challenge\n를 응원합니다!")
                    .foregroundColor(.accent)
                    .font(.system(size: 28, weight: .bold, design: .rounded))
            }
        }.padding(.vertical, 250)
        
        VStack{
            Button {
                //메인화면으로 이동
                
            } label: {
                Text("시작하기")
                    .font(.pretendardBold20)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 15)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.accent)
                    )
            }.padding(.horizontal, 20)
                .padding(.top,-10)
                .padding(.bottom, 40)
        }
    }
}

#Preview {
    LastView()
}
