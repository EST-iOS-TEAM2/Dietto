//
//  ProfileView.swift
//  Dietto
//
//  Created by 안세훈 on 5/13/25.
//

import SwiftUI

struct ProfileView: View {
    @State private var isEditActive = false

    var body: some View {
        NavigationStack {
            ZStack {
//MARK: 전체 배경
                Color(red: 1.0, green: 0.976, blue: 0.976).ignoresSafeArea()
                VStack {
//MARK: 상단 타이틀/버튼
                    ZStack {
                        Text("프로필")
                            .font(.title3)
                            .fontWeight(.bold)
                        HStack {
                            Spacer()
                            Button(action: {
                                isEditActive = true
                            }) {
                                Text("edit")
                                    .font(.system(size: 16, weight: .bold))
                                    .font(.pretendardMedium12)
                                    .foregroundColor(.white)
                                    .padding(.vertical, 5)
                                    .padding(.horizontal, 20)
                                    .background(Color(red: 0.925, green: 0.463, blue: 0.463))
                                    .clipShape(Capsule())
                            }
                            .padding(.trailing, 15)
                        }
                    }
//MARK: 프로필 이미지
                    VStack(spacing: 14) {
                        ZStack {
                            Circle()
                                .stroke(Color(red: 0.925, green: 0.463, blue: 0.463), lineWidth: 2)
                                .frame(width: 180, height: 180)
                            Image(systemName: "person.crop.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(Color(.systemGray4))
                                .frame(width: 180, height: 180)
                        }
//MARK: 사용자 이름, 키 몸무게
                        Text("이규현")
                            .font(.title)
                            .font(.pretendardBold12)
                            .fontWeight(.bold)
                        Text("180cm 70kg")
                            .font(.pretendardMedium20)
                            .font(.title3)
                    }
                    .padding(.top, 24)

                    Spacer()
                }
            }
            .navigationDestination(isPresented: $isEditActive) {
                ProfileEditView()
            }
        }
    }
}


#Preview {
    ProfileView()
}
