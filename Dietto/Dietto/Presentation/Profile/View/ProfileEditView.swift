//
//  ProfileEditView.swift
//  Dietto
//
//  Created by kyuhyeon Lee on 5/15/25.
//

import SwiftUI
import Foundation
//MARK: - 뷰
class ProfileEditViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var birthString: String = ""
    @Published var gender: String = ""
    @Published var weight: String = ""
    @Published var showPhotoSheet: Bool = false
    @Published var showDatePicker: Bool = false
    
    func saveProfile() {
        print("프로필이 저장되었습니다.")
    }
    
    func selectGender(_ gender: String) {
        self.gender = gender
    }
}

struct ProfileEditView: View {
    @StateObject private var viewModel = ProfileEditViewModel()
    @Environment(\.dismiss) private var dismiss
    @State private var numberInput: String = ""
    
    var body: some View {
        ZStack {
            Color(.backGround).ignoresSafeArea()
            VStack {
                // MARK: - 프로필 이미지 - 버튼
                ZStack(alignment: .bottomTrailing) {
                    Button(action: {
                        viewModel.showPhotoSheet = true
                    }) {
                        Circle()
                            .stroke(Color.accent, lineWidth: 2)
                            .frame(width: 180, height: 180)
                            .background(
                                Image(systemName: "person.crop.circle.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColor(Color(.systemGray4))
                                    .frame(width: 180, height: 180)
                            )
                    }
                    //MARK: - 카메라 버튼 - 버튼
                    Button(action: {
                        viewModel.showPhotoSheet = true
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
                .padding(.top, 48)
                
                // MARK: - 이름 입력란
                VStack(alignment: .leading, spacing: 6) {
                    Text("이름")
                        .font(.pretendardBold16)
                        .padding(.leading, 12)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    TextField("이름을 입력해주세요", text: $viewModel.name)
                        .font(.pretendardMedium16)
                        .padding(.horizontal, 20)
                        .frame(height: 54)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.accent, lineWidth: 2)
                        )
                }
                .padding(.top, 40)
                .padding(.horizontal, 20)
                
                
                //MARK: - 성별 선택
                VStack(alignment: .leading, spacing: 6) {
                    Text("성별")
                        .font(.pretendardBold16)
                        .padding(.leading, 12)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(.accent, lineWidth: 2)
                            .frame(height: 54)
                        
                        HStack {
                            Text(viewModel.gender.isEmpty ? "남성" : viewModel.gender)
                                .font(.pretendardMedium16)
                                .foregroundColor(viewModel.gender.isEmpty ? .black : .primary)
                                .padding(.leading, 20)
                            
                            Spacer()
                            
                            Menu {
                                Button {
                                    viewModel.selectGender("남성")
                                } label: {
                                    Text("남성")
                                }
                                Button {
                                    viewModel.selectGender("여성")
                                } label: {
                                    Text("여성")
                                }
                            } label: {
                                Image(systemName: "chevron.up.chevron.down")
                                    .font(.pretendardBold16)
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 12)
                            }
                            .menuStyle(.automatic)
                        }
                    }
                }
                .padding(.top, 30)
                .padding(.horizontal, 20)
                
                //MARK: - 키 수정
                VStack(alignment: .leading, spacing: 1) {
                    Text("키")
                        .font(.pretendardBold16)
                        .padding(.leading, 12)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    HStack(spacing: 0) {
                        TextField("170", text: $numberInput)
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.center)
                            .frame(height: 54)
                            .padding(.horizontal, 20)
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.appMain, lineWidth: 2)
                            )
                            .toolbar {
                                ToolbarItemGroup(placement: .keyboard) {
                                    Spacer()
                                    Button("완료") {
                                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                    }
                                }
                            }
                        Text("cm")
                            .font(.custom("NerkoOne-regular", size: 50))
                            .foregroundColor(Color.accent)
                            .padding(.leading, 12)
                    }
                }
                .padding(.horizontal, 25)
                .padding(.top, 30)
                
                //MARK:  - 저장 버튼
                Button(action: {
                    dismiss()
                }) {
                    Text("저장")
                        .font(.pretendardBold16)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 15)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.appMain)
                        )
                }
                .padding(.horizontal, 20)
                .padding(.top, 80)
                .padding(.bottom, 40)
            }
        }
        //MARK: - 프로필 사진 변경
        .navigationTitle("프로필 수정")
        .navigationBarTitleDisplayMode(.inline)
        
        // MARK: - 프로필 사진 변경 시트
        .confirmationDialog(
            "프로필 사진 선택",
            isPresented: $viewModel.showPhotoSheet,
            titleVisibility: .visible
        ) {
            Button("카메라"){}
            Button("갤러리"){}
            Button("취소", role: .cancel) {}
        }
    }
}

#Preview {
    ProfileEditView()
}
