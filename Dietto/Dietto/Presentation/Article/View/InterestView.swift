//
//  InterestsView.swift
//  Dietto
//
//  Created by InTak Han on 5/14/25.
//

import SwiftUI

struct InterestsView: View {
    
    @ObservedObject var viewModel : ArticleViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("건강에 관련된\n")
                + Text("관심사").foregroundColor(.appMain)
                + Text("를 알려주세요 !")
            }
            .font(.pretendardBold24)
            .padding(.top, 20)
            .padding(.horizontal, 20)
            .frame(maxWidth: .infinity, alignment: .leading)
            
//            ScrollView {
//                VStack(alignment: .leading, spacing: 30) {
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
                    .padding()
            Spacer()
            Button {
                print("Submit!")
                dismiss()
            } label: {
                Text("저장")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.appMain)
                    .foregroundColor(.white)
                    .cornerRadius(13)
                    .font(.pretendardMedium16)
            }
            .padding()
        }
        .navigationTitle("관심사 수정")
        .toolbarTitleDisplayMode(.inline)
        .background(Color.backGround)
    }
}

#Preview {
    NavigationView {
        InterestsView(viewModel: ArticleViewModel())
    }
}
