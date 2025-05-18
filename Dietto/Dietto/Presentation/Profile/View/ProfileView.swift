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
                ScrollView {
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
                        InterestsView()

                        Spacer()
                    }
                }
            }
//MARK: edit 누르면 ProfileEditView로 이동
            .navigationDestination(isPresented: $isEditActive) {
                ProfileEditView()
            }
        }
    }
}

//#MARK: 관심사
struct InterestsView: View {
    let interests = ["근육량 증가", "영양소 섭취", "혈당 안정화"]

    var body: some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 32)
                .stroke(Color(red: 0.925, green: 0.463, blue: 0.463), lineWidth: 2)
                .background(Color.clear.clipShape(RoundedRectangle(cornerRadius: 32)))
            VStack(alignment: .leading, spacing: 22) {
                Text("관심사")
                    .font(.pretendardBold20)
                    .foregroundColor(.black)
                    .padding(.top, 10)
                VStack(alignment: .leading, spacing: 22) {
                    HStack(spacing: 20) {
                        ForEach(0..<min(2, interests.count), id: \.self) { idx in
                            InterestTag(title: interests[idx])
                        }
                    }
                    if interests.count > 2 {
                        HStack(spacing: 20) {
                            ForEach(2..<interests.count, id: \.self) { idx in
                                InterestTag(title: interests[idx])
                            }
                        }
                    }
                }
            }
            .padding(.horizontal, 30)
            .padding(.top, 10)
            .padding(.bottom, 40)
        }
        .padding(.horizontal, 20)
        .padding(.top, 20)
    }
}

// 관심사 태그 버튼 모양
struct InterestTag: View {
    let title: String
    var body: some View {
        Text(title)
            .font(.pretendardMedium16)
            .foregroundColor(.white)
            .padding(.vertical, 14)
            .padding(.horizontal, 32)
            .background(
                Capsule()
                    .fill(Color(red: 0.925, green: 0.463, blue: 0.463))
            )
    }
}

#Preview {
    ProfileView()
}
