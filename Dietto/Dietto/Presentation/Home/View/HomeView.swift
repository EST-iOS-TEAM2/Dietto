//
//  HomeView.swift
//  Dietto
//
//  Created by 안세훈 on 5/13/25.
//

import SwiftUI
import Charts

struct HomeView: View {
    @State var viewModel: HomeViewModel
    @State var isTapModify: Bool = false
    var body: some View {
        VStack(spacing: 0) {
            HomeHeader()
            ScrollView {
                WeightTable(
                    startWeight: $viewModel.userData.startWeight,
                    targetWeight: $viewModel.userData.targetWeight,
                    currentWeight: $viewModel.userData.currentWeight,
                    isTapModify: $isTapModify
                )
                
                WeightHistoryView()
                    .environment(viewModel)
                
                if let pedometer = viewModel.pedometerData {
                    ActivityTable(
                        currentSteps: pedometer.steps,
                        currentDistance: viewModel.currentDistance,
                        targetDistance: viewModel.userData.targetDistance
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
        .sheet(isPresented: $isTapModify, content: {
            NavigationView {
                WeightChangeView(viewModel: viewModel)
            }
        })
        .background(Color.backGround)
        .onAppear {
            viewModel.fetchPedometer()
        }
    }
}

#Preview {
    HomeView(viewModel: HomeViewModel())
}


