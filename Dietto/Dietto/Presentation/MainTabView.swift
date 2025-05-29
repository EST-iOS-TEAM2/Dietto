//
//  MainTabView.swift
//  Dietto
//
//  Created by 안정흠 on 5/26/25.
//

import SwiftUI

struct MainTabView: View {
    @Environment(DIContainer.self) private var diContainer
    var body: some View {
        TabView {
            Tab("홈", systemImage: "house.fill") {
                HomeView(viewModel: diContainer.getHomeViewModel())
            }
            Tab("식단", systemImage: "leaf.fill") {
                DietaryView(dietartViewModel: diContainer.getDietaryViewModel())
            }
            Tab("아티클", systemImage: "newspaper") {
                ArticleView(viewModel: diContainer.getArticleViewModel())
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
