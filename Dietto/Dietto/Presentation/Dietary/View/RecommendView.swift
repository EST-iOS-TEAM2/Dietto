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
    @State private var contentHeight : CGFloat = 0
    
    var body: some View {
        ZStack {
            Color(.backGround).ignoresSafeArea(edges: .all)
            
            ScrollView {
                VStack {//컨테이너 뷰의 높이
                    ContainerView(paddingSize: 16,
                                  height: 1000)
                    {
                        HStack{
                            VStack{
                                Text("추천 레시피에 등록된 재료를 이용해 식사를 추천합니다.")
                                    .font(.pretendardSemiBold10)
                                    .foregroundStyle(.textFieldGray)
                                    .border(.black)
                                
                                //MARK: - 안에 컨텐츠.
                                ScrollView {
                                    LazyVStack(alignment: .leading, spacing: 16) {
                                        ForEach(viewModel.recommendList, id : \.title) { item in
                                            VStack(alignment: .leading, spacing: 8) {
                                                Text(item.title)
                                                    .font(.pretendardBold24)
                                                Text(item.description)
                                                    .font(.pretendardSemiBold16)
                                            }
                                            .border(.black)
                                        }
                                    }
                                    .background(
                                        
                                    )
                                }
                                .frame(height: 800)
                                .clipped()
                                .padding(.top, 8)
                                .border(.black)
                                
                                Spacer()
                                
                                Button{
                                    withAnimation(.bouncy) {
                                        isFoldRecommand.toggle()
                                    }
                                }label: {
                                    Image(systemName: isFoldRecommand ? "chevron.up" : "chevron.down")
                                        .frame(width: 10, height: 10)
                                        .font(.pretendardBold20)
                                }
                                .padding(.bottom, 8)
                                .border(.black)
                                
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
        .LogoProgressOverlay(isPresented: $viewModel.isPresneted) //로딩
    }
}

#Preview {
    NavigationStack{
        RecommendView()
    }
}
