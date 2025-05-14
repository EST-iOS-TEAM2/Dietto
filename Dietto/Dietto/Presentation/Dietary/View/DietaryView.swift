//
//  DietaryView.swift
//  Dietto
//
//  Created by 안세훈 on 5/13/25.
//

import SwiftUI

struct DietaryView: View {
    
    @StateObject private var viewmodel = DietaryViewModel()
    
    var body: some View {
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
                HStack{
                    TextField("재료를 추가해주세요.", text: .constant(""))
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
                        print("재료 추가 버튼")
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
                .padding([.leading, .trailing], 16)
                
                Spacer().frame(height: 20)
                
                //MARK: - 식단에 사용 될 식재료
                ContainerView(paddingSize: 16, height: 100) {
                    VStack{
                        Text("추천 레시피에 적용할 재료")
                            .font(.pretendardSemiBold10)
                            .foregroundStyle(.textFieldGray)
                            .padding(.top, 8)
                        
                        Spacer()
                        
                        HStack{
                            PillText(text: "오리고기",
                                     onAdd: {
                                print("추가")
                            },
                                     onDelete:{
                                print("삭제")
                            })
                        }
                        
                        
                        Spacer()
                        
                        Button{
                            print("+ 버튼 클릭")
                        }label: {
                            Image(systemName: "plus")
                                .font(.pretendardBold20)
                        }
                        .padding(.bottom, 8)
                    }
                    
                }
                
                //MARK: - 일부러 만든 여백
                Spacer()
                //MARK: - 일부러 만든 여백
                
            }
        }
    }
}

#Preview {
    DietaryView()
}
