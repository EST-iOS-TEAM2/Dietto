//
//  LoadingIndicator.swift
//  Dietto
//
//  Created by 안세훈 on 6/1/25.
//

import SwiftUI

struct LoadingViewModifier: ViewModifier {
    let isLoading: Bool
    var tint: Color = .white
    var scale: CGFloat = 1.5
    var overlayColor: Color = Color.white.opacity(0.3)
    
    func body(content: Content) -> some View {
        ZStack {
            content
            if isLoading {
                overlayColor.ignoresSafeArea()
                ProgressView().progressViewStyle(CircularProgressViewStyle(tint: .appMain))
                    .scaleEffect(1.5)
                    .padding()
            }
        }
    }
}


extension View {
    func loadingOverlay(isLoading: Bool, tint: Color = .appMain, scale: CGFloat = 1.5, overlayColor: Color = Color.black.opacity(0.15)) -> some View {
        self.modifier(LoadingViewModifier(isLoading: isLoading, tint: tint, scale: scale, overlayColor: overlayColor))
    }
}

#Preview {
    ZStack {
    }.loadingOverlay(isLoading: true)
}
