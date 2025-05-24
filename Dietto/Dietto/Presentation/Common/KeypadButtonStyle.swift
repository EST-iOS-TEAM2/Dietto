//
//  KeypadButtonStyle.swift
//  Dietto
//
//  Created by 안정흠 on 5/24/25.
//
import SwiftUI

struct KeypadButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(.gray.opacity(0.2))
                    .opacity(configuration.isPressed ? 1 : 0)
                    .padding(.horizontal, 5)
            )
            .animation(.easeInOut(duration: 0.25), value: configuration.isPressed)
    }
}
