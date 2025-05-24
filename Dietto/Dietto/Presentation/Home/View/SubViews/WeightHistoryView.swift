//
//  WeightHistoryView.swift
//  Dietto
//
//  Created by 안정흠 on 5/23/25.
//
import SwiftUI
import Charts

struct WeightHistoryView: View {
    @Environment(HomeViewModel.self) private var viewModel
    
    @State private var trigger: Bool = false
    @State private var isAnimated: Bool = false
    @State var weightHistory: [WeightEntity] = [
        WeightEntity(date: Date()-(86400*3), scale: 70),
        WeightEntity(date: Date()-(86400*2), scale: 65),
        WeightEntity(date: Date()-86400, scale: 55),
        WeightEntity(date: Date(), scale: 50),
        WeightEntity(date: Date()+86400, scale: 55),
        WeightEntity(date: Date()+(86400*2), scale: 63),
        WeightEntity(date: Date()+(86400*3), scale: 72),
        WeightEntity(date: Date()+(86400*4), scale: 82),
        WeightEntity(date: Date()+(86400*5), scale: 72),
        WeightEntity(date: Date()+(86400*6), scale: 62),
        WeightEntity(date: Date()+(86400*7), scale: 52),
        WeightEntity(date: Date()+(86400*8), scale: 52),
        WeightEntity(date: Date()+(86400*9), scale: 52),
        WeightEntity(date: Date()+(86400*10), scale: 52),
        WeightEntity(date: Date()+(86400*11), scale: 52)
    ]
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("몸무게 히스토리").font(.pretendardBold20).foregroundStyle(.text)
                Spacer()
                Menu {
                    ForEach(ChartTimeType.allCases, id: \.self) { type in
                        Button(type.rawValue) {
                            if !viewModel.isAnimating {
                                viewModel.bodyScaleHistoryFetch(type: type)
                                viewModel.chartAnimate()
                            }
                        }
                    }
                } label: {
                    HStack(spacing: 2) {
                        Text(viewModel.chartTimeType.rawValue).font(.pretendardBold20)
                        Image(systemName: "chevron.down")
                            .font(.pretendardBold16)
                    }
                }
            }
            ZStack {
                if viewModel.bodyScaleHistory.isEmpty {
                    Chart(weightHistory, id: \.date) { item in
                        LineMark(
                            x: .value("Date", item.date, unit: .day),
                            y: .value("Scale", item.isAnimated ? item.scale : 1)
                        )
                        .symbol(.circle)
                    }
                    
                    RoundedRectangle(cornerRadius: 21)
                        .fill(.ultraThinMaterial)
                        .foregroundStyle(.white)
                        .opacity(0.95)
                        .overlay {
                            Text("데이터가 부족해 히스토리를 볼 수 없습니다.")
                                .font(.pretendardBold16)
                                .foregroundStyle(.text)
                        }
                        .padding(.vertical, -8)
                        .padding(.horizontal, -5)
                        .animation(.easeInOut, value: viewModel.bodyScaleHistory.isEmpty)
                }
                else {
                    Chart(viewModel.bodyScaleHistory, id: \.date) { item in
                        LineMark(
                            x: .value("Date", item.date, unit: .day),
                            y: .value("Scale", item.isAnimated ? item.scale : 0)
                        )
                        .symbol(.circle)
                    }
                }
            }
        }
        .padding()
        .onAppear(perform: viewModel.chartAnimate)
    }
}
