//
//  PedometerUsecase.swift
//  Dietto
//
//  Created by 안정흠 on 5/19/25.
//

import Foundation
import CoreMotion
import Combine

struct PedometerModel {
    var steps: Int
    var distance: Float // meter
}


protocol PedometerUsecase {
    func startLivePedometerData() -> AnyPublisher<PedometerModel?, Never>
    func stopLivePedometerData()
    func getPedometerDataFromDate(start: Date, end: Date) -> AnyPublisher<PedometerModel?, Never>
}

final class PedometerUsecaseImpl: PedometerUsecase {
    private let pedometer: PedometerRepository
    
    init(pedometer: PedometerRepository) {
        self.pedometer = pedometer
    }
    
    func startLivePedometerData() -> AnyPublisher<PedometerModel?, Never> {
        pedometer.startPedometer()
            .map {
                PedometerModel(
                    steps: $0.numberOfSteps.intValue,
                    distance: ($0.distance?.floatValue ?? 0) / 1000
                )
            }
            .catch({ err in
                Just(nil)
            })
            .eraseToAnyPublisher()
    }
    
    func stopLivePedometerData() {
        pedometer.stopPedometer()
    }
    
    func getPedometerDataFromDate(start: Date, end: Date) -> AnyPublisher<PedometerModel?, Never> {
        pedometer.fetchPedometerFromDate(start: start, end: end)
            .map {
                PedometerModel(
                    steps: $0.numberOfSteps.intValue,
                    distance: ($0.distance?.floatValue ?? 0) / 1000
                )
            }
            .catch({ err in
                Just(nil)
            })
            .eraseToAnyPublisher()
    }
}
