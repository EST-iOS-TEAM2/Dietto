//
//  RecommendView.swift
//  Dietto
//
//  Created by 안세훈 on 5/16/25.
//

import SwiftUI

struct RecommendView: View {
    
    @EnvironmentObject private var viewModel : DietaryViewModel
    
    //    @StateObject private var viewModel = DietaryViewModel() //디버깅용
    
    @State private var isFoldRecommand : Bool = false  // true : 펼친상태로 시작 , false: 가려진 채로 시작.
    //    @State private var contentHeight : CGFloat = 0
    
    var body: some View {
        ZStack {
            Color(.backGround).ignoresSafeArea(edges: .all)
            VStack {
                ContainerView(paddingSize: 16) {
                    HStack {
                        VStack {
                            Text("추천 레시피에 등록된 재료를 이용해 식사를 추천합니다.")
                                .font(.pretendardSemiBold10)
                                .foregroundStyle(.textFieldGray)
                            
                            ScrollView {
                                LazyVStack(alignment: .leading, spacing: 16) {
                                    ForEach(viewModel.recommendList, id: \.title) { item in
                                        VStack(alignment: .leading, spacing: 8) {
                                            Text(item.title)
                                                .font(.pretendardBold24)
                                            Text(item.description)
                                                .font(.pretendardSemiBold16)
                                        }
                                        .padding()
                                        .backgroundStyle(Color.textFieldGray)
                                        .border(Color.appMain)
                                        Divider()
                                    }
                                }
                                .padding(.horizontal)
                            }
                            .clipped()
                        }
                    }
                    .padding()
                }
                .padding(.bottom, 10)
            }
            .padding(.top, 16)
            .opacity(viewModel.recommendList.isEmpty ? 0 : 1)
        }
        .navigationTitle("추천 식사")
        .navigationBarTitleDisplayMode(.inline)
        .font(.pretendardBold16)
        .toastView(toast: $viewModel.toast)
        .progressOverlay(isPresented: $viewModel.isPresneted, message: "Alan이 식단을 생성하고 있어요 !")
    }
}
////디버깅용
//#Preview {
//    NavigationStack{
//        RecommendView()
//    }
//}
