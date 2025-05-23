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
    func deleteUserData()
}

final class UserStorageUsecaseImpl<Repository: StorageRepository>: UserStorageUsecase where Repository.T == UserDTO {
    private let storage: Repository
    
    init(storage: Repository) {
        self.storage = storage
    }
    
    func createUserData(_ user: UserEntity) {
        
    }
    
    func getUserData() -> UserEntity? {
        return nil
    }
    
    func updateUserData(_ user: UserEntity) {
        
    }
    
    func deleteUserData() {
        
    }
    
    
}
