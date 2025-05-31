//
//  HomeViewModel.swift
//  Dietto
//
//  Created by 안정흠 on 5/19/25.
//

import Foundation
import SwiftUI
import CoreMotion
import Observation
import Combine

enum ChartTimeType: String, CaseIterable {
    case weekly = "주간"
    case monthly = "월간"
    case yearly = "연간"
    
    func limitDataCount() -> Int {
        switch self {
        case .weekly: return 7/2
        case .monthly: return 30/2
        case .yearly: return 365/2
        }
    }
}

@Observable
final class HomeViewModel {
    var isAnimating: Bool = false
    var chartTimeType: ChartTimeType = .weekly
    var bodyScaleHistory: [WeightEntity] = []
    var pedometerData: PedometerModel?
    
    var userData: UserEntity
    
    
    private let pedometerUsecase: PedometerUsecase
    private let weightHistroyUsecase: WeightHistoryUsecase
    private let userStorageUsecase: UserStorageUsecase
    private var bag = Set<AnyCancellable>()
    
    
    init(
        pedometerUsecase: PedometerUsecase = PedometerUsecaseImpl(pedometer: PedometerRepositoryImpl()),
        weightHistroyUsecase: WeightHistoryUsecase = WeightHistoryUsecaseImpl(repository: StorageRepositoryImpl<WeightDTO>()),
        userStorageUsecase: UserStorageUsecase = UserStorageUsecaseImpl(storage: StorageRepositoryImpl<UserDTO>())
        
    ) {
        self.pedometerUsecase = pedometerUsecase
        self.weightHistroyUsecase = weightHistroyUsecase
        self.userStorageUsecase = userStorageUsecase
        if let userData = userStorageUsecase.getUserData() {
            self.userData = userData
        }
        else { fatalError("데이터 없음") }
        bodyScaleHistoryFetch(type: chartTimeType)
        
        self.userStorageUsecase.subscribeChangeEvent()
            .sink {[weak self] in
                if let data = self?.userStorageUsecase.getUserData() {
                    self?.userData = data
                }
            }
            .store(in: &bag)
    }
    
    func fetchPedometer() {
        //        guard bag.isEmpty else { return }
        pedometerUsecase.startLivePedometerData()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] pedometer in
                withAnimation(.easeInOut(duration: 0.25)) {
                    if let pedometer {
                        self?.pedometerData = PedometerModel(steps: pedometer.steps, distance: pedometer.distance)
                    }
                    else { self?.pedometerData = nil }
                }
            }
            .store(in: &bag)
    }
    
    func updateCurrentBodyScale(_ value: String) {
        guard let value = Int(value),
              let lastModifiedDate = bodyScaleHistory.last?.date else {
            print("\(#function) : FAILED to update current body scale")
            return
        }
        userStorageUsecase.updateCurrentWeight(id: userData.id, currentWeight: value)
        if compareDate(Date(), lastModifiedDate) {
            weightHistroyUsecase.updateWeightByDate(weight: value, date: lastModifiedDate)
        }
        else {
            weightHistroyUsecase.addNewWeight(weight: value, date: Date())
        }
        bodyScaleHistoryFetch(type: chartTimeType)
    }
    
    func bodyScaleHistoryFetch(type: ChartTimeType) {
        chartTimeType = type
        let result = weightHistroyUsecase.getWeightHistory(chartRange: type)
        
        if result.count >= type.limitDataCount() {
            bodyScaleHistory = result
            chartAnimate()
        }
        else { bodyScaleHistory = [] }
    }
    
    private func chartAnimate() {
        guard !bodyScaleHistory.isEmpty else { return }
        isAnimating = true
        for (index, _) in bodyScaleHistory.enumerated() {
            let delay = Double(index) * 0.05
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                withAnimation(.bouncy) {
                    self.bodyScaleHistory[index].isAnimated = true
                }
                if index >= self.bodyScaleHistory.count - 1 {
                    self.isAnimating = false
                }
            }
        }
    }
    
    private func compareDate(_ date1: Date, _ date2: Date) -> Bool {
        let date1 = Calendar.current.dateComponents([.year, .month, .day], from: date1)
        let date2 = Calendar.current.dateComponents([.year, .month, .day], from: date2)
        
        return date1.year == date2.year && date1.month == date2.month && date1.day == date2.day
    }
}


//        result.forEach { item in
//            print(item)
//        }
//        print()
//        if type == .weekly {
//            result = [
//                WeightEntity(date: Date()-(86400*3), scale: 70),
//                WeightEntity(date: Date()-(86400*2), scale: 65),
//                WeightEntity(date: Date()-86400, scale: 55),
//                WeightEntity(date: Date(), scale: 50),
//                WeightEntity(date: Date()+86400, scale: 55)
//            ]
//        }
//        else if type == .monthly {
//            result = [
//                WeightEntity(date: Date()-(86400*3), scale: 70),
//                WeightEntity(date: Date()-(86400*2), scale: 65),
//                WeightEntity(date: Date()-86400, scale: 55),
//                WeightEntity(date: Date(), scale: 50),
//                WeightEntity(date: Date()+86400, scale: 55),
//                WeightEntity(date: Date()+(86400*2), scale: 63),
//                WeightEntity(date: Date()+(86400*3), scale: 72),
//                WeightEntity(date: Date()+(86400*4), scale: 82),
//                WeightEntity(date: Date()+(86400*5), scale: 72),
//                WeightEntity(date: Date()+(86400*6), scale: 62),
//                WeightEntity(date: Date()+(86400*7), scale: 52),
//                WeightEntity(date: Date()+(86400*8), scale: 52),
//                WeightEntity(date: Date()+(86400*9), scale: 52),
//                WeightEntity(date: Date()+(86400*10), scale: 52),
//                WeightEntity(date: Date()+(86400*11), scale: 58)
//            ]
//        }
