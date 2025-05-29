//
//  OnboardingViewModel.swift
//  Dietto
//
//  Created by 안세훈 on 5/24/25.
//

import SwiftUI

final class OnboardingViewModel: ObservableObject {
    @AppStorage("isFirstLaunch") private var isFirstLaunch: Bool = true
    
    @Published var name: String = "name"
    @Published var gender: Gender = .male
    @Published var targetWeight: Int = 60
    @Published var targetDistance: Int = 60
    @Published var height: Int = 170
    @Published var weight: Int = 65
    
    @Published var showPhotoSheet: Bool = false
    @Published var showDatePicker: Bool = false
    
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
    }
    
    //MARK: - 프로필 설정
    func saveProfile() {
        userStorageUsecase.createUserData(
            UserEntity(id: UUID(),
                       name: name,
                       gender: gender,
                       height: height,
                       startWeight: weight,
                       currentWeight: weight,
                       targetWeight: targetWeight,
                       targetDistance: targetDistance)
        )
        weightHistroyUsecase.addNewWeight(weight: weight, date: Date())
        isFirstLaunch = false
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
