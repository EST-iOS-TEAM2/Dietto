//
//  OnboardingView.swift
//  Dietto
//
//  Created by 안세훈 on 5/13/25.
//

import SwiftUI

struct OnboardingView: View {
    @AppStorage("isFirstLaunch") var isFirstLaunch: Bool = true
    var body: some View {
        VStack {
            Text("Onboarding View")
            Button("Done") {
                isFirstLaunch = false
            }
        }
    }
}

#Preview {
    OnboardingView()
}
