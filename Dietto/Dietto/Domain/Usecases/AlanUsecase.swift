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
    func fetchArticle(topics : [InterestEntity]) async throws -> [ArticleEntity]
}

//MARK: - UsecaseImpl
final class AlanUsecaseImpl : AlanUsecase {
    
    private let repository: NetworkRepository
    
    init(repository: NetworkRepository) {
        self.repository = repository
    }
    
    //추천식단
    func fetchRecommend(ingredients: [IngredientEntity]) async throws -> [RecommendEntity] {
        let wrapper = try await repository.fetch(promptType: .recommend, rawValues: ingredients, outputType: RecommendDTO.self)
        
        return wrapper.recommendation
    }
    
    //아티클
    func fetchArticle(topics: [InterestEntity]) async throws -> [ArticleEntity] {
        let wrapper = try await repository.fetch(promptType: .article, rawValues: topics, outputType: ArticleDTO.self)
        
        return wrapper.articles
    }
    
}
