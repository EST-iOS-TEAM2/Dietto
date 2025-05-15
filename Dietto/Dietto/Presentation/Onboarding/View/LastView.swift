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
        }
        
        VStack{
            Button {
                //메인화면으로 이동
                
            } label: {
                Text("시작하기")
            }.frame(width: 300, height: 50)
                .background(.accent)
                .foregroundColor(.white)
                .cornerRadius(13)
        }
    }
}

#Preview {
    LastView()
}
