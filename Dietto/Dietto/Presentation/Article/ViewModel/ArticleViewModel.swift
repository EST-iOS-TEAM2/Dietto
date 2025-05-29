//
//  ArticleViewModel.swift
//  Dietto
//
//  Created by 안세훈 on 5/26/25.
//

import SwiftUI

final class ArticleViewModel: ObservableObject {
    @Published var selectedInterests: [InterestEntity] = []
    @Published var articles: [ArticleEntity] = []
    
    private let alanUsecase: AlanUsecase
    private let storageUsecase: InterestsUsecase
    let interestData: [(topic: String, titles: [String])] = [
        ("운동", ["근육량 증가", "규칙적인 운동", "체지방률 감소"]),
        ("식습관 개선", ["음식 섭취 패턴 안정화", "안정된 영양소 섭취", "수분 섭취", "외식 줄이기", "저염식"]),
        ("건강 관리", ["금연 / 금주", "혈당 안정화", "음식 일기", "피부 개선"]),
        ("수면 및 스트레스", ["수면 개선", "스트레스"])
    ]
    
    init(
        alanUsecase: AlanUsecase = AlanUsecaseImpl(repository: NetworkRepositoryImpl()),
        storageUsecase: InterestsUsecase = InterestsUsecaseImpl(repository: StorageRepositoryImpl<InterestsDTO>())
    ) {
        self.alanUsecase = alanUsecase
        self.storageUsecase = storageUsecase
        selectedInterests = storageUsecase.fetchInterests()
    }
    
    // MARK: - 아티클 로드
    func loadArticles() {
        Task {
            do {
                let result = try await alanUsecase.fetchArticle(topics: selectedInterests)
                await MainActor.run{ articles = result }
            }
            catch {
                
            }
        }
        
    }
    
    // MARK: - 관심사 추가 / 삭제
    func addInterest(_ title: String) {
        let entity = InterestEntity(title: title)
        guard !selectedInterests.contains(where: { $0.title == title }) else { return }
        selectedInterests.append(entity)
    }
    
    func removeInterest(_ title: String) {
        if let index = selectedInterests.firstIndex(where: { $0.title == title }) {
            selectedInterests.remove(at: index)
        }
    }
    
    func toggleInterest(_ title: String) {
        if selectedInterests.contains(where: { $0.title == title }) {
            removeInterest(title)
            storageUsecase.deleteInterests(InterestEntity(title: title))
        } else {
            addInterest(title)
            storageUsecase.insertInterests(InterestEntity(title: title))
        }
        print(selectedInterests)
    }
}
