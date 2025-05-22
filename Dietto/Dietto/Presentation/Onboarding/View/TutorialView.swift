//
//  TutorialView.swift
//  Dietto
//
//  Created by InTak Han on 5/15/25.
//

import SwiftUI

struct TutorialView: View {
    @StateObject var viewModel = TutorialViewModel()
    
    @State var targetWeight = 60 //목표 몸무게 기본값
    @State var targetDistance = 1 //목표 거리 기본값

    var body: some View {
        VStack(alignment: .leading){ //상단 텍스트
            Text("\(viewModel.name)님의")
            HStack{
                Text("목표를")
                    .foregroundColor(.accent)
                Text("알려주세요")
            }
            
        }
        .font(.pretendardBold28)
        .padding(.vertical, 50)

        VStack { //목표 몸무게 입력 부분
            HStack{
                Picker("Select Weight",selection: $targetWeight) {
                    ForEach(viewModel.weights, id: \.self) { item in
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
                            .stroke(Color(.accent), lineWidth: 2)
                    )
                
                Text("kg")
                    .foregroundColor(.accent)
                    .font(.AppLogo)
            }
        }
        .padding(.vertical, 50)
        
        VStack{//목표 거리 입력하는 부분
            
            HStack{
                Picker("Select Distance",selection: $targetDistance) {
                    ForEach(viewModel.distances, id: \.self) { item in
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
                            .stroke(Color(.accent), lineWidth: 2)
                    )
                
                Text("km")
                    .foregroundColor(.accent)
                    .font(.AppLogo)
            }
        }
        .padding(.vertical, 50)
        
        VStack{ //버튼 위의 페이징 부분
            //Text("123")
        }.padding()
        
        VStack{ //하단 버튼 부분 - 관심사 클릭 부분
            Button {
                
            }label: {
                Text("다음")
                    .font(.pretendardBold20)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 15)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.accent)
                    )
            }
        }
        .padding(.horizontal, 20)
        .padding(.top,-10)
        .padding(.bottom, 40)
    }
}

#Preview {
    TutorialView()
}
