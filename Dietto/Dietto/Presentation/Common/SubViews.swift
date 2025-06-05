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
    //MARK: - 높이를 동적, 정적으로 모두 사용하기 위한 .iflet
    func iflet<T>(_ value: T?, apply: (Self, T) -> some View) -> some View{
        if let value = value{
            return AnyView(apply(self, value))
        }else{
            return AnyView(self)
        }
    }
}

