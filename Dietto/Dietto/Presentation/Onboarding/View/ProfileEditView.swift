//
//  ProfileEditView.swift
//  Dietto
//
//  Created by kyuhyeon Lee on 5/15/25.
//

import SwiftUI

struct ProfileEditView: View {
    
    @Binding var selection: Int
    @ObservedObject var viewModel: OnboardingViewModel
    
    var body: some View {
        ZStack {
            Color(.backGround)
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 30) {
                    // MARK: - 프로필 이미지
                    ZStack(alignment: .bottomTrailing) {
                        Button { viewModel.showPhotoSheet.toggle() } label: {
                            Circle()
                                .stroke(Color.appMain, lineWidth: 2)
                                .frame(width: 180, height: 180)
                                .background(
                                    Image(systemName: "person.crop.circle.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .foregroundColor(.gray)
                                        .frame(width: 180, height: 180)
                                )
                        }
                        Button { viewModel.showPhotoSheet.toggle() } label: {
                            Circle()
                                .fill(Color.black)
                                .frame(width: 45, height: 45)
                                .overlay(
                                    Image(systemName: "camera")
                                        .font(.system(size: 20, weight: .bold))
                                        .foregroundColor(.white)
                                )
                        }
                        .offset(x: -5, y: -5)
                    }
                    
                    // MARK: - 이름 입력란
                    VStack(alignment: .leading, spacing: 6) {
                        Text("이름")
                            .font(.pretendardBold16)
                        TextField("이름을 입력해주세요", text: $viewModel.name)
                            .font(.pretendardMedium16)
                            .padding(.horizontal, 20)
                            .frame(height: 54)
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.appMain, lineWidth: 2)
                                    .padding(2)
                            )
                    }
                    
                    // MARK: - 성별 선택
                    VStack(alignment: .leading, spacing: 6) {
                        Text("성별")
                            .font(.pretendardBold16)
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.appMain, lineWidth: 2)
                                .frame(height: 54)
                                .padding(2)
                            
                            HStack {
                                Text(viewModel.gender.rawValue)
                                    .font(.pretendardMedium16)
                                    .foregroundColor(.black)
                                    .padding(.leading, 20)
                                
                                Spacer()
                                
                                Menu {
                                    Button { viewModel.selectGender(.male) } label: { Text("남성") }
                                    Button { viewModel.selectGender(.female) } label: { Text("여성") }
                                } label: {
                                    Image(systemName: "chevron.up.chevron.down")
                                        .font(.pretendardBold16)
                                        .foregroundColor(.gray)
                                        .padding(.trailing, 12)
                                }
                            }
                        }
                    }
                    
                    // MARK: - 키 수정
                    InputFieldForNumbers(fieldName: "키", placeholder: "170", unit: "cm", startWeight: $viewModel.height)
                    
                    InputFieldForNumbers(fieldName: "몸무게", placeholder: "70", unit: "kg", startWeight: $viewModel.weight)
                    
                }
            }
            .padding(.top, 48)
            .padding(.horizontal, 16)
            .confirmationDialog(
                "프로필 사진 선택",
                isPresented: $viewModel.showPhotoSheet,
                titleVisibility: .visible
            ) {
                Button("카메라") { /* 카메라 액션 */ }
                Button("갤러리") { /* 갤러리 액션 */ }
                Button("취소", role: .cancel) {}
            }
            .toolbar {
                ToolbarItem(placement: .keyboard) {
                    HStack {
                        Spacer()
                        Button("완료") {
                            UIApplication.shared.sendAction(
                                #selector(UIResponder.resignFirstResponder),
                                to: nil, from: nil, for: nil
                            )
                        }
                    }
                }
            }
        }
        
    }
}

struct InputFieldForNumbers: View {
    let fieldName: String
    let placeholder: String
    let unit: String
    @Binding var startWeight: String
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(fieldName)
                .font(.pretendardBold16)
            HStack(spacing: 0) {
                TextField(placeholder, text: $startWeight)
                    .keyboardType(.numberPad)
                    .multilineTextAlignment(.center)
                    .frame(height: 54)
                    .padding(.horizontal, 20)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.appMain, lineWidth: 2)
                            .padding(2)
                    )
                    
                //
                Text(unit)
                    .font(.custom("NerkoOne-regular", size: 50))
                    .foregroundColor(Color.appMain)
                    .padding(.leading, 12)
            }
        }
    }
}
