//
//  ProfileView.swift
//  Dietto
//
//  Created by 안세훈 on 5/13/25.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Color(red: 1.0, green: 0.976, blue: 0.976).ignoresSafeArea()
            VStack {
                HStack {
                    Spacer()
                    Text("프로필")
                        .font(.title3)
                        .fontWeight(.bold)
                        .padding(.top, 10)
                    Spacer()
                }
                Spacer()
            }
//MARK: edit버튼
            Button(action: {
                
            }) {
                Text("edit")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.vertical, 5)
                    .padding(.horizontal, 20)
                    .background(Color(red: 0.925, green: 0.463, blue: 0.463))
                    .clipShape(Capsule())
            }
            .padding(.top, 6)
            .padding(.trailing, 15)
        }
//MARK: 프로필 사진
        VStack{
            ZStack{
                Circle()
                    .stroke(Color(red: 0.925, green: 0.463, blue: 0.463), lineWidth: 2)
                    .frame(width: 180, height: 180)
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(Color(.systemGray4))
                    .frame(width: 180, height: 180)
            }
            .padding(.bottom, 10)
            Text("이규현")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 10)
            Text("180cm 70kg")
        }
        .padding(.bottom, 460)
    }
}


#Preview {
    ProfileView()
}
