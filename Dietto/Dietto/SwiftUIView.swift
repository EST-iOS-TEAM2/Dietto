//
//  SwiftUIView.swift
//  Dietto
//
//  Created by 안정흠 on 5/13/25.
//

import SwiftUI

struct SwiftUIView: View {
    @State var str = ""
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Text("HELLo")
                    .foregroundStyle(Color.text)
                
                Spacer()
            }
            TextField(text: $str) {
                Text("Input")//.foregroundStyle(Color.placeholderGray)
            }
            .foregroundStyle(.text)
            .background(Color.accent)
            
            Spacer()
        }
        .ignoresSafeArea(.all)
        .background(Color.backGround)
    }
}

#Preview {
    SwiftUIView()
}
