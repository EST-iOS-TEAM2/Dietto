//
//  UserStorageUsecase.swift
//  Dietto
//
//  Created by 안정흠 on 5/21/25.
//

import Foundation

protocol UserStorageUsecase {
    func createUserData(_ user: UserEntity)
    func getUserData() -> UserEntity?
    func updateUserData(_ user: UserEntity)
    func updateGoal(id: UUID, weight: Int, distance: Int)
    func updateCurrentWeight(id: UUID, currentWeight: Int)
    func deleteUserData()
}

final class UserStorageUsecaseImpl<Repository: StorageRepository>: UserStorageUsecase where Repository.T == UserDTO {
    private let storage: Repository
    
    init(storage: Repository) {
        self.storage = storage
    }
    
    func createUserData(_ user: UserEntity) {
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
        storage.insertData(data: data)
    }
    
    func getUserData() -> UserEntity? {
        do {
            let users = try storage.fetchData(where: nil, sort: [])
            guard let user = users.first else { return nil }
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
        } catch {
            print("\(#function) : \(error.localizedDescription)")
            return nil
        }
    }
    
    func updateUserData(_ user: UserEntity) {
        let userID = user.id
        let predicate = #Predicate<UserDTO> { $0.id == userID }
        do {
            try storage.updateData(predicate: predicate) { dto in
                dto.name = user.name
                dto.gender = user.gender.rawValue
                dto.height = user.height
            }
        }
        catch {
            print("\(#function) : \(error.localizedDescription)")
        }
    }
    
    func updateGoal(id: UUID, weight: Int, distance: Int) {
        let predicate = #Predicate<UserDTO> { $0.id == id }
        do {
            try storage.updateData(predicate: predicate) { dto in
                dto.targetWeight = weight
                dto.targetDistance = distance
            }
        }
        catch {
            print("\(#function) : \(error.localizedDescription)")
        }
    }
    
    func updateCurrentWeight(id: UUID, currentWeight: Int) {
        let predicate = #Predicate<UserDTO> { $0.id == id }
        do {
            try storage.updateData(predicate: predicate) { dto in
                dto.currentWeight = currentWeight
            }
        }
        catch {
            print("\(#function) : \(error.localizedDescription)")
        }
    }
    
    func deleteUserData() {
        do {
            try storage.deleteAll()
        }
        catch {
            print("\(#function) : \(error.localizedDescription)")
        }
        
    }
    
    
}
