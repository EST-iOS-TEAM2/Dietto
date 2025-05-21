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
    @Published var name: String = "이규현"
    @Published var height: Int = 180
    @Published var weight: Int = 70
    @Published var interests: [String] = ["근육량 증가", "영양소 섭취", "혈당 안정화", "안녕하세요", "반갑습니다", "칼로리 조절", "운동 습관", "수분 섭취", "스트레스 관리"]
}

struct ProfileView: View {
    @StateObject private var viewModel = ProfileViewModel()
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.backGround).ignoresSafeArea()
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
                                .padding(.trailing, 15)
                            }
                        }
//MARK: 프로필 이미지
                        VStack(spacing: 14) {
                            ZStack {
                                Circle()
                                    .stroke(Color.accent, lineWidth: 2)
                                    .frame(width: 180, height: 180)
                                Image(systemName: "person.crop.circle.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColor(Color(.systemGray4))
                                    .frame(width: 180, height: 180)
                            }
//MARK: 사용자 이름, 키 몸무게
                            Text(viewModel.name)
                                .font(.title)
                                .font(.pretendardBold20)
                                .fontWeight(.bold)
                            Text("\(viewModel.height)cm \(viewModel.weight)kg")
                                .font(.pretendardMedium20)
                                .font(.title3)
                        }
                        InterestsView(interests: viewModel.interests)
                        Spacer()
                    }
                }
            }
            
//MARK: edit 누르면 ProfileEditView로 이동
            .navigationDestination(isPresented: $viewModel.isEditActive) {
                ProfileEditView()
            }
        }
    }
}

//#MARK: - 관심사
struct InterestsView: View {
    let interests: [String]

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("관심사")
                    .font(.pretendardBold20)
                    .foregroundColor(.black)

                Spacer()

                Button(action: {
                }) {
                    Text("edit")
                        .font(.pretendardMedium16)
                        .foregroundColor(.white)
                        .padding(.vertical, 4)
                        .padding(.horizontal, 14)
                        .background(Color.accent)
                        .clipShape(Capsule())
                }
            }
            .padding(.top, -5)

            FlexibleTagWrapView(tags: interests)
                .padding(.top, 25)
        }
        .padding(30)
        .background(
            RoundedRectangle(cornerRadius: 32)
                .stroke(Color.accentColor, lineWidth: 2)
                .background(Color.clear.clipShape(RoundedRectangle(cornerRadius: 32)))
        )
        .padding(.horizontal, 10)
        .padding(.top, 10)
    }
}
//MARK: - 두줄씩 세로로 내려감
struct FlexibleTagWrapView: View {
    let tags: [String]
    let spacing: CGFloat = 16

    private var columns: [GridItem] {
        Array(repeating: .init(.flexible(), spacing: spacing), count: 2)
    }

    var body: some View {
        LazyVGrid(columns: columns, alignment: .center, spacing: spacing) {
            ForEach(tags, id: \.self) { tag in
                InterestTag(title: tag)
            }
        }
    }
}
//MARK: - 관심사 태그 버튼 모양
struct InterestTag: View {
    let title: String
    var body: some View {
        Text(title)
            .font(.pretendardMedium16)
            .foregroundColor(.white)
            .padding(.vertical, 10)
            .padding(.horizontal, 25)
            .background(
                Capsule()
                    .fill(Color.accent)
            )
    }
}

#Preview {
    ProfileView()
}
