//
//  ButtonView.swift
//  HelloSwiftUI
//
//  Created by InTak Han on 5/14/25.
//
//com.justhm.Dietto
//번들 id
import SwiftUI

struct ButtonView: View {
    @Environment(\.dismiss) var dismiss //이전화면 버튼 누를때 로직
    var nickName = "lee"
    
    var body: some View {
        VStack(alignment: .leading){ //상단 텍스트
            Text("\(nickName)님의")
            HStack{
                Text("관심사를")
                    .foregroundColor(.accent)
                Text("알려주세요")
            }
        }
        .font(.title)
        .padding()
        
        //버튼에 효과를 해야될듯 - 특히 누를떄
        VStack(alignment: .leading){
            VStack(alignment: .leading){
                Text("운동")
                HStack {
                    RoundedButton(color: .accentColor, text: "근육략 증가", fontSize: 13, action: { print("first button click") })
                    
                    RoundedButton(color: .accentColor, text: "규칙적인 운동", fontSize: 13, action: { })
                    
                    RoundedButton(color: .accentColor, text: "체지방률 감소", fontSize: 13, action: { })
                }
            }
            .padding()
            
            VStack(alignment: .leading, spacing: 10){
                Text("식습관 계선")
                HStack {
                    RoundedButton(color: .accentColor, text: "음식 섭취 패턴 안정화", fontSize: 13, action: { print("first button click") })
                    
                    RoundedButton(color: .accentColor, text: "안정된 양양소 섭취", fontSize: 13, action: { })
                    
                }
                HStack {
                    RoundedButton(color: .accentColor, text: "수분 섭취", fontSize: 13, action: { })
                    
                    RoundedButton(color: .accentColor, text: "외식 줄이기", fontSize: 13, action: { })
                    
                }
            }
            .padding()
            
            VStack(alignment: .leading){
                Text("건강 관리")
                HStack {
                    RoundedButton(color: .accentColor, text: "금연/금주", fontSize: 13, action: { })
                    
                    RoundedButton(color: .accentColor, text: "혈당 안정화", fontSize: 13, action: { })
                    
                    RoundedButton(color: .accentColor, text: "음식 일기", fontSize: 13, action: { })
                    
                    RoundedButton(color: .accentColor, text: "피부", fontSize: 13, action: { })
                }
            }
            .padding()
            
            VStack(alignment: .leading){
                Text("수면 및 스트레스")
                HStack {
                    RoundedButton(color: .accentColor, text: "수면 개선", fontSize: 13, action: { })
                    
                    RoundedButton(color: .accentColor, text: "스트레스", fontSize: 13, action: { })
                }
            }
            .padding()
            
            
        }.padding()
        
        
        VStack{ //버튼 위의 페이징 부분
            Text("123page")
        }
        
        VStack{ //하단 버튼 부분
            Button {
                
            } label: {
                Text("다음")
            }
        }
        .frame(width: 300, height: 50)
        .background(.accent)
        .foregroundColor(.white)
        .cornerRadius(13)
        
        VStack{ //하단 버튼 부분 - 이전화면으로 가기
            Button {
                dismiss()
            } label: {
                Text("이전화면")
            }
        }
        .frame(width: 300, height: 50)
        .foregroundColor(.white)
        .background(.gray)
        .cornerRadius(13)
        .padding()
    }
}

#Preview {
    ButtonView()
}
