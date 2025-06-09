//
//  IngredientUsecase.swift
//  Dietto
//
//  Created by 안세훈 on 6/9/25.
//
import Foundation

//MARK: - Interface
protocol IngredientUsecase{
    func insertIngredient(_ ingredient: IngredientEntity) async throws
    func deleteIngredient(_ ingredient: IngredientEntity) async throws
    func fetchIngredient() async throws -> [IngredientEntity]
}

//MARK: - Implement
final class IngredientUsecaseImpl<Repository: AnotherStorageRepository>: IngredientUsecase where Repository.T == IngredientDTO {
    private let repository: Repository
    
    init(repository: Repository) {
        self.repository = repository
    }
    
    func insertIngredient(_ ingredient: IngredientEntity) async throws {
        do {
            try await repository.insertData(
                data: IngredientDTO(id: ingredient.id, ingredient: ingredient.ingredient)
            )
        }
        catch {
            print(#function, error.localizedDescription)
            throw StorageError.insertError
        }
    }
    
    func deleteIngredient(_ ingredient: IngredientEntity) async throws {
        let id = ingredient.id
        let predicate = #Predicate<IngredientDTO> { $0.id == id }
        do { try await repository.deleteData(where: predicate) }
        catch {
            print(#function, error.localizedDescription)
            throw StorageError.deleteError
        }
    }
    
    func fetchIngredient() async throws -> [IngredientEntity] {
        do {
            let result = try await repository.fetchData(where: nil, sort: [])
            return result.map{ IngredientEntity(id: $0.id, ingredient: $0.ingredient) }
        }
        catch {
            print(#function, error.localizedDescription)
            throw StorageError.fetchError
        }
    }
    
    
}

