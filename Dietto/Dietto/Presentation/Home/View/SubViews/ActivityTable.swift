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
    let targetDistance: Int
    
    var body: some View {
        VStack(alignment: .center) {
            Text("오늘의 활동").font(.pretendardBold20).foregroundStyle(.text)
                .padding([.top, .bottom], 16)
                .padding([.leading, .trailing], 8)
            
            VStack {
                Gauge(
                    value: currentDistance,
                    in: 0...Float(targetDistance)) {
                        Text("Goal")
                            .font(.pretendardBold12)
                            .foregroundStyle(.text)
                    }
                    .animation(.easeInOut(duration: 0.25), value: currentDistance)
                    .gaugeStyle(.accessoryCircularCapacity)
                    .tint(.appMain)
                    .scaleEffect(2)
                    .padding()
                
                //                Divider().padding(0)
                
                HStack(spacing: 4) {
                    Text("걸음 수").font(.pretendardBold20).foregroundStyle(.text)
                    Spacer()
                    Text("\(currentSteps)").font(.pretendardBold24).foregroundStyle(.text)
                        .animation(.spring(duration: 0.25), value: currentSteps)
                    Text("Steps").font(.pretendardBold16).foregroundStyle(.text)
                }
                .padding(8)
                HStack(spacing: 4) {
                    Text("움직인 거리").font(.pretendardBold20).foregroundStyle(.text)
                    Spacer()
                    Text(String(format: "%.2f", currentDistance)).font(.pretendardBold24).foregroundStyle(.text)
                        .animation(.spring(duration: 0.25), value: currentDistance)
                    Text("km").font(.pretendardBold16).foregroundStyle(.text)
                }
                .padding([.leading, .trailing], 8)
                .padding([.bottom], 16)
            }.padding([.leading, .trailing])
        }
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 21))
        .overlay(
            RoundedRectangle(cornerRadius: 21)
                .stroke(Color.appMain, lineWidth: 1)
        )
        .shadow(color: Color.black.opacity(0.2), radius: 4, x: 4, y: 4)
        .padding()
    }
}
