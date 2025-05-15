//
//  HomeView.swift
//  Dietto
//
//  Created by 안세훈 on 5/13/25.
//

import SwiftUI
import Charts

struct HomeView: View {
    var body: some View {
        VStack {
            HomeHeader()
            bodyScaleTable(startBodyScale: 70, targetBodyScale: 65, currentBodyScale: 68)
            
            //            bodyScaleTable()
            GeometryReader { proxy in
                ZStack {
                    RingShape()
                        .stroke(style: StrokeStyle(lineWidth: 50, lineCap: .round))
                        .fill(Color.textFieldGray)
                    RingShape(percent: 60, startAngle: -90, drawnClockwise: false)
                        .stroke(style: StrokeStyle(lineWidth: 50, lineCap: .round))
                        .fill(Color.accent)
                }
                
            }
            .padding(50 / 2)
            
            
        }
        .background(Color.backGround)
    }
}

#Preview {
    HomeView()
}

struct HomeHeader: View {
    var body: some View {
        HStack {
            Text("Dietto")
                .font(.NerkoOne40)
                .foregroundStyle(.text)
            Spacer()
            Button {
                print("Profile Clicked")
            } label: {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 38, height: 38)
                    .foregroundStyle(.textFieldGray)
                    .clipShape(Circle())
                    .overlay(
                        Circle().stroke(Color.accentColor, lineWidth: 1)
                    )
            }
        }
        .padding([.leading, .trailing], 16)
    }
}

struct bodyScaleTable: View {
    @State var startBodyScale: Int = 68
    @State var targetBodyScale: Int = 64
    @State var currentBodyScale: Int = 68
    
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
                        Text("\(startBodyScale)").font(.pretendardBold32).foregroundStyle(.text)
                        Text("kg").font(.pretendardBold16).foregroundStyle(.text)
                    }
                }
                Spacer()
                VStack(alignment: .center) {
                    Text("목표 몸무게").font(.pretendardBold16).foregroundStyle(.text)
                    HStack(spacing: 4) {
                        Text("\(targetBodyScale)").font(.pretendardBold32).foregroundStyle(.text)
                        Text("kg").font(.pretendardBold16).foregroundStyle(.text)
                    }
                }
            }.padding([.leading, .trailing])
            
            Divider().foregroundStyle(.text).padding([.leading, .trailing])
            
            HStack(alignment: .top) {
                VStack(alignment: .center) {
                    Text("최근 몸무게").font(.pretendardBold16).foregroundStyle(.text)
                    HStack(spacing: 4) {
                        Text("\(currentBodyScale)").font(.pretendardBold32).foregroundStyle(.text)
                        Text("kg").font(.pretendardBold16).foregroundStyle(.text)
                    }
                }
                Spacer()
                Button("수정") {
                    print("")
                }
            }.padding()//.padding([.leading, .trailing])
            
        }
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 21))
        .overlay(
            RoundedRectangle(cornerRadius: 21)
                .stroke(Color.accent, lineWidth: 1)
        )
        .shadow(radius: 8, x: 2, y: 10)
        .padding()
    }
}
