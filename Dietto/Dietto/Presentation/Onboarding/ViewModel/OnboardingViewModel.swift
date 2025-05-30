//
//  OnboardingViewModel.swift
//  Dietto
//
//  Created by 안세훈 on 5/24/25.
//

import SwiftUI

final class OnboardingViewModel: ObservableObject {
    @AppStorage("isFirstLaunch") private var isFirstLaunch: Bool = true
    
    @Published var name: String = ""
    @Published var gender: Gender = .male
    
    @Published var targetWeight: Int = 60
    @Published var targetDistance: Int = 2
    
    @Published var height: String
    @Published var weight : String
    
    @Published var showPhotoSheet: Bool = false
    @Published var showDatePicker: Bool = false
    
    @Published var isEditActive: Bool = false
    @Published var isDeleteAlert: Bool = false
    
    private var currentUserId: UUID?
    
    let weights: [Int] = Array(20...100).reversed()
    let distances: [Int] = Array(1...10).reversed()
    
    private let userStorageUsecase: UserStorageUsecase
    private let weightHistroyUsecase: WeightHistoryUsecase
    
    init(
        weightHistroyUsecase: WeightHistoryUsecase = WeightHistoryUsecaseImpl(repository: StorageRepositoryImpl<WeightDTO>()),
        userStorageUsecase: UserStorageUsecase = UserStorageUsecaseImpl(storage: StorageRepositoryImpl<UserDTO>())
    ) {
        self.weightHistroyUsecase = weightHistroyUsecase
        self.userStorageUsecase = userStorageUsecase
        
        
        if let user = userStorageUsecase.getUserData() {
            currentUserId = user.id
            name = user.name
            gender = user.gender
            height = user.height
            startWeight = user.startWeight
            weight = user.currentWeight
            targetWeight = user.targetWeight
            targetDistance = user.targetDistance
        }
    }
    
    //MARK: - 프로필 설정
    func saveProfile() {
        let userEntity = UserEntity(
            id: currentUserId ?? UUID(),
            name: name,
            gender: gender,
            height: height,
            startWeight: weight,
            currentWeight: weight,
            targetWeight: targetWeight,
            targetDistance: targetDistance
        )
        
        currentUserId = userEntity.id
        
        //최초
        if isFirstLaunch {
            userStorageUsecase.createUserData(userEntity)
            weightHistroyUsecase.addNewWeight(weight: weight, date: Date())
            isFirstLaunch = false
        //수정
        } else {
            userStorageUsecase.createUserData(userEntity)
            userStorageUsecase.updateCurrentWeight(id: <#T##UUID#>, currentWeight: <#T##Int#>)
            isEditActive = false
        }
    }
    
    func selectGender(_ gender: Gender) {
        self.gender = gender
    }
    
    //MARK: - 목표 설정
    func setGoals(weight: Int, distance: Int) {
        self.targetWeight = weight
        self.targetDistance = distance
    }
    
    func deleteAllUserData() {
        userStorageUsecase.deleteUserData()
        weightHistroyUsecase.deleteAllWeightHistory()
        isFirstLaunch = true
    }
    
}
