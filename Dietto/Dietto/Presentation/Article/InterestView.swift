//
//  InterestsView.swift
//  Dietto
//
//  Created by InTak Han on 5/14/25.
//

import SwiftUI

struct InterestsView: View {
    
    @ObservedObject var viewModel : OnboardingViewModel
    
    var body: some View {
        VStack(spacing: 40) {
            VStack(alignment: .leading) {
                Text("건강에 관련된")
                + Text(" 관심사").foregroundColor(.appMain)
                + Text("를 알려주세요 !")
            }
            .font(.pretendardBold24)
            .padding(.top, 20)
            .padding(.horizontal, 20)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 30) {
                    ForEach(viewModel.interestData, id: \.topic) { block in
                        Interests(
                            topic: block.topic,
                            titles: block.titles,
                            onClicked: { title in
                                viewModel.toggleInterest(title)
                            },
                            isSelected: { title in
                                viewModel.selectedArticles.contains(where: { $0.title == title })
                            }
                        )
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
            }
        }
        .background(Color(.backGround).ignoresSafeArea())
    }
}

#Preview {
    InterestsView(viewModel: OnboardingViewModel())
}
