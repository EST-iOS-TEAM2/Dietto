//
//  RoundedButton.swift
//  HelloSwiftUI
//
//  Created by InTak Han on 5/14/25.
//
import SwiftUI

struct RoundedButton: View{
    //알약버튼 부분
    @State private var isSelected = false
    
    let text: String

    init(text: String){
        self.text = text
    }
    
    var body: some View {
        Button(action: {
            isSelected.toggle()
        }){
            Text(text)
                .font(.system(size: 13, weight: .medium))
                .foregroundColor(isSelected ? Color.white : Color.accentColor)
        }
        .padding(5)
        .padding(.horizontal, 8)
        .background(isSelected ? Color.accentColor : Color.white)
        .cornerRadius(100)
        .overlay(
            RoundedRectangle(cornerRadius: 100)
                .stroke(Color(.accent), lineWidth: 1))
    }
}


