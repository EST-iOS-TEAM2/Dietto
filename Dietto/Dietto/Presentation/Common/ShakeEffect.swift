//
//  ShakeEffect.swift
//  Dietto
//
//  Created by 안정흠 on 5/24/25.
//
import SwiftUI

struct ShakeEffect: GeometryEffect {
    private let amount: CGFloat = 10.0
    private let shakesPerUnit: CGFloat = 2.0
    public var animatableData: CGFloat

    public init(animatableData: CGFloat) {
        self.animatableData = animatableData
    }
    
    public func effectValue(size: CGSize) -> ProjectionTransform {
        ProjectionTransform(
            CGAffineTransform(
                translationX: self.amount * sin(self.animatableData * .pi * self.shakesPerUnit),
                y: 0.0
            )
        )
    }
}
