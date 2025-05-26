//
//  TutorialView.swift
//  Dietto
//
//  Created by 안세훈 on 5/25/25.
//

import SwiftUI

struct TutorialView: View {
    
    @State private var selection = 0
    @StateObject private var viewModel = OnboardingViewModel()
    
    var body: some View {
        ZStack {
            Color(.backGround).ignoresSafeArea(edges: .all)
            VStack {
                TabView(selection: $selection) {
                    //목표 설정 뷰
                    GoalView(selection: $selection, viewModel: viewModel)
                        .tag(0)
                    InterestsView(viewModel: viewModel, selection: $selection)
                        .tag(1)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .animation(.linear, value: selection)
                
                Spacer()
                
                VStack(spacing: 16) {
                    PageControl(currentPage: $selection, numberOfPages: 2)
                    
                    HStack {
                        Button {
                            if selection == 0 {
                                viewModel.setGoals(weight: viewModel.weight, distance: viewModel.distance)
                            }
                            if selection < 1 {
                                selection += 1
                            }
                        } label: {
                            Text("다음")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.appMain)
                                .foregroundColor(.white)
                                .cornerRadius(13)
                                .font(.pretendardMedium16)
                        }
                    }
                    .padding(.horizontal, 20)
                }
            }
        }
    }
    
}

#Preview {
    TutorialView()
}
