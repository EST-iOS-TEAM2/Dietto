//
//  ActivityTable.swift
//  Dietto
//
//  Created by 안정흠 on 5/15/25.
//
import SwiftUI

struct ActivityTable: View {
    let currentSteps: Int
    let currentDistance: Float
    let targetDistance: Float 
    
    var body: some View {
        VStack(alignment: .center) {
            HStack {
                Text("오늘의 활동").font(.pretendardBold20).foregroundStyle(.text)
                Spacer()
                Text(Date().formattedString()).font(.pretendardBold20).foregroundStyle(.text)
            }.padding([.leading, .trailing, .top])
            HStack(alignment: .top) {
                Gauge(value: currentDistance, in: 0...targetDistance) {
                    Text("Goal")
                        .font(.pretendardBold12)
                        .foregroundStyle(.text)
                }
                .gaugeStyle(.accessoryCircularCapacity)
                .tint(.accent)
                .frame(width: 100, height: 100)
                .scaleEffect(2)
                .padding()
                
                Divider().padding()
                
                VStack(alignment: .leading) {
                    HStack(spacing: 4) {
                        Text("\(currentSteps)").font(.pretendardBold20).foregroundStyle(.text)
                        Text("Steps").font(.pretendardBold16).foregroundStyle(.text)
                    }
                    HStack(spacing: 4) {
                        Text(String(format: "%.2f", currentDistance)).font(.pretendardBold20).foregroundStyle(.text)
                        Text("km").font(.pretendardBold16).foregroundStyle(.text)
                    }
                }
                .padding()
            }.padding([.leading, .trailing])
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
