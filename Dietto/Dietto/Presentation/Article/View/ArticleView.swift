//
//  ArticleView.swift
//  Dietto
//
//  Created by 안세훈 on 5/26/25.
//

import SwiftUI

struct ArticleView: View {
    
    @StateObject var viewModel: ArticleViewModel
    var body: some View {
        NavigationView {
            VStack(alignment: .leading){
                HStack {
                    //MARK: - 로고
                    Text("Dietto")
                        .font(.NerkoOne40)
                        .foregroundStyle(.text)
                    Spacer()
                    
                    NavigationLink(destination: InterestsView(viewModel: viewModel)) {
                        Text("관심사 수정")
                            .font(.pretendardMedium16)
                            .foregroundColor(.white)
                            .padding(.vertical, 4)
                            .padding(.horizontal, 12)
                            .background(Color.appMain)
                            .clipShape(Capsule())
                    }
                    
                }
                .padding([.leading, .trailing], 16)
                Text("내 관심사")
                    .font(.pretendardBold20)
                    .padding(.leading, 16)
                Interests(
                    topic: "",
                    titles: viewModel.selectedInterests.map{$0.title},
                    onClicked: {_ in },
                    isSelected: {_ in true}
                ).padding(.leading, 16)
                
                List(viewModel.articles, id: \.self) { item in
                    LinkRow(previewURL: URL(string: item)!)
                        .background(Color.backGround).ignoresSafeArea(.all)
                }
                .listStyle(.plain)
                .refreshable { viewModel.loadArticles() }
                Spacer()
            }
            .background(Color.backGround)
            .progressOverlay(isPresented: $viewModel.isLoading, message: "아티클 불러오는중..")
            .toastView(toast: $viewModel.toastMessage)
        }
    }
}

//#Preview {
//    NavigationView {
//        ArticleView(viewModel: ArticleViewModel())
//    }
//
//}
