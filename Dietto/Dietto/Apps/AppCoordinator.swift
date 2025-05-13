//
//  AppCoordinator.swift
//  Dietto
//
//  Created by 안세훈 on 5/13/25.
//

import SwiftUI

struct AppCoordinator<Content: View>: View {
    @StateObject private var coordinator = Coordinator<Destination>()
    private let content: () -> Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    
    var body: some View {
        NavigationStack(path: $coordinator.paths) {
            content()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .navigationDestination(for: Destination.self) { destination in
                    coordinator.view(for: destination)
                }
        }
        .environmentObject(coordinator)
    }
}
