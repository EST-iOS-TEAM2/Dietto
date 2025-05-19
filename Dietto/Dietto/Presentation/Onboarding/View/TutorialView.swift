//
//  TutorialView.swift
//  Dietto
//
//  Created by InTak Han on 5/15/25.
//

import SwiftUI

struct TutorialView: View {
    @State var weigt: String = ""
    @State var distance: String = ""
    
    @State var selectWeight = 60
    
    let items: [Int] = Array(20...100).reversed()
    
    var nickName = "lee"
    
    
    
    var body: some View {
        VStack(alignment: .leading){ //상단 텍스트
            Text("\(nickName)님의")
            HStack{
                Text("목표를")
                    .foregroundColor(.accent)
                Text("알려주세요")
            }
            
        }
        .font(.pretendardBold28)
        .padding()
        
        
        
        VStack { //목표 몸무게 입력 부분
            HStack{
                TextField("목표체중", text: $weigt)
                    .keyboardType(.numberPad)
                    .multilineTextAlignment(.center)
                    .font(.pretendardMedium20)
                    .foregroundColor(.primary)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 15)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(.accent), lineWidth: 2)
                    )
                
                Text("kg")
                    .foregroundColor(.accent)
                    .font(.AppLogo)
            }
            .frame(width: 200)
            
        }
        .padding()
        
        VStack{
            //목표 거리 입력하는 부분
            HStack{
                TextField("거리", text: $distance)
                    .keyboardType(.numberPad)
                    .multilineTextAlignment(.center)
                    .font(.pretendardMedium20)
                    .foregroundColor(.primary)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 15)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(.accent), lineWidth: 2)
                    )
                
                Text("km")
                    .foregroundColor(.accent)
                    .font(.AppLogo)
            }
            .frame(width: 200)
            
        }
        .padding()
        
        VStack{ //버튼 위의 페이징 부분
            
        }.offset(y:180)
        
        VStack{ //하단 버튼 부분 - 관심사 클릭 부분
            Button("다음") {
                
            }
        }.frame(width: 300, height: 50)
            .background(.accent)
            .foregroundColor(.white)
        .cornerRadius(13)
        .font(.pretendardMedium16)
        .offset(y:180)
        .padding()
    }
}

#Preview {
    TutorialView()
}
