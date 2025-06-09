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
    private let pedometerUsecase: PedometerUsecase
    private let interestsUsecase: InterestsUsecase
    private let userStorageUsecase: UserStorageUsecase
    private let weightHistoryUsecase: WeightHistoryUsecase
    private let ingredientUsecase: IngredientUsecase
    
    init() {
        self.alanUsecase = AlanUsecaseImpl(repository: NetworkRepositoryImpl())
        self.pedometerUsecase = PedometerUsecaseImpl(pedometer: PedometerRepositoryImpl())
        
        self.interestsUsecase = InterestsUsecaseImpl(repository: AnotherStorageRepositoryImpl<InterestsDTO>())
        self.userStorageUsecase = UserStorageUsecaseImpl(storage: AnotherStorageRepositoryImpl<UserDTO>())
        self.weightHistoryUsecase = WeightHistoryUsecaseImpl(repository: AnotherStorageRepositoryImpl<WeightDTO>())
        self.ingredientUsecase = IngredientUsecaseImpl(repository: AnotherStorageRepositoryImpl<IngredientDTO>())
        
        //        Task.detached(priority: .background) { [weak self] in
        //            self?.interestsUsecase = InterestsUsecaseImpl(repository: AnotherStorageRepositoryImpl<InterestsDTO>())
        //            self?.userStorageUsecase = UserStorageUsecaseImpl(storage: AnotherStorageRepositoryImpl<UserDTO>())
        //            self?.weightHistoryUsecase = WeightHistoryUsecaseImpl(repository: AnotherStorageRepositoryImpl<WeightDTO>())
        //        }
        
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
            storageUsecase: interestsUsecase
        )
    }
    
    func getDietaryViewModel() -> DietaryViewModel {
        DietaryViewModel(
            alanUsecase: alanUsecase,
            ingredientUsecase: ingredientUsecase
        )
    }
    
    func getOnboardingViewModel() -> OnboardingViewModel {
        OnboardingViewModel(
            weightHistroyUsecase: weightHistoryUsecase,
            userStorageUsecase: userStorageUsecase
        )
    }
}
