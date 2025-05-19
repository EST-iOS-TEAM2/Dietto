//
//  HomeViewModel.swift
//  Dietto
//
//  Created by 안정흠 on 5/19/25.
//

import Foundation
import CoreMotion
import Observation

@Observable
final class HomeViewModel {
    var currentBodyScale: Int = 0
    var startBodyScale: Int = 0
    var targetBodyScale: Int = 0
    var bodyScaleHistory: [BodyScale] = []
    
    var pedometerData: PedometerModel?
    
    private let pedometerUsecase: PedometerUsecase
    
    init(pedometerUsecase: PedometerUsecase) {
        self.pedometerUsecase = pedometerUsecase
    }
    
    func requestCoreMotionAuthorization() {
        
    }
    
    func fetchStepCount() {
        
    }
    
    func fetchDistance() {
        
    }
    
    func updateCurrentBodyScale(_ value: Int) {
        
        // 마지막에 bodyScaleHistoryFetch 필요함
    }
    
    func bodyScaleHistoryFetch(type: ChartTimeType) {
        switch type {
        case .weekly:
            break
        case .monthly:
            break
        case .yearly:
            break
        }
    }
}
