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
//                Button {
//                    print("Profile Clicked")
//                } label: {
//                    Image(systemName: "person.circle.fill")
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .frame(width: 38, height: 38)
//                        .foregroundStyle(.textFieldGray)
//                        .clipShape(Circle())
//                        .overlay(
//                            Circle().stroke(Color.accentColor, lineWidth: 1)
//                        )
//                }
            }
            .padding([.leading, .trailing], 16)
        }
        .fixedSize(horizontal: false, vertical: true)
    }
}
