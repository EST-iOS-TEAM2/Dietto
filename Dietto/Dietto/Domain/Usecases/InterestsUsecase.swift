//
//  InterestsUsecase.swift
//  Dietto
//
//  Created by 안정흠 on 5/27/25.
//

import Foundation

protocol InterestsUsecase {
    func updateInterests(_ interests: [InterestEntity])
    func fetchInterests() -> [InterestEntity]
}

final class InterestsUsecase<Repository: StorageRepository>: InterestsUsecase where Repository.T == InterestEntity {
    private let repository: Repository
    
//    init(repository: StorageRepository = StorageRepositoryImpl()) {
//        self.repository = repository
//    }
}
