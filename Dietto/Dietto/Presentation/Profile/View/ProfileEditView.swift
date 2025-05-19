//
//  ProfileEditView.swift
//  Dietto
//
//  Created by kyuhyeon Lee on 5/15/25.
//

import SwiftUI

struct ProfileEditView: View {
    @State private var showPhotoSheet = false
    @State private var name: String = ""
    @State private var birth: String = ""
    @State private var gender: String = ""
    @State private var showGenderSheet = false
    @State private var height: String = ""
    @State private var weight: String = ""
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
//MARK: 배경 색상
            Color(red: 1.0, green: 0.976, blue: 0.976)
                .ignoresSafeArea()
            
            ScrollView {
                VStack {
// MARK: - 프로필 이미지 / 카메라 버튼
                    ZStack(alignment: .bottomTrailing) {
                        Button(action: {
                            showPhotoSheet = true
                        }) {
                            Circle()
                                .stroke(Color(red: 0.925, green: 0.463, blue: 0.463), lineWidth: 2)
                                .frame(width: 180, height: 180)
                                .background(
                                    Image(systemName: "person.crop.circle.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .foregroundColor(Color(.systemGray4))
                                        .frame(width: 180, height: 180)
                                )
                        }
//MARK: 카메라 버튼 - 버튼
                        Button(action: {
                            showPhotoSheet = true
                        }) {
                            ZStack {
                                Circle()
                                    .fill(Color.black)
                                    .frame(width: 45, height: 45)
                                Image(systemName: "camera")
                                    .foregroundColor(.white)
                                    .font(.system(size: 20, weight: .bold))
                            }
                        }
                        .offset(x: -1, y: -1)
                    }
                    .frame(width: 180, height: 180)
                    .padding(.top, 16)
                    
// MARK: - 이름 및 이름 입력란
                    VStack(alignment: .leading, spacing: 6) {
                        Text("이름")
                            .font(.pretendardBold16)
                            .padding(.leading, 12)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        TextField("이름을 입력해주세요", text: $name)
                            .font(.pretendardMedium16)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 15)
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color(red: 0.925, green: 0.463, blue: 0.463), lineWidth: 2)
                            )
                    }
                    .padding(.top, 25)
                    .padding(.horizontal, 20)
                    
//MARK: 생년월일
                    VStack(alignment: .leading, spacing: 6) {
                        Text("생년월일")
                            .font(.pretendardBold16)
                            .padding(.leading, 12)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        TextField("2002.04.12", text: $birth)
                            .font(.pretendardMedium16)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 15)
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color(red: 0.925, green: 0.463, blue: 0.463), lineWidth: 2)
                            )
                    }
                    .padding(.top, 20)
                    .padding(.horizontal, 20)
                    
//MARK: 성별 선택
                    VStack(alignment: .leading, spacing: 6) {
                        Text("성별")
                            .font(.pretendardBold16)
                            .padding(.leading, 12)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color(red: 0.925, green: 0.463, blue: 0.463), lineWidth: 2)

                            HStack {
                                Text(gender.isEmpty ? "남성" : gender)
                                    .font(.pretendardMedium16)
                                    .foregroundColor(gender.isEmpty ? .gray : .primary)
                                    .padding(.leading, 20)

                                Spacer()

                                Menu {
                                    Button {
                                        gender = "남성"
                                    } label: {
                                        Text("남성")
                                    }

                                    Button {
                                        gender = "여성"
                                    } label: {
                                        Text("여성")
                                    }
                                } label: {
                                    Image(systemName: "chevron.down")
                                        .foregroundColor(.gray)
                                        .padding(.trailing, 12)
                                }
                                .menuStyle(.automatic)
                            }
                            .padding(.vertical, 15)
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .padding(.top, 20)
                    .padding(.horizontal, 20)
                    
//MARK: 키 수정
                    VStack(alignment: .leading, spacing: 6) {
                        Text("키")
                            .font(.pretendardBold16)
                            .padding(.leading, 15)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        HStack(spacing: 0) {
                            TextField("170", text: $height)
                                .keyboardType(.numberPad)
                                .multilineTextAlignment(.center)
                                .font(.pretendardMedium20)
                                .foregroundColor(.primary)
                                .padding(.horizontal, 20)
                                .padding(.vertical, 15)
                                .background(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color(red: 0.925, green: 0.463, blue: 0.463), lineWidth: 2)
                                )
                            Text("cm")
                                .font(.custom("NerkoOne-regular", size: 50))
                                .foregroundColor(Color(red: 0.925, green: 0.463, blue: 0.463))
                                .padding(.leading, 12)
                        }
                    }
                    .padding(.horizontal, 25)
                    .padding(.top, 20)
                    
//MARK: 몸무게 수정
                    VStack(alignment: .leading, spacing: 6) {
                        Text("몸무게")
                            .font(.pretendardBold16)
                            .padding(.leading, 15)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        HStack(spacing: 0) {
                            TextField("66", text: $weight)
                                .keyboardType(.numberPad)
                                .multilineTextAlignment(.center)
                                .font(.pretendardMedium20)
                                .foregroundColor(.primary)
                                .padding(.horizontal, 20)
                                .padding(.vertical, 15)
                                .background(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color(red: 0.925, green: 0.463, blue: 0.463), lineWidth: 2)
                                )
                            Text("kg")
                                .font(.custom("NerkoOne-regular", size: 50))
                                .foregroundColor(Color(red: 0.925, green: 0.463, blue: 0.463))
                                .padding(.leading, 12)
                        }
                    }
                    .padding(.horizontal, 25)
                    .padding(.top, -10)
                }
//MARK: 저장 버튼
                Button(action: {
                    dismiss()
                }) {
                    Text("저장")
                        .font(.pretendardBold20)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 15)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color(red: 0.925, green: 0.463, blue: 0.463))
                        )
                }
                .padding(.horizontal, 20)
                .padding(.top,-10)
                .padding(.bottom, 40)
            }
            Spacer()
        }
//MARK: 프로필 사진 변경
        .navigationTitle("프로필 수정")
        .navigationBarTitleDisplayMode(.inline)
        
// MARK: - 프로필 사진 변경 시트
        .confirmationDialog(
            "프로필 사진 선택",
            isPresented: $showPhotoSheet,
            titleVisibility: .visible
        ) {
            Button("카메라") {}
            Button("갤러리") {}
            Button("취소") {}
        }
    }
}


#Preview {
    ProfileEditView()
}
