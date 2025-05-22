//
//  ButtonView.swift
//  HelloSwiftUI
//
//  Created by InTak Han on 5/14/25.
//

import SwiftUI

struct ButtonView: View {
    //@Environment(\.dismiss) var dismiss //이전화면 버튼 누를때 로직
    var name = "lee"
    
    
    var body: some View {
        VStack(alignment: .leading){ //상단 텍스트
            Text("\(name)님의")
            HStack{
                Text("관심사를")
                    .foregroundColor(.accent)
                Text("알려주세요")
            }
            .font(.pretendardBold28)
        }
        .font(.title)
        .padding()
        
        //버튼에 효과를 해야될듯 - 특히 누를떄
        //스크롤을 할지 말지 고민해야 될듯...
        VStack(alignment: .leading){
            VStack(alignment: .leading){
                Text("운동")
                HStack {
                    RoundedButton(text: "근육략 증가")
                    
                    RoundedButton(text: "규칙적인 운동")
                    
                    RoundedButton(text: "체지방률 감소")
                }
            }
            .padding()
            
            VStack(alignment: .leading, spacing: 10){
                Text("식습관 계선")
                HStack {
                    RoundedButton(text: "음식 섭취 패턴 안정화")
                    
                    RoundedButton(text: "안정된 양양소 섭취")
                    
                }
                HStack {
                    RoundedButton(text: "수분 섭취")
                    
                    RoundedButton(text: "외식 줄이기")
                    
                }
            }
            .padding()
            
            VStack(alignment: .leading){
                Text("건강 관리")
                HStack {
                    RoundedButton(text: "금연/금주")
                    
                    RoundedButton(text: "혈당 안정화")
                    
                    RoundedButton(text: "음식 일기")
                    
                    RoundedButton(text: "피부")
                }
            }
            .padding()
            
            VStack(alignment: .leading){
                Text("수면 및 스트레스")
                HStack {
                    RoundedButton(text: "수면 개선")
                    
                    RoundedButton(text: "스트레스")
                }
            }
            .padding()
            
            
        }.padding()
        
        
        VStack{ //버튼 위의 페이징 부분
            
        }
        .padding()
        
        VStack{ //하단 버튼 부분
            Button {
                // print(RoundedButton(favorite))
            } label: {
                Text("다음")
            }
        }
        .frame(width: 300, height: 50)
        .background(.accent)
        .foregroundColor(.white)
        .cornerRadius(13)
        .font(.pretendardMedium16)
        
        //        VStack{ //하단 버튼 부분 - 이전화면으로 가기
        //            Button {
        //                dismiss()
        //            } label: {
        //                Text("이전화면")
        //            }
        //        }
        //        .frame(width: 300, height: 50)
        //        .foregroundColor(.white)
        //        .background(.gray)
        //        .cornerRadius(13)
        //        .padding()
    }
}

#Preview {
    ButtonView()
}
