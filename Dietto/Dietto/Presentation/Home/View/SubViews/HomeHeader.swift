//
//  HomeHeader.swift
//  Dietto
//
//  Created by 안정흠 on 5/15/25.
//
import SwiftUI

struct HomeHeader: View {
    var body: some View {
        ZStack{
            Color.backGround
            HStack {
                Text("Dietto")
                    .font(.NerkoOne40)
                    .foregroundStyle(.text)
                Spacer()
            }
            .padding([.leading, .trailing], 16)
        }
        .fixedSize(horizontal: false, vertical: true)
    }
}
