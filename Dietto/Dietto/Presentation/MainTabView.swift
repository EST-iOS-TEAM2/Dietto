//
//  MainTabView.swift
//  Dietto
//
//  Created by 안정흠 on 5/26/25.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            Tab("홈", systemImage: "house.fill") {
                HomeView()
            }
            Tab("식단", systemImage: "leaf.fill") {
                DietaryView()
            }
            Tab("아티클", systemImage: "newspaper") {
                EmptyView()
            }
            Tab("프로필", systemImage: "person.circle.fill") {
                ProfileView()
            }
        }
    }
}

#Preview {
    MainTabView()
}
