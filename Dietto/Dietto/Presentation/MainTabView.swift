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
            HomeView(viewModel: diContainer.getHomeViewModel())
                .tabItem {
                    Label("홈", systemImage: "house.fill")
                }
            
            DietaryView(dietartViewModel: diContainer.getDietaryViewModel())
                .tabItem {
                    Label("식단", systemImage: "leaf.fill")
                }
            
            ArticleView(viewModel: diContainer.getArticleViewModel())
                .tabItem {
                    Label("아티클", systemImage: "newspaper")
                }
            
            ProfileView(viewModel: diContainer.getOnboardingViewModel())
                .tabItem {
                    Label("프로필", systemImage: "person.circle.fill")
                }
        }
    }
}

#Preview {
    MainTabView()
}
