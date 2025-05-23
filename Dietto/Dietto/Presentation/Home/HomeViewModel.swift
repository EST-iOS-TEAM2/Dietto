//
//  HomeViewModel.swift
//  Dietto
//
//  Created by 안정흠 on 5/19/25.
//

import Foundation
import CoreMotion
import Observation
import Combine

@Observable
final class HomeViewModel {
    var currentBodyScale: Int = 0
    var startBodyScale: Int = 0
    var targetBodyScale: Int = 0
    
    var bodyScaleHistory: [WeightEntity] = []
    var pedometerData: PedometerModel?
    var userData: UserEntity = UserEntity(name: "홍길동", birth: Date(), gender: .male, height: 170, weight: 68, targetWeight: 62, targetDistance: 5, favorite: [])
    
    
    private let pedometerUsecase: PedometerUsecase
    private let weightHistroyUsecase: WeightHistoryUsecase
    private var bag = Set<AnyCancellable>()
//    private let userUsecase: UserUsecase
    
    init(
        pedometerUsecase: PedometerUsecase = PedometerUsecaseImpl(pedometer: PedometerRepositoryImpl()),
        weightHistroyUsecase: WeightHistoryUsecase = WeightHistoryUsecaseImpl(repository: StorageRepositoryImpl<WeightDTO>())
    ) {
        self.pedometerUsecase = pedometerUsecase
        self.weightHistroyUsecase = weightHistroyUsecase
    }
    
    func fetchPedometer() {
        guard bag.isEmpty else {
            print("already exist")
            return
        }
        pedometerUsecase.startLivePedometerData()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] pedometer in
                if let pedometer {
                    self?.pedometerData = PedometerModel(steps: pedometer.steps, distance: pedometer.distance)
                    print(self?.pedometerData)
                }
                else { self?.pedometerData = nil }
            }
            .store(in: &bag)
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
