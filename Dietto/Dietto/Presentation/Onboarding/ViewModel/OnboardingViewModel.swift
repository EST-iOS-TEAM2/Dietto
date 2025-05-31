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
    
    @Published var targetWeight: Int = 60
    @Published var targetDistance: Int = 2
    
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
        weightHistroyUsecase: WeightHistoryUsecase = WeightHistoryUsecaseImpl(repository: StorageRepositoryImpl<WeightDTO>()),
        userStorageUsecase: UserStorageUsecase = UserStorageUsecaseImpl(storage: StorageRepositoryImpl<UserDTO>())
    ) {
        self.weightHistroyUsecase = weightHistroyUsecase
        self.userStorageUsecase = userStorageUsecase
        
        
        if let user = userStorageUsecase.getUserData() {
            currentUserId = user.id
            name = user.name
            gender = user.gender
            height = String(user.height)
            weight = String(user.currentWeight)
            targetWeight = user.targetWeight
            targetDistance = user.targetDistance
        }
        
        userStorageUsecase.subscribeChangeEvent()
            .receive(on: DispatchQueue.main)
            .sink {[weak self] in
                if let user = self?.userStorageUsecase.getUserData() {
                    self?.currentUserId = user.id
                    self?.name = user.name
                    self?.gender = user.gender
                    self?.height = String(user.height)
                    self?.weight = String(user.currentWeight)
                    self?.targetWeight = user.targetWeight
                    self?.targetDistance = user.targetDistance
                }
            }
            .store(in: &bag)
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
            userStorageUsecase.createUserData(userEntity)
            weightHistroyUsecase.addNewWeight(weight: weight, date: Date())
            
            isProfileSaved = true
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                self.isFirstLaunch = false
                self.isProfileSaved = false
            }
            
            //MARK: - 프로필 수정
        } else {
            guard let currentUserId = currentUserId else {
                fatalError("CurrentUser is nil") //없으면 말도 안되고 완전 꼬여버리기 때문에 일단 조치해둠
            }
            userStorageUsecase.updateUserDefaultData(id: currentUserId, name: name, gender: gender, height: height)
            userStorageUsecase.updateGoal(id: currentUserId, weight: targetWeight, distance: targetDistance)
            userStorageUsecase.updateCurrentWeight(id: currentUserId, currentWeight: weight)
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
