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
    var chartTimeType: ChartTimeType = .weekly
    var bodyScaleHistory: [WeightEntity] = []
    var pedometerData: PedometerModel?
    var currentDistance: Float {
        get {
            if let distance = pedometerData?.distance,
               let targetDistance = userData?.targetDistance
            {
                return distance < Float(targetDistance) ? distance : Float(targetDistance)
            }
            else { return 0 }
        }
    }
    
    var userData: UserEntity?
    
    
    private let pedometerUsecase: PedometerUsecase
    private let weightHistroyUsecase: WeightHistoryUsecase
    private let userStorageUsecase: UserStorageUsecase
    private var bag = Set<AnyCancellable>()
    
    
    init(
        pedometerUsecase: PedometerUsecase = PedometerUsecaseImpl(pedometer: PedometerRepositoryImpl()),
        weightHistroyUsecase: WeightHistoryUsecase,
        userStorageUsecase: UserStorageUsecase
        
    ) {
        self.pedometerUsecase = pedometerUsecase
        self.weightHistroyUsecase = weightHistroyUsecase
        self.userStorageUsecase = userStorageUsecase
        
        self.userStorageUsecase.changeEvent
            .sink {[weak self] in
                self?.getUserData()
                self?.bodyScaleHistoryFetch(type: self?.chartTimeType ?? .weekly)
            }
            .store(in: &bag)
    }
    
    private func getUserData() {
        Task { [weak self] in
            do {
                let userData = try await self?.userStorageUsecase.getUserData()
                await MainActor.run { [weak self] in
                    self?.userData = userData
                }
            }
            catch {
#warning("여기에 에러핸들링 토스트 팝업 등 넣기 (데이터 없으면 온보딩으로 or fatal..?")
            }
        }
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
              let id = userData?.id,
              let lastModifiedDate = bodyScaleHistory.last?.date else {
            print("\(#function) : FAILED to update current body scale")
            return
        }
        Task {
            do {
                try await userStorageUsecase.updateCurrentWeight(id: id, currentWeight: value)
                if lastModifiedDate.isSameDateWithoutTime(date: Date()) {
                    try await weightHistroyUsecase.updateWeightByDate(weight: value, date: lastModifiedDate)
                }
                else {
                    try await weightHistroyUsecase.addNewWeight(weight: value, date: Date())
                }
                await MainActor.run {
                    userData?.currentWeight = value                  
                }
                bodyScaleHistoryFetch(type: chartTimeType)
            }
            catch {
#warning("여기에 에러핸들링 토스트 팝업 등 넣기")
            }
        }
    }
    
    func bodyScaleHistoryFetch(type: ChartTimeType) {
        Task {
            do {
                let result = try await weightHistroyUsecase.getWeightHistory(chartRange: type)
                await MainActor.run {
                    chartTimeType = type
                    guard result.count >= type.limitDataCount() else {
                        bodyScaleHistory = []
                        return
                    }
                    bodyScaleHistory = result
                    chartAnimate()
                }
            }
            catch {
#warning("여기에 에러핸들링 토스트 팝업 등 넣기")
            }
        }
    }
    
    private func chartAnimate() {
        guard !bodyScaleHistory.isEmpty else { return }

        for (index, _) in bodyScaleHistory.enumerated() {
            let delay = Double(index) * 0.05
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [weak self] in
                withAnimation(.bouncy) {
                    self?.bodyScaleHistory[index].isAnimated = true
                }
                if let count = self?.bodyScaleHistory.count,
                   index >= count - 1 {
                }
            }
        }
    }
}
