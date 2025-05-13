////
////  TabBar.swift
////  Dietto
////
////  Created by 안세훈 on 5/13/25.
////
//
//import SwiftUI
//
//struct TabBar : View {
//    enum Tab {
//        case Home
//        case Workout
//        case Dietary
//        case Community
//    }
//    
//    @State private var selectedTab : Tab = .Home
//    
//    var body: some View{
//        ZStack{
//            TabView(selection: $selectedTab) {
//                Group{
//                    NavigationStack{
//                        HomeView()
//                    }.tabItem {
//                        Text("홈")
//                    }
//                    
//                    NavigationStack{
//                        WorkoutView()
//                    }
//                    .tabItem {
//                        Text("운동")
//                    }
//                    
//                    NavigationStack{
//                        DietaryView()
//                    }
//                    .tabItem {
//                        Text("식단")
//                    }
//                    
//                    NavigationStack{
//                        CommunityView()
//                    }
//                    .tabItem {
//                        Text("친구")
//                    }
//                }
//            }
//        }
//    }
//}
//
//#Preview {
//    TabBar()
//}
