//
//  TutorialView.swift
//  Dietto
//
//  Created by InTak Han on 5/15/25.
//

import SwiftUI

struct TutorialView: View {
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
        .font(.title)
        .padding()
        
        
        VStack { //목표 몸무게 입력 부분
            HStack{
                //텍스트 필드
                Text("70")
//                Picker(selection: $selectWeight) {
//                    ForEach(items, id: \.self) { item in
//                        Text("\(item)")
//                    }
//                } label: {
//                    Text("weight")
//                }
//                .pickerStyle(.wheel)
                
                Text("kg")
                    .foregroundColor(.accent)
            }
        }
        .padding()
        
        VStack{ //기능 추가가 예상됨,, - 거리 라든지 운동이라던지 그런거
            //목표 거리 입력하는 부분
            HStack{
                //텍스트 필드
                Text("2.3")
                Text("km")
                    .foregroundColor(.accent)
            }
            
        }
        
        VStack{ //버튼 위의 페이징 부분
            Text("123page")
        }.offset(y:180)
        
        VStack{ //하단 버튼 부분
            Button("다음") {
                
            }
        }.frame(width: 300, height: 50)
            .background(.accent)
            .foregroundColor(.white)
        .cornerRadius(13)
        .offset(y:180)
        .padding()
    }
}

#Preview {
    TutorialView()
}
