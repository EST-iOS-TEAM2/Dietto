//
//  ContainerView.swift
//  Dietto
//
//  Created by 안세훈 on 5/14/25.
//

import SwiftUI

struct ContainerView <content : View> : View {
    
    var paddingSize: CGFloat
    var height: CGFloat
    let Content: () -> content
    
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width - (paddingSize * 2)
            
            ZStack {
                RoundedRectangle(cornerRadius: 21)
                    .fill(Color.white)
                    .frame(width: width, height: height)
                    .overlay(
                        RoundedRectangle(cornerRadius: 21)
                            .stroke(Color.accentColor, lineWidth: 1)
                    )
                    .shadow(color: Color.black.opacity(0.2), radius: 4, x: 4, y: 4)
                
                Content()
                    .frame(width: width, height: height)
            }
            .frame(width: geometry.size.width, height: height)
        }
        .frame(height: height)
    }
}

