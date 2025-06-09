//
//  IngredientUsecase.swift
//  Dietto
//
//  Created by 안세훈 on 6/9/25.
//
import Foundation

//MARK: - Interface
protocol IngredientUsecase{
    func insertIngredient(_ Ingredient: IngredientEntity) async throws
    func deleteIngredient(_ Ingredient: IngredientEntity) async throws
    func fetchIngredient() async throws -> [IngredientEntity]
}

//MARK: - Implement
final class IngredientUsecaseImpl : IngredientUsecase {
    
    func insertIngredient(_ Ingredient: IngredientEntity) async throws {
        <#code#>
    }
    
    func deleteIngredient(_ Ingredient: IngredientEntity) async throws {
        <#code#>
    }
    
    func fetchIngredient() async throws -> [IngredientEntity] {
        <#code#>
    }
    
    
}

