//
//  DIContainer.swift
//  Dietto
//
//  Created by 안정흠 on 5/29/25.
//

import Foundation
import Observation
@Observable
final class DIContainer {
    private let alanUsecase: AlanUsecase
    private var interestsUsecase: InterestsUsecase?
    private let pedometerUsecase: PedometerUsecase
    private let userStorageUsecase: UserStorageUsecase
    private let weightHistoryUsecase: WeightHistoryUsecase
    
    init() {
        self.alanUsecase = AlanUsecaseImpl(repository: NetworkRepositoryImpl())
        self.pedometerUsecase = PedometerUsecaseImpl(pedometer: PedometerRepositoryImpl())
//        self.interestsUsecase = InterestsUsecaseImpl(repository: StorageRepositoryImpl<InterestsDTO>())
        self.userStorageUsecase = UserStorageUsecaseImpl(storage: StorageRepositoryImpl<UserDTO>())
        self.weightHistoryUsecase = WeightHistoryUsecaseImpl(repository: StorageRepositoryImpl<WeightDTO>())
        
        Task.detached(priority: .background) { [weak self] in
            self?.interestsUsecase = InterestsUsecaseImpl(repository: AnotherStorageRepositoryImpl<InterestsDTO>())
        }
    }
    
    func getHomeViewModel() -> HomeViewModel {
        HomeViewModel(
            pedometerUsecase: pedometerUsecase,
            weightHistroyUsecase: weightHistoryUsecase,
            userStorageUsecase: userStorageUsecase
        )
    }
    
    func getArticleViewModel() -> ArticleViewModel {
        ArticleViewModel(
            alanUsecase: alanUsecase,
            storageUsecase: interestsUsecase!
        )
    }
    
    func getDietaryViewModel() -> DietaryViewModel {
        DietaryViewModel(usecase: alanUsecase)
    }
    
    func getOnboardingViewModel() -> OnboardingViewModel {
        OnboardingViewModel(
            weightHistroyUsecase: weightHistoryUsecase,
            userStorageUsecase: userStorageUsecase
        )
    }
}
