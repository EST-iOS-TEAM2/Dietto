//
//  WeightHistoryUsecase.swift
//  Dietto
//
//  Created by 안정흠 on 5/21/25.
//

import Foundation

protocol WeightHistoryUsecase {
    func addNewWeight(weight: Int, date: Date)
    func getWeightHistory(chartRange: ChartTimeType) async -> [WeightEntity]
}

final class WeightHistoryUsecaseImpl<Repository: StorageRepository>: WeightHistoryUsecase where Repository.T == WeightDTO {
    private let storage: Repository
    
    init(repository: Repository) {
        self.storage = repository
    }
    func addNewWeight(weight: Int, date: Date) {
        storage.insertData(data: WeightDTO(date: date, scale: weight))
    }
    
    func getWeightHistory(chartRange: ChartTimeType) async -> [WeightEntity] {
        let predicate = getDateRange(range: chartRange)
        
        do {
            let result = try await storage.fetchData(where: predicate, sort: [])
            return result.map{$0.convertEntity()}
        }
        catch {
            print("\(#function) : \(error.localizedDescription)")
            return []
        }
    }
    
    private func getDateRange(range: ChartTimeType) -> Predicate<WeightDTO> {
        let now = Date()
        let calendar = Calendar.current
        
        switch range {
        case .weekly: //현재부터 1주 전
            let oneWeekAgo = calendar.date(byAdding: .day, value: -7, to: now)!
            return #Predicate<WeightDTO> { $0.date >= oneWeekAgo }
        case .monthly: //현재부터 1달 전
            let oneMonthAgo = calendar.date(byAdding: .month, value: -1, to: now)!
            return #Predicate<WeightDTO> { $0.date >= oneMonthAgo }
        case .yearly: //현재부터 1년 전
            let oneYearAgo = calendar.date(byAdding: .year, value: -1, to: now)!
            return #Predicate<WeightDTO> { $0.date >= oneYearAgo }
        }
    }
}
