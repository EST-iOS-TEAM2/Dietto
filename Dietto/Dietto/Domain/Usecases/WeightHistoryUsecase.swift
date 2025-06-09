//
//  WeightHistoryUsecase.swift
//  Dietto
//
//  Created by 안정흠 on 5/21/25.
//

import Foundation

protocol WeightHistoryUsecase {
    func addNewWeight(weight: Int, date: Date) async throws
    func getWeightHistory(chartRange: ChartTimeType) async throws -> [WeightEntity]
    func deleteAllWeightHistory() async throws
    func updateWeightByDate(weight: Int, date: Date) async throws
}

final class WeightHistoryUsecaseImpl<Repository: AnotherStorageRepository>: WeightHistoryUsecase where Repository.T == WeightDTO {
    private let storage: Repository
    
    init(repository: Repository) {
        self.storage = repository
    }
    func addNewWeight(weight: Int, date: Date) async throws {
        do { try await storage.insertData(data: WeightDTO(date: date, scale: weight)) }
        catch {
            print(#function, error.localizedDescription)
            throw StorageError.insertError
        }
    }
    
    func getWeightHistory(chartRange: ChartTimeType) async throws -> [WeightEntity] {
        do {
            let predicate = getDateRange(range: chartRange)
            let result = try await storage.fetchData(where: predicate, sort: [])
            return result.map{$0.convertEntity()}
        }
        catch {
            print(#function, error.localizedDescription)
            throw StorageError.fetchError
        }
    }
  
  func updateWeightByDate(weight: Int, date: Date) async throws {
        do {
            let predicate = #Predicate<WeightDTO> { $0.date == date }
            try await storage.updateData(predicate: predicate) { dto in
                dto.scale = weight
            }
        }
        catch {
            print("\(#function) : \(error.localizedDescription)")
        }
    }
    
    func deleteAllWeightHistory() async throws {
        do { try await storage.deleteAll()}
        catch {
            print(#function, error.localizedDescription)
            throw StorageError.deleteError
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
