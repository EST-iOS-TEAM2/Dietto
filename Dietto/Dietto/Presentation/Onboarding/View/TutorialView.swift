//
//  TutorialView.swift
//  Dietto
//
//  Created by InTak Han on 5/15/25.
//

import SwiftUI

struct TutorialView: View {
    //@State var weigt: String = ""
    @State var distance: String = ""
    
    @State var targetWeight = 60 //목표 몸무게 기본값
    @State var targetDistance = 1 //목표 거리 기본값
    
    let weights: [Int] = Array(20...100).reversed() //무게 범위
    let distances: [Int] = Array(1...10).reversed() //거리 범위
    
    var name = "lee"
    
    
    
    var body: some View {
        VStack(alignment: .leading){ //상단 텍스트
            Text("\(name)님의")
            HStack{
                Text("목표를")
                    .foregroundColor(.appMain)
                Text("알려주세요")
            }
            
        }
        .offset(y:-150)
        .font(.pretendardBold28)
        
        
        
        VStack { //목표 몸무게 입력 부분
            HStack{
                Picker("Select Weight",selection: $targetWeight) {
                    ForEach(weights, id: \.self) { item in
                        Text("\(item)")
                        
                    }
                }
                    .multilineTextAlignment(.center)
                    .font(.pretendardMedium20)
                    .foregroundColor(.primary)
                    .padding(.horizontal, 40)
                    .padding(.vertical, 15)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(.appMain), lineWidth: 2)
                    )
                
                Text("kg")
                    .foregroundColor(.appMain)
                    .font(.AppLogo)
            }
            .frame(width: 250)
            
        }
        .offset(y:-150)
        .padding(.vertical, 30)
        
        VStack{//목표 거리 입력하는 부분
            
            HStack{
                Picker("Select Distance",selection: $targetDistance) {
                    ForEach(distances, id: \.self) { item in
                        Text("\(item)")
                        
                    }
                }
                    .multilineTextAlignment(.center)
                    .font(.pretendardMedium20)
                    .foregroundColor(.primary)
                    .padding(.horizontal, 47)
                    .padding(.vertical, 15)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(.appMain), lineWidth: 2)
                    )
                
                Text("km")
                    .foregroundColor(.appMain)
                    .font(.AppLogo)
            }
            .frame(width: 250)
            
        }
        
        VStack{ //버튼 위의 페이징 부분
            //Text("123")
        }.offset(y:160)
        
        VStack{ //하단 버튼 부분 - 관심사 클릭 부분
            Button("다음") {
                
            }
        }
        
        .frame(width: 300, height: 50)
            .background(.appMain)
            .foregroundColor(.white)
        .cornerRadius(13)
        .font(.pretendardMedium16)
        .offset(y:160)
        .padding()
    }
}

#Preview {
    TutorialView()
}
