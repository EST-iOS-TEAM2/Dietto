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
    @Published var isDeleteAlert: Bool = false
    
}

struct ProfileView: View {
    @StateObject private var viewModel = ProfileViewModel()
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                Color(.backGround).ignoresSafeArea()
                //MARK: - 프로필 글자
                Text("프로필")
                    .font(.pretendardBold20)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top, 50)
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
                            .background(Color.appMain)
                            .clipShape(Capsule())
                    }
                }
                .padding(.top, 50)
                .padding(.trailing, 15)
                
                VStack {
                    //MARK: - 프로필 이미지
                    ZStack {
                        Circle()
                            .stroke(Color.appMain, lineWidth: 2)
                            .frame(width: 180, height: 180)
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(Color(.systemGray4))
                            .frame(width: 180, height: 180)
                            .clipShape(Circle())
                    }
                    .padding(.top, 30)
                    //MARK: - 이름, 키, 몸무게
                    VStack(spacing: 4) {
                        Text("이규현")
                            .font(.pretendardBold28)
                        Text("170cm 65kg")
                            .font(.pretendardRegular20)
                    }
                    Spacer()
                    //MARK: - 목표수정 버튼
                    Button(action: {
                        //목표수정창으로 이동해야함(듀토리얼1)
                    }) {
                        Text("목표수정")
                            .font(.pretendardBold16)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 15)
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.appMain)
                            )
                    }
                    .cornerRadius(20)
                    .padding(.top, 30)
                    .padding(.bottom, 20)
                    //MARK: - 모든 데이터 삭제하기
                    Button(action: {
                        viewModel.isDeleteAlert = true
                    }) {
                        Text("모든 데이터 삭제하기")
                            .font(.pretendardBold16)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 15)
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.red)
                            )
                    }
                    .alert("모든 데이터를 삭제하시겠습니까?", isPresented: $viewModel.isDeleteAlert) {
                        Button("삭제", role: .destructive) {}
                        Button("취소", role: .cancel) {}
                    }
                    .padding(.bottom, 100)
                    //MARK: - edit 누르면 ProfileEditView로 이동
                    .navigationDestination(isPresented: $viewModel.isEditActive) {
                        ProfileEditView()
                    }
                }
                .padding(.horizontal, 24)
                .padding(.top, 80)
            }
            .frame(minHeight: UIScreen.main.bounds.height)
        }
    }
}



#Preview {
    ProfileView()
}
