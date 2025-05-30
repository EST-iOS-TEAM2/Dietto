//
//  ProfileView.swift
//  Dietto
//
//  Created by 안세훈 on 5/13/25.
//

import SwiftUI

struct ProfileView: View {
    
    @StateObject var viewModel : OnboardingViewModel
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                Color(.backGround).ignoresSafeArea()
                
                VStack {
                    HStack(alignment: .top) {
                        Spacer()
                        //MARK: - 프로필 글자
                        Text("프로필")
                            .font(.pretendardBold20)
                            .frame(maxWidth: .infinity)
                            .overlay{
                                HStack {
                                    Spacer()
                                    Button(action: {
                                        viewModel.isEditActive = true
                                    }) {
                                        Text("edit")
                                            .font(.pretendardMedium16)
                                            .foregroundColor(.white)
                                            .padding(.vertical, 4)
                                            .padding(.horizontal, 20)
                                            .background(Color.appMain)
                                            .clipShape(Capsule())
                                            .padding(.trailing, 10)
                                    }
                                }
                            }
                    }
                    .padding(.top, 16)
                    
                    VStack {
                        //MARK: - 프로필 이미지
                        ZStack {
                            Image(systemName: "person.crop.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .foregroundStyle(Color(.systemGray4))
                                .frame(width: 180, height: 180)
                                .clipShape(Circle())
                                .overlay(Circle()
                                    .stroke(Color.appMain, lineWidth: 2)
                                )
                        }
                        .padding(.top, 30)
                        //MARK: - 이름, 키, 몸무게
                        VStack(spacing: 4) {
                            Text(viewModel.name)
                                .font(.pretendardBold28)
                        }
                        // MARK: - 목표 표시
                        VStack(spacing: 20) {
                            HStack(spacing: 0) {
                                VStack(spacing: 8) {
                                    Text("현재 체중")
                                        .font(.pretendardRegular16)
                                    Text("\(viewModel.currentweight)kg")
                                        .font(.pretendardBold16)
                                }
                                .frame(maxWidth: .infinity)
                                
                                Divider()
                                    .frame(width: 1, height: 48)
                                    .background(Color.appMain)
                                
                                VStack(spacing: 8) {
                                    Text("현재 키")
                                        .font(.pretendardRegular16)
                                    Text("\(viewModel.height)cm")
                                        .font(.pretendardBold16)
                                }
                                .frame(maxWidth: .infinity)
                            }
                            .frame(height: 56)
                            .padding(.vertical, 14)
                            .background(Color.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.appMain, lineWidth: 2)
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .padding(.horizontal, 24)
                            
                            HStack(spacing: 0) {
                                VStack(spacing: 8) {
                                    Text("목표 체중")
                                        .font(.pretendardRegular16)
                                    Text("\(viewModel.targetWeight)kg")
                                        .font(.pretendardBold16)
                                }
                                .frame(maxWidth: .infinity)
                                
                                Divider()
                                    .frame(width: 1, height: 48)
                                    .background(Color.appMain)
                                
                                VStack(spacing: 8) {
                                    Text("목표 거리")
                                        .font(.pretendardRegular16)
                                    Text("\(viewModel.targetDistance)km")
                                        .font(.pretendardBold16)
                                }
                                .frame(maxWidth: .infinity)
                            }
                            .frame(height: 56)
                            .padding(.vertical, 14)
                            .background(Color.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.appMain, lineWidth: 2)
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .padding(.horizontal, 24)
                        }
                        .padding(.top, 20)
                        Spacer()
                        
                        
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
                        .padding(.horizontal, 24)
                        .alert("모든 데이터를 삭제하시겠습니까?", isPresented: $viewModel.isDeleteAlert) {
                            Button("삭제", role: .destructive) {viewModel.deleteAllUserData()}
                            Button("취소", role: .cancel) {}
                        }
                        .padding(.horizontal)
                        .padding(.vertical)
                        //MARK: - edit 누르면 ProfileEditView로 이동
                        .navigationDestination(isPresented: $viewModel.isEditActive) {
                            TutorialView(viewModel: OnboardingViewModel())
                        }
                    }
                }
            }
        }
    }
}



#Preview {
    ProfileView(viewModel: OnboardingViewModel())
}
