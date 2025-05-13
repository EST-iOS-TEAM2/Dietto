//
//  Destination.swift
//  Dietto
//
//  Created by 안세훈 on 5/13/25.
//

import SwiftUI
import Combine

enum Destination: Hashable {
    case goLoginView
    case goOnboardingView
    case goHomeView
}

final class Coordinator<T: Hashable>: ObservableObject {
    @Published var paths: [T] = []
    
    @ViewBuilder
    func view(for destination: Destination) -> some View {
        switch destination {
        case .goLoginView:
            LoginView()
        case .goOnboardingView:
            OnboardingView()
        case .goHomeView:
            HomeView()
        }
    }
    
    func push(_ path: T) {
        paths.append(path)
    }
    
    func pop() {
        paths.removeLast()
    }
    
    func pop(to: T) {
        guard let found = paths.firstIndex(where: { $0 == to }) else { return }
        
        let numToPop = (found..<paths.endIndex).count - 1
        paths.removeLast(numToPop)
    }
    
    func popToRoot() {
        paths.removeAll()
    }
}
