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
    func updateUserDefaultData(id: UUID, userEntity: UserEntity) async throws
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
    
    func updateUserDefaultData(id: UUID, userEntity: UserEntity) async throws {
        do {
            let predicate = #Predicate<UserDTO> { $0.id == id }
            try await storage.updateData(predicate: predicate) { dto in
                dto.name = userEntity.name
                dto.gender = userEntity.gender.rawValue
                dto.height = userEntity.height
//                dto.startWeight = userEntity.startWeight
                dto.currentWeight = userEntity.currentWeight
                dto.targetWeight = userEntity.targetWeight
                dto.targetDistance = userEntity.targetDistance
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
