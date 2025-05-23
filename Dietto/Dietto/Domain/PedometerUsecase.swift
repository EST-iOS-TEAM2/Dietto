//
//  PedometerUsecase.swift
//  Dietto
//
//  Created by 안정흠 on 5/19/25.
//

import Foundation
import Combine

struct PedometerModel {
    var steps: Int
    var distance: Float // meter
}


protocol PedometerUsecase {
    func startLivePedometerData() -> AnyPublisher<PedometerModel?, Never>
    func stopLivePedometerData()
}

final class PedometerUsecaseImpl: PedometerUsecase {
    private let pedometer: PedometerRepository
    
    init(pedometer: PedometerRepository) {
        self.pedometer = pedometer
    }
    
    func startLivePedometerData() -> AnyPublisher<PedometerModel?, Never> { // err 처리
        pedometer.startPedometer()
            .map {
                PedometerModel(
                    steps: $0.numberOfSteps.intValue,
                    distance: ($0.distance?.floatValue ?? 0) / 1000
                )
            }
            .catch({ err in // X
                Just(nil)
            })
            .eraseToAnyPublisher()
    }
    
    func stopLivePedometerData() {
        pedometer.stopPedometer()
    }
}
