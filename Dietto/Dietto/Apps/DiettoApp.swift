//
//  DiettoApp.swift
//  Dietto
//
//  Created by 안정흠 on 5/12/25.
//

import SwiftUI
import SwiftData

@main
struct DiettoApp: App {
    @AppStorage("isFirstLaunch") var isFirstLaunch: Bool = true
    var body: some Scene {
        WindowGroup {
            if isFirstLaunch {
                TutorialView()
            }
            else {
                MainTabView()
            }
        }
    }
}
