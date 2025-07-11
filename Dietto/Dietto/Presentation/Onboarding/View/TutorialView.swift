//
//  TutorialView.swift
//  Dietto
//
//  Created by 안세훈 on 5/25/25.
//

import SwiftUI

struct TutorialView: View {
    
    @State private var selection = 0
    @StateObject var viewModel : OnboardingViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            Color(.backGround).ignoresSafeArea(edges: .all)
            VStack {
                TabView(selection: $selection) {
                    
                    ProfileEditView(selection: $selection, viewModel: viewModel)
                        .tag(0)
                    
                    GoalView(selection: $selection, viewModel: viewModel)
                        .tag(1)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .animation(.linear, value: selection)
                
                Spacer()
                
                VStack(spacing: 16) {
                    PageControl(currentPage: $selection, numberOfPages: 2)
                    
                    HStack {
                        Button {
                            if selection < 1 {
                                selection += 1
                            }else{
                                viewModel.saveProfile()
                            }
                        } label: {
                            Text(selection < 1 ? "다음" : "완료")
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
            .overlay {
                if viewModel.isProfileSaved{
                    ZStack {
                        withAnimation(.easeInOut){
                            LastView(nickName: viewModel.name)
                        }
                    }
                }
            }
        }
    }
    
}

//#Preview {
//    TutorialView(viewModel: OnboardingViewModel())
//}
