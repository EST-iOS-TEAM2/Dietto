//
//  ProgressViews.swift
//  Dietto
//
//  Created by 안세훈 on 6/2/25.
//

import SwiftUI

struct LogoProgress: View {
    @Binding var isAnimated: Bool
    var width: CGFloat = 190
    var message : String
    
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                //가려진 뷰
                VStack(spacing: 3) {
                    Text("Dietto")
                        .font(.NerkoOne80)
                        .frame(width: width)
                        .scaledToFit()
                        .foregroundStyle(.black.opacity(0.3))
                    Text(message)
                        .font(.pretendardBlack12)
                        .frame(width: width)
                        .scaledToFit()
                        .foregroundStyle(.black.opacity(0.3))
                }
                //진행중인 뷰
                VStack(spacing: 3) {
                    Text("Dietto")
                        .font(.NerkoOne80)
                        .frame(width: width)
                        .scaledToFit()
                        .foregroundStyle(.appMain)
                        .mask {
                            Rectangle()
                                .frame(width: isAnimated ? width : 0)
                                .offset(x: isAnimated ? 0 : -width)
                        }
                    Text(message)
                        .font(.pretendardBlack12)
                        .frame(width: width)
                        .scaledToFit()
                        .foregroundStyle(.appMain)
                        .mask {
                            Rectangle()
                                .frame(width: isAnimated ? width : 0)
                                .offset(x: isAnimated ? 0 : -width)
                        }
                }
            }
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(Color.black.opacity(0.25))
    }
}
//MARK: - ViewModifer

struct LogoProgressModifier: ViewModifier {
    @Binding var isPresented: Bool
    @State private var isAnimated = false
    @State var message: String = "TEST"
    
    var speed: Double = 0.3
    var delayTime: Double = 0.3
    
    func body(content: Content) -> some View {
        ZStack {
            content
            if isPresented {
                Rectangle()
                    .fill(Color.black.opacity(0.3))
                    .ignoresSafeArea()
                
                LogoProgress(isAnimated: $isAnimated, message: message)
                    .onAppear {
                        isAnimated = true
                    }
                    .animation(
                        .easeInOut
                            .speed(speed)
                            .delay(delayTime)
                            .repeatForever(autoreverses: false),
                        value: isAnimated
                    )
            }
        }
    }
}

extension View {
    func LogoProgressOverlay(isPresented: Binding<Bool>, message: String = "") -> some View {
        self.modifier(LogoProgressModifier(isPresented: isPresented, message: message))
    }
}

//MARK: - 프리뷰 하려고 임시로 만들어놓은 것.

#Preview {
    AnimatedLoadingPreview()
}

struct AnimatedLoadingPreview: View {
    @State private var isAnimated = false
    @State var message = "카리나카리나카리나카리나카리나"
    
    var body: some View {
        LogoProgress(isAnimated: $isAnimated, message: message)
            .onAppear {
                withAnimation(
                    .easeInOut
                        .speed(0.3)
                        .delay(0.3)
                        .repeatForever(autoreverses: false)
                ) {
                    isAnimated = true
                }
            }
    }
}
