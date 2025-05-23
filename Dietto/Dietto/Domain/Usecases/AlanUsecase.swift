//
//  AlanUsecase.swift
//  Dietto
//
//  Created by 안세훈 on 5/19/25.
//

import Foundation

//MARK: - Usecase

protocol AlanUsecase {
    func fetchRecommend(ingredients: [IngredientEntity]) async throws -> [RecommendEntity]
    func fetchArticle(topics : [ArticleEntity]) async throws -> [ArticleEntity]
}

//MARK: - UsecaseImpl
final class AlanUsecaseImpl : AlanUsecase {
    
    private let repository: NetworkRepository
    
    init(repository: NetworkRepository) {
        self.repository = repository
    }
    
    func fetchRecommend(ingredients: [IngredientEntity]) async throws -> [RecommendEntity] {
        
        let wrapper: RecommendDTO = try await repository.fetch(
            promptType: .recommend,
            rawValues: ingredients,
            outputType: RecommendDTO.self
        )
        
        return wrapper.recommendation
    }
    
    func fetchArticle(topics: [ArticleEntity]) async throws -> [ArticleEntity] {
        
        let wrapper: ArticleDTO = try await repository.fetch(
            promptType: .recommend,
            rawValues: topics,
            outputType: ArticleDTO.self
        )
        
        return wrapper.articles
    }
    
}
