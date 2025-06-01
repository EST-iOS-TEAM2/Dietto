//
//  InterestsUsecaseImpl.swift
//  Dietto
//
//  Created by 안정흠 on 5/27/25.
//

import Foundation

protocol InterestsUsecase {
    func insertInterests(_ interests: InterestEntity) async throws
    func deleteInterests(_ interests: InterestEntity) async throws
    func fetchInterests() async throws -> [InterestEntity]
}

final class InterestsUsecaseImpl<Repository: AnotherStorageRepository>: InterestsUsecase where Repository.T == InterestsDTO {
    private let repository: Repository
    
    init(repository: Repository) {
        self.repository = repository
    }
    
    func insertInterests(_ interests: InterestEntity) async throws {
        try await repository.insertData(data: InterestsDTO(title: interests.title))
    }
    
    func deleteInterests(_ interests: InterestEntity) async throws {
        do {
            let title = interests.title
            let predicate = #Predicate<InterestsDTO> { $0.title == title }
            try await repository.deleteData(where: predicate)
        }
        catch {
            print("\(#function) : \(error.localizedDescription)")
        }
        
    }
    
    func fetchInterests() async throws -> [InterestEntity] {
        do {
            let result = try await repository.fetchData(where: nil, sort: [])
            return result.map{InterestEntity(title: $0.title)}
        }
        catch {
            print("\(#function) : \(error.localizedDescription)")
            return []
        }
    }
}
