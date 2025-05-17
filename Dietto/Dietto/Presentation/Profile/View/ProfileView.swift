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
                                    .font(.pretendardMedium16)
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
                            .font(.pretendardBold20)
                            .fontWeight(.bold)
                        Text("180cm 70kg")
                            .font(.pretendardMedium20)
                            .font(.title3)
                    }
                    mealsCard()
                    .padding(.top, -5)

                    Spacer()
                }
            }
//MARK: edit 누르면 ProfileEditView로 이동
            .navigationDestination(isPresented: $isEditActive) {
                ProfileEditView()
            }
        }
    }
}
//MARK: 내가 먹었던 음식
struct mealsCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            // 타이틀 & 칼로리
            HStack {
                Text("내 식사")
                    .font(.pretendardMedium24)
                Spacer()
                Text("1350kcal")
                    .foregroundColor(Color(red: 0.925, green: 0.463, blue: 0.463))
                    .font(.pretendardMedium20)
            }
            // 아침
            VStack(alignment: .leading, spacing: 2) {
                Text("아침")
                    .foregroundColor(Color(red: 0.925, green: 0.463, blue: 0.463))
                    .font(.pretendardBold24)
                Text("오트밀과 과일")
                    .font(.pretendardBold20)
                Text("350kcal 08:30")
                    .font(.pretendardMedium16)
            }
            // 점심
            VStack(alignment: .leading, spacing: 2) {
                Text("점심")
                    .foregroundColor(Color(red: 0.925, green: 0.463, blue: 0.463))
                    .font(.pretendardBold24)
                Text("닭가슴살 샐러드")
                    .font(.pretendardBold20)
                Text("450kcal 12:30")
                    .font(.pretendardMedium16)
            }
            // 저녁
            VStack(alignment: .leading, spacing: 2) {
                Text("저녁")
                    .foregroundColor(Color(red: 0.925, green: 0.463, blue: 0.463))
                    .font(.pretendardBold24)
                Text("연어스테이크")
                    .font(.pretendardBold20)
                Text("550kcal 18:30")
                    .font(.pretendardMedium16)
            }
        }
        .padding(22)
        .background(
            RoundedRectangle(cornerRadius: 32)
                .stroke(Color(red: 0.925, green: 0.463, blue: 0.463), lineWidth: 2)
                .background(Color.clear.clipShape(RoundedRectangle(cornerRadius: 32)))
        )
        .padding(.horizontal, 12)
        .padding(.top, 16)
    }
}

#Preview {
    ProfileView()
}
