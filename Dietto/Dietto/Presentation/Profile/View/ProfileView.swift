//
//  ProfileView.swift
//  Dietto
//
//  Created by 안세훈 on 5/13/25.
//

import SwiftUI

//MARK: 내 프로필 데이터 뷰 모델에서 관리한다.
class ProfileViewModel: ObservableObject {
    @Published var isEditActive: Bool = false
    
}

struct ProfileView: View {
    @StateObject private var viewModel = ProfileViewModel()
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.backGround).ignoresSafeArea()
                VStack {
                    //MARK: - 상단 타이틀/버튼
                    VStack(spacing: 0) {
                        HStack {
                            Spacer()
                            Text("프로필")
                                .font(.pretendardBold20)
                                .fontWeight(.bold)
                            Spacer()
                        }
                        .padding(.top, 50)
                        .padding(.horizontal, 16)
                        //MARK: - edit 버튼
                        HStack {
                            Spacer()
                            Button(action: {
                                viewModel.isEditActive = true
                            }) {
                                Text("edit")
                                    .font(.pretendardMedium16)
                                    .foregroundColor(.white)
                                    .padding(.vertical, 5)
                                    .padding(.horizontal, 20)
                                    .background(Color.accent)
                                    .clipShape(Capsule())
                            }
                        }
                        .padding(.top, -25)
                        .padding(.trailing, -10)
                    }
                    //MARK: - 프로필 이미지
                    ZStack {
                        Circle()
                            .stroke(Color.accent, lineWidth: 2)
                            .frame(width: 180, height: 180)
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(Color(.systemGray4))
                            .frame(width: 180, height: 180)
                            .clipShape(Circle())
                        
                    }
                    .padding(.top, 10)
                    //MARK: - 이름, 키, 몸무게
                    VStack(spacing: 4) {
                        Text("이규현")
                            .font(.pretendardBold28)
                        Text("170cm 65kg")
                            .font(.pretendardRegular20)
                    }
                    
                    Spacer()
                    //MARK: - 목표수정 버튼
                    Button("목표 수정") {
                        //목표수정창으로 이동해야함(듀토리얼1)
                    }
                    .font(.pretendardMedium16)
                    .frame(maxWidth: .infinity, minHeight: 56)
                    .background(Color.accent)
                    .foregroundStyle(Color.white)
                    .cornerRadius(20)
                    .padding(.horizontal, 24)
                    .padding(.bottom, 14)
                    //MARK: - 모든 데이터 삭제하기
                    Button("모든 데이터 삭제하기") {
                        
                    }
                    .font(.pretendardMedium16)
                    .frame(maxWidth: .infinity, minHeight: 56)
                    .background(Color.red)
                    .foregroundStyle(Color.white)
                    .cornerRadius(20)
                    .padding(.horizontal, 24)
                    .padding(.bottom, 100)
                    //MARK: - edit 누르면 ProfileEditView로 이동
                    .navigationDestination(isPresented: $viewModel.isEditActive) {
                        ProfileEditView()
                    }
                }
            }
            .padding(.horizontal, 24)
            .frame(minHeight: UIScreen.main.bounds.height)
        }
    }
}



#Preview {
    ProfileView()
}
