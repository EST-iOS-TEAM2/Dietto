//
//  WeightTable.swift
//  Dietto
//
//  Created by 안정흠 on 5/15/25.
//
import SwiftUI

struct WeightTable: View {
    @Binding var startWeight: Int
    @Binding var targetWeight: Int
    @Binding var currentWeight: Int
    
    @Binding var isTapModify: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("몸무게").font(.pretendardBold20).foregroundStyle(.text)
                Spacer()
                Text(Date().formattedString()).font(.pretendardBold20).foregroundStyle(.text)
            }.padding()
            HStack {
                VStack(alignment: .center) {
                    Text("시작 몸무게").font(.pretendardBold16).foregroundStyle(.text)
                    HStack(spacing: 4) {
                        Text("\(startWeight)").font(.pretendardBold32).foregroundStyle(.text)
                        Text("kg").font(.pretendardBold16).foregroundStyle(.text)
                    }
                }
                Spacer()
                VStack(alignment: .center) {
                    Text("목표 몸무게").font(.pretendardBold16).foregroundStyle(.text)
                    HStack(spacing: 4) {
                        Text("\(targetWeight)").font(.pretendardBold32).foregroundStyle(.text)
                        Text("kg").font(.pretendardBold16).foregroundStyle(.text)
                    }
                }
            }.padding([.leading, .trailing])
            
            Divider().foregroundStyle(.text).padding([.leading, .trailing])
            
            HStack(alignment: .top) {
                VStack(alignment: .center) {
                    Text("최근 몸무게").font(.pretendardBold16).foregroundStyle(.text)
                    HStack(spacing: 4) {
                        Text("\(currentWeight)").font(.pretendardBold32).foregroundStyle(.text)
                            .animation(.spring(duration: 0.25), value: currentWeight)
                        Text("kg").font(.pretendardBold16).foregroundStyle(.text)
                    }
                }
                Spacer()
                Button("수정") {
                    isTapModify.toggle()
                }
            }.padding()//.padding([.leading, .trailing])
            
        }
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 21))
        .overlay(
            RoundedRectangle(cornerRadius: 21)
                .stroke(Color.accent, lineWidth: 1)
        )
        .shadow(color: Color.black.opacity(0.2), radius: 4, x: 4, y: 4)
        .padding()
    }
}
