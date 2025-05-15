//
//  RoundedButton.swift
//  HelloSwiftUI
//
//  Created by InTak Han on 5/14/25.
//
import SwiftUI

struct RoundedButton: View{
    
    let color: Color
    let text: String
    let fontSize: CGFloat
    let action: () -> Void

    init(color: Color,
         text: String,
         fontSize: CGFloat,
         action: @escaping () -> Void){
        self.color = color
        self.text = text
        self.fontSize = fontSize
        self.action = action
    }
    
    var body: some View {
        Button(action: { action() }){
            Text(text)
                .font(.system(size: fontSize, weight: .medium))
                .foregroundColor(color)
        }
        .padding(5)
        .padding(.horizontal, 8)
        .overlay(
            RoundedRectangle(cornerRadius: 100)
                .stroke(Color(.accent), lineWidth: 1))
    }
}
