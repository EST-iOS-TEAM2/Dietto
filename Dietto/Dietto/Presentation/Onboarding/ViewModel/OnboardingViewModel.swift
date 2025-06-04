//
//  OnboardingViewModel.swift
//  Dietto
//
//  Created by 안세훈 on 5/24/25.
//

import SwiftUI
import Combine

final class OnboardingViewModel: ObservableObject {
    @AppStorage("isFirstLaunch") private var isFirstLaunch: Bool = true
    
    @Published var name: String = ""
    @Published var gender: Gender = .male
    
    @Published var targetWeight: Int = 0
    @Published var targetDistance: Int = 0
    
    @Published var height: String = ""
    @Published var weight : String = ""
    
    @Published var showPhotoSheet: Bool = false
    @Published var showDatePicker: Bool = false
    
    @Published var isEditActive: Bool = false
    @Published var isDeleteAlert: Bool = false
    
    private var currentUserId: UUID?
    
    @Published var isProfileSaved : Bool = false
    
    let weights: [Int] = Array(20...100).reversed()
    let distances: [Int] = Array(1...10).reversed()
    
    private let userStorageUsecase: UserStorageUsecase
    private let weightHistroyUsecase: WeightHistoryUsecase
    private var bag = Set<AnyCancellable>()
    
    init(
        weightHistroyUsecase: WeightHistoryUsecase,
        userStorageUsecase: UserStorageUsecase
    ) {
        self.weightHistroyUsecase = weightHistroyUsecase
        self.userStorageUsecase = userStorageUsecase
        
        self.userStorageUsecase.changeEvent
            .sink {[weak self] in
                self?.getUserData()
            }
            .store(in: &bag)
    }
    
    private func getUserData() {
        Task {
            do {
                let user = try await self.userStorageUsecase.getUserData()
                await MainActor.run {
                    self.currentUserId = user.id
                    self.name = user.name
                    self.gender = user.gender
                    self.height = String(user.height)
                    self.weight = String(user.currentWeight)
                    self.targetWeight = user.targetWeight
                    self.targetDistance = user.targetDistance
                }
            }
            catch {
                #warning("여기에 에러핸들링 토스트 팝업 등 넣기")
            }
        }
    }
    
    //MARK: - 프로필 설정
    func saveProfile() {
        guard let weight = Int(weight), let height = Int(height) else {
            //여기서 토스트 팝업 띄우거나 하면 될듯요
            // 이름이나 다른 것도 닐체크 여기서 해도 될듯요
            // 오키?
            print("nil checking", #function)
            return
        }
        
        //MARK: - 최초 진입
        if isFirstLaunch {
            createNewProfile(weight: weight, height: height)
        } else {
            guard let currentUserId = currentUserId else {
                fatalError("CurrentUser is nil") //없으면 말도 안되고 완전 꼬여버리기 때문에 일단 조치해둠
            }
            editProfile(currentUserId: currentUserId, weight: weight, height: height)
        }
    }
    
    private func editProfile(currentUserId: UUID, weight: Int, height: Int) {
        Task {
            do {
                if let lastModifiedDate = try await weightHistroyUsecase.getWeightHistory(chartRange: .weekly).last?.date,
                   lastModifiedDate.isSameDateWithoutTime(date: Date())
                {
                    try await weightHistroyUsecase.updateWeightByDate(weight: weight, date: lastModifiedDate)
                }
                
                try await userStorageUsecase.updateUserDefaultData(id: currentUserId, name: name, gender: gender, height: height)
                try await userStorageUsecase.updateGoal(id: currentUserId, weight: targetWeight, distance: targetDistance)
                try await userStorageUsecase.updateCurrentWeight(id: currentUserId, currentWeight: weight)
                
                await MainActor.run { isEditActive = false }
            }
            catch {
#warning("여기에 에러핸들링 토스트 팝업 등 넣기")
            }
        }
    }
    
    private func createNewProfile(weight: Int, height: Int) {
        Task {
            do {
                let userEntity = UserEntity(
                    id: UUID(),
                    name: name,
                    gender: gender,
                    height: height,
                    startWeight: weight,
                    currentWeight: weight,
                    targetWeight: targetWeight,
                    targetDistance: targetDistance
                )
                try await userStorageUsecase.createUserData(userEntity)
                try await weightHistroyUsecase.addNewWeight(weight: weight, date: Date())
                await MainActor.run {
                    isProfileSaved = true
                }
                try await Task.sleep(for: .seconds(4))
                await MainActor.run {
                    self.isFirstLaunch = false
                    self.isProfileSaved = false
                }
            }
            catch {
#warning("여기에 에러핸들링 토스트 팝업 등 넣기")
            }
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
        Task {
            do {
                try await userStorageUsecase.deleteUserData()
                try await weightHistroyUsecase.deleteAllWeightHistory()
                isFirstLaunch = true
            }
            catch {
#warning("여기에 에러핸들링 토스트 팝업 등 넣기")
            }
        }
    }
    
}
