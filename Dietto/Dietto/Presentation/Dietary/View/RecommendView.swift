//
//  RecommendView.swift
//  Dietto
//
//  Created by 안세훈 on 5/16/25.
//

import SwiftUI

struct RecommendView: View {
    
    @StateObject private var viewModel = RecommendViewModel()
    
    @State private var isFoldRecommand : Bool = false  // true : 펼친상태로 시작 , false: 가려진 채로 시작.
    
    var body: some View {
        ZStack {
            Color(.backGround).ignoresSafeArea(edges: .all)
            ScrollView {
                VStack {
                    ContainerView(paddingSize: 16, height: isFoldRecommand ? 500 : CGFloat(viewModel.recommendList.count) * 44 + 100) {
                        HStack{
                            VStack{
                                Text("추천 레시피에 등록된 재료를 이용해 식사를 추천합니다.")
                                    .font(.pretendardSemiBold10)
                                    .foregroundStyle(.textFieldGray)
                                    .padding(.top, 8)
                                
                                //MARK: - 안에 컨텐츠.
                                List(viewModel.recommendList) { item in
                                    VStack(alignment: .leading, spacing: 8){
                                        Text(item.title)
                                            .font(.pretendardBold24)
                                        
                                        
                                        Text(item.description)
                                            .font(.pretendardSemiBold16)
                                    }
                                }
                                .listStyle(.plain)
                                .frame(height: isFoldRecommand ? 400 : CGFloat(viewModel.recommendList.count) * 44 + 10)
                                .padding(.top, 8)
                                
                                Spacer()
                                
                                Button{
                                    withAnimation(.bouncy) {
                                        isFoldRecommand.toggle()
                                    }
                                }label: {
                                    Image(systemName: isFoldRecommand ? "chevron.down" : "chevron.up")
                                        .frame(width: 10, height: 10)
                                        .font(.pretendardBold20)
                                }
                                .padding(.bottom, 8)
                                
                            }
                        }
                        .padding()
                    }
                    .padding(.bottom, 10)
                }
            }
            .padding(.top, 16)
        }
        .navigationTitle("추천 식사")
        .navigationBarTitleDisplayMode(.inline)
        .font(.pretendardBold16)
    }
}

#Preview {
    NavigationStack{
        RecommendView()
    }
}
