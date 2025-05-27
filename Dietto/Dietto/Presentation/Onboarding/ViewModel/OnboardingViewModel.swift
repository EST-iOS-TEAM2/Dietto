//
//  OnboardingViewModel.swift
//  Dietto
//
//  Created by 안세훈 on 5/24/25.
//

import SwiftUI

final class OnboardingViewModel: ObservableObject {
    
    let nickname: String = "asdasdasd"
    
    let weights: [Int] = Array(20...100).reversed()
    let distances: [Int] = Array(1...10).reversed()
    
    
    
    
    
    @Published var weight : Int = 0
    @Published var distance : Int = 0
    
    
    //MARK: - 목표 설정
    func setGoals(weight: Int, distance: Int) {
        self.weight = weight
        self.distance = distance
    }
    
    
}
