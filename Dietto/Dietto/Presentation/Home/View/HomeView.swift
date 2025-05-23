//
//  HomeView.swift
//  Dietto
//
//  Created by 안세훈 on 5/13/25.
//

import SwiftUI
import Charts

struct HomeView: View {
    @Bindable var viewModel = HomeViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            HomeHeader()
            ScrollView {
                WeightTable()

                WeightHistoryView()
                
                if let pedometer = viewModel.pedometerData {
                    ActivityTable(
                        currentSteps: pedometer.steps,
                        currentDistance: pedometer.distance,
                        targetDistance: 5
                    )
                }
                else {
                    ActivityTable(currentSteps: 10, currentDistance: 10, targetDistance: 20)
                        .overlay {
                            RoundedRectangle(cornerRadius: 21)
                                .fill(.ultraThinMaterial)
                                .foregroundStyle(.white)
                                .opacity(0.98)
                                .padding()
                                .overlay {
                                    VStack {
                                        Text("건강 앱 권한이 필요합니다.")
                                            .font(.pretendardBold16)
                                            .foregroundStyle(.text)
                                        Button("설정") {
                                            if let url = URL(string: UIApplication.openSettingsURLString) {
                                                if UIApplication.shared.canOpenURL(url) {
                                                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                                                }
                                            }
                                        }
                                    }
                                }
                        }
                }
            }
        }
        .background(Color.backGround)
        .onAppear {
            viewModel.fetchPedometer()
        }
    }
}

#Preview {
    HomeView()
}

enum ChartTimeType: String,CaseIterable {
    case weekly = "주간"
    case monthly = "월간"
    case yearly = "연간"
}

struct WeightHistoryView: View {
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
                            
                        }
                    }
                } label: {
                    HStack(spacing: 2) {
                        Text("주간").font(.pretendardBold20)
                        Image(systemName: "chevron.down")
                            .font(.pretendardBold16)
                    }
                }
            }
            ZStack {
                Chart(weightHistory, id: \.date) { item in
                    LineMark(
                        x: .value("Date", item.date, unit: .day),
                        y: .value("Scale", item.isAnimated ? item.scale : 0)
                    )
                    .symbol(.circle)
                }
                
//                RoundedRectangle(cornerRadius: 21)
//                    .fill(.ultraThinMaterial)
//                    .foregroundStyle(.white)
//                    .opacity(0.95)
//                    .overlay {
//                        Text("데이터가 부족해 히스토리를 볼 수 없습니다.")
//                            .font(.pretendardBold16)
//                            .foregroundStyle(.text)
//                    }
//                    .padding(.vertical, -8)
//                    .padding(.horizontal, -5)
            }
        }
        .padding()
        .onAppear(perform: chartAnimate)
        .onChange(of: trigger, initial: false) { oldValue, newValue in
            
        }
    }
    
    private func chartAnimate() {
        guard !isAnimated else { return }
        isAnimated = true
        
        $weightHistory.enumerated().forEach { index, item in
            let delay = Double(index) * 0.05
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                withAnimation(.bouncy) {
                    item.wrappedValue.isAnimated = true
                }
            }
        }
    }
}
