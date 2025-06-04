//
//  SubView.swift
//  Dietto
//
//  Created by 안세훈 on 6/4/25.
//

import SwiftUI

extension View {
    //MARK: - ProgressView Modifer
    func progressOverlay(isPresented: Binding<Bool>, message: String = "") -> some View {
        self.modifier(LogoProgressModifier(isPresented: isPresented, message: message))
    }
    
    //MARK: - ToastView Modifer
    func toastView(toast: Binding<ToastEntity?>) -> some View {
        self.modifier(ToastModifier(toast: toast))
    }
}
