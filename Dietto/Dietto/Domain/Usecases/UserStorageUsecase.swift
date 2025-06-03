//
//  UserStorageUsecase.swift
//  Dietto
//
//  Created by 안정흠 on 5/21/25.
//

import Foundation
import Combine

protocol UserStorageUsecase {
    var changeEvent: CurrentValueSubject<Void, Never> { get }
  
    func createUserData(_ user: UserEntity) async throws
    func getUserData() async throws -> UserEntity
    func updateUserDefaultData(id: UUID, name: String, gender: Gender, height: Int) async throws
    func updateGoal(id: UUID, weight: Int, distance: Int) async throws
    func updateCurrentWeight(id: UUID, currentWeight: Int) async throws
    func deleteUserData() async throws
}

final class UserStorageUsecaseImpl<Repository: AnotherStorageRepository>: UserStorageUsecase where Repository.T == UserDTO {
    private let storage: Repository
    var changeEvent: CurrentValueSubject<Void, Never> = .init(())
    
    init(storage: Repository) {
        self.storage = storage
    }
    
    func createUserData(_ user: UserEntity) async throws {
        let data = UserDTO(
            id: user.id,
            name: user.name,
            gender: user.gender.rawValue,
            height: user.height,
            startWeight: user.startWeight,
            currentWeight: user.currentWeight,
            targetWeight: user.targetWeight,
            targetDistance: user.targetDistance,
        )
        do { try await storage.insertData(data: data) }
        catch {
            print(#function, error.localizedDescription)
            throw StorageError.insertError
        }
    }
    
    func getUserData() async throws -> UserEntity {
        do {
            let users = try await storage.fetchData(where: nil, sort: [])
            guard let user = users.first else { throw StorageError.fetchError }
            // UserDTO → UserEntity 변환
            return UserEntity(
                id: user.id,
                name: user.name,
                gender: Gender(rawValue: user.gender) ?? .female,
                height: user.height,
                startWeight: user.startWeight,
                currentWeight: user.currentWeight,
                targetWeight: user.targetWeight,
                targetDistance: user.targetDistance,
            )
        }
        catch {
            print(#function, error.localizedDescription)
            throw StorageError.fetchError
        }
    }
    
    func updateUserDefaultData(id: UUID, name: String, gender: Gender, height: Int) async throws {
        do {
            let predicate = #Predicate<UserDTO> { $0.id == id }
            try await storage.updateData(predicate: predicate) { dto in
                dto.name = name
                dto.gender = gender.rawValue
                dto.height = height
            }
            changeEvent.send()
        }
        catch {
            print(#function, error.localizedDescription)
            throw StorageError.updateError
        }
    }
    
    func updateGoal(id: UUID, weight: Int, distance: Int) async throws {
        do {
            let predicate = #Predicate<UserDTO> { $0.id == id }
            try await storage.updateData(predicate: predicate) { dto in
                dto.targetWeight = weight
                dto.targetDistance = distance
            }
            changeEvent.send()
        }
        catch {
            print(#function, error.localizedDescription)
            throw StorageError.updateError
        }
    }
    
    func updateCurrentWeight(id: UUID, currentWeight: Int) async throws {
        do {
            let predicate = #Predicate<UserDTO> { $0.id == id }
            try await storage.updateData(predicate: predicate) { dto in
                dto.currentWeight = currentWeight
            }
            changeEvent.send()
        }
        catch {
            print(#function, error.localizedDescription)
            throw StorageError.deleteError
        }
    }
    
    func deleteUserData() async throws {
        do { try await storage.deleteAll() }
        catch {
            print(#function, error.localizedDescription)
            throw StorageError.deleteError
        }
    }
}
