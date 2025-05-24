//
//  WeightChangeView.swift
//  Dietto
//
//  Created by 안정흠 on 5/23/25.
//

import SwiftUI

struct KeypadValue {
    
}

struct WeightChangeView: View {
    @Namespace private var animation
    
    var body: some View {
        VStack {
            Text("Hello")
            CustomKeypad()
        }
        .background(Color.backGround)
    }
    
    @ViewBuilder
    func CustomKeypad() -> some View {
        LazyVGrid(columns: Array(repeating: GridItem(), count: 3)) {
            ForEach(1...9, id: \.self) { number in
                Button {
                    
                } label: {
                    Text("\(number)")
                        .font(.pretendardBold20)
                        .frame(maxWidth: .infinity)
                        .frame(height: 70)
                        .contentShape(.rect)
                }
            }
            
            Spacer()
            
            ForEach(["0", "delete.backward.fill"], id: \.self) { number in
                Button {
                    
                } label: {
                    Group {
                        if number == "0" { Text("\(number)")}
                        else { Image(systemName: number) }
                    }
                    .font(.pretendardBold20)
                    .frame(maxWidth: .infinity)
                    .frame(height: 70)
                    .contentShape(.rect)
                }
                .buttonRepeatBehavior(number == "0" ? .disabled : .enabled)
            }
        }
        .buttonStyle(KeypadButtonStyle())
    }
}

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

#Preview {
    WeightChangeView()
}
