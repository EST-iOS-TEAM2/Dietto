//
//  GoalView.swift
//  Dietto
//
//  Created by InTak Han on 5/15/25.
//

import SwiftUI


struct GoalView: View {
    
    @Binding var selection: Int //binding
    
    @ObservedObject var viewModel : OnboardingViewModel
    
    @State private var targetWeight = 60
    @State private var targetDistance = 1
    
    var body: some View {
        VStack(spacing: 40) {
            
            VStack(alignment: .leading, spacing: 4) {
                Text("\(viewModel.nickname)님의")
                Text("목표").foregroundColor(.appMain) + Text("를 알려주세요 !")
            }
            .font(.pretendardBold24)
            .ignoresSafeArea(.container, edges: .top)
            .padding(.top, 20)
            .padding(.leading, 20)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack(spacing: 30) {
                VStack(spacing : 10){
                    Text("목표로 정할 몸무게를 알려주세요 !")
                        .font(.pretendardSemiBold10)
                        .foregroundStyle(.textFieldGray)
                    ContainerView(paddingSize: 20, height: 100) {
                        HStack{
                            Picker("", selection: $viewModel.weight) {
                                ForEach(viewModel.weights, id: \.self) { w in
                                    Text("\(w)").tag(w)
                                        .font(.pretendardBold20)
                                }
                            }
                            .pickerStyle(.wheel)
                            .frame(width: 80, height: 100)
                            
                            Text("kg")
                                .font(.AppLogo)
                                .foregroundColor(.appMain)
                        }
                        
                    }
                }
                
                VStack(spacing : 10){
                    Text("목표로 정할 거리를 알려주세요 !")
                        .font(.pretendardSemiBold10)
                        .foregroundStyle(.textFieldGray)
                    ContainerView(paddingSize: 20, height: 100) {
                        HStack{
                            Picker("", selection: $viewModel.distance) {
                                ForEach(viewModel.distances, id: \.self) { d in
                                    Text("\(d)").tag(d)
                                        .font(.pretendardBold20)
                                }
                            }
                            .pickerStyle(.wheel)
                            .frame(width: 80, height: 100)
                            
                            Text("km")
                                .font(.AppLogo)
                                .foregroundColor(.appMain)
                        }
                        
                    }
                }
                
                Spacer()
                
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 20)
        }
        .background(Color(.backGround).ignoresSafeArea())
    }
}

