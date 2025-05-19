//
//  DietaryView.swift
//  Dietto
//
//  Created by 안세훈 on 5/13/25.
//

import SwiftUI

struct DietaryView: View {
    
    @StateObject private var ViewModel = DietaryViewModel()
    
    @State private var newfood : String = ""
    
    @State private var recommandflowlayout : CGFloat = 0 //추천 레시피
    
    @State private var myRefrigerlatorflowlayout : CGFloat = 0 //마이냉장고
    @State private var isFoldMyRefrigerlator : Bool = false //마이냉장고 펼쳤다 접었다.
    
    @State private var PushToRecommandView : Bool = false // 화면이동
    
    @State private var isAnimating : Bool = false
    
    var body: some View {
        NavigationStack{
            ZStack{
                Color(.backGround).ignoresSafeArea(edges: .all)
                
                VStack{
                    HStack {
                        //MARK: - 로고
                        Text("Dietto")
                            .font(.NerkoOne40)
                            .foregroundStyle(.text)
                        Spacer()
                        Button {
                            print("Profile Clicked")
                        } label: {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 38, height: 38)
                                .foregroundStyle(.textFieldGray)
                                .clipShape(Circle())
                                .overlay(
                                    Circle().stroke(Color.accentColor, lineWidth: 1)
                                )
                        }
                    }
                    .padding([.leading, .trailing], 16)
                    //MARK: - TextField
                    ScrollView{
                        HStack{
                            TextField("재료를 추가해주세요.", text: $newfood)
                                .font(.pretendardSemiBold16)
                                .foregroundStyle(.text)
                                .padding(.leading, 16)
                                .frame(height: 40)
                                .background(Color.white)
                                .overlay{
                                    RoundedRectangle(cornerRadius: 13)
                                        .stroke(Color.accentColor, lineWidth: 1)
                                }
                            
                            Button("추가"){
                                if newfood != ""{
                                    ViewModel.addpresentIngredients(newfood)
                                    newfood = ""
                                }
                                
                            }
                            .font(.pretendardBold12)
                            .foregroundStyle(.white)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 16)
                            .background {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.accentColor)
                            }
                        }
                        .padding(.top,3)
                        .padding([.leading, .trailing], 16)
                        
                        Spacer().frame(height: 20)
                        
                        //MARK: - 식단에 사용 될 식재료
                        ContainerView(paddingSize: 16, height: recommandflowlayout + 60) {
                            HStack{
                                VStack{
                                    Text("추천 레시피에 적용할 재료가 표시됩니다.")
                                        .font(.pretendardSemiBold10)
                                        .foregroundStyle(.textFieldGray)
                                    
                                    Spacer()
                                    
                                    FlowLayout(spacing: 4, lineSpacing: 3, contentHeight: $recommandflowlayout) {
                                        ForEach(ViewModel.presentIngredients) { ingredient in
                                            PillText(text: ingredient.name, onDelete: {
                                                ViewModel.removepresentIngredients(ingredient)
                                            })
                                            
                                        }
                                    }
                                    
                                    Spacer()
                                }
                            }
                            .padding()
                            
                        }
                        
                        Spacer().frame(height: 20)
                        //MARK: - 마이 냉장고
                        VStack(alignment: .leading) {
                            Text("마이 냉장고")
                                .font(.pretendardBold20)
                                .foregroundStyle(.black)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 16)
                        
                        
                        ContainerView(paddingSize: 16, height: isFoldMyRefrigerlator ? 60 : myRefrigerlatorflowlayout + 60) {
                            HStack{
                                VStack{
                                    Text("과거에 사용된 식재료들은 여기에 저장됩니다.")
                                        .font(.pretendardSemiBold10)
                                        .foregroundStyle(.textFieldGray)
                                        .padding(.top, 8)
                                    
                                    Spacer()
                                    
                                    if !isFoldMyRefrigerlator{
                                        FlowLayout(spacing: 4, lineSpacing: 3, contentHeight: $myRefrigerlatorflowlayout) {
                                            ForEach(ViewModel.pastIngredients) { ingredient in
                                                PillText(text: ingredient.name, onDelete: {
                                                    ViewModel.removepastIngredients(ingredient)
                                                })
                                            }
                                        }
                                    }
                                    
                                    Spacer()
                                    
                                    Button{
                                        withAnimation(.bouncy) {
                                            isFoldMyRefrigerlator.toggle()
                                        }
                                    }label: {
                                        Image(systemName: isFoldMyRefrigerlator ? "chevron.down" : "chevron.up")
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
                    HStack {
                        Button("식단 추천받기") {
                            for ingredient in ViewModel.presentIngredients {
                                print("id \(ingredient.id), name \(ingredient.name)")
                            }
                            PushToRecommandView = true
                        }
                        .font(.pretendardBold16)
                        .foregroundColor(.white)
                        .padding(.vertical, 16)
                        .frame(maxWidth: .infinity)
                        .background(Color.accentColor)
                        .cornerRadius(12)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 40)
                    
                    Spacer()
                    
                }
            }
            .navigationDestination(isPresented: $PushToRecommandView) {
                RecommendView()
            }
        }
    }
}

#Preview {
    DietaryView()
}
