//
//  ArticleViewModel.swift
//  Dietto
//
//  Created by 안세훈 on 5/26/25.
//

import SwiftUI

final class ArticleViewModel: ObservableObject {
    @Published var toastMessage: ToastEntity?
    @Published var selectedInterests: [InterestEntity] = []
    @Published var articles: [String] = []
    @Published var isLoading : Bool = true
    
    private let alanUsecase: AlanUsecase
    private let storageUsecase: InterestsUsecase
    let interestData: [(topic: String, titles: [String])] = [
        ("운동", ["근육량 증가", "규칙적인 운동", "체지방률 감소"]),
        ("식습관 개선", ["음식 섭취 패턴 안정화", "안정된 영양소 섭취", "수분 섭취", "외식 줄이기", "저염식"]),
        ("건강 관리", ["금연 / 금주", "혈당 안정화", "음식 일기", "피부 개선"]),
        ("수면 및 스트레스", ["수면 개선", "스트레스"])
    ]
    
    init(
        alanUsecase: AlanUsecase,
        storageUsecase: InterestsUsecase
    ) {
        self.alanUsecase = alanUsecase
        self.storageUsecase = storageUsecase
        
        Task {
            do {
                let result = try await storageUsecase.fetchInterests()
                await MainActor.run {
                    self.selectedInterests = result
                    loadArticles()
                }
            }
            catch {
                await callToastMessage(type: .error, title: "관심사 로드 실패", message: error.localizedDescription)
            }
        }
    }
    
    // MARK: - 아티클 로드
    func loadArticles() {
        isLoading = true
        Task {
            do {
//                let result = try await alanUsecase.fetchArticle(topics: selectedInterests)
//                await MainActor.run{ articles = result }
                // MARK: 임시 로직
                try await Task.sleep(for: .seconds(5))
                await MainActor.run { [weak self] in
                    self?.articles = Array((self?.dummyData.shuffled().prefix(5))!)
                    self?.isLoading = false
                    self?.toastMessage = ToastEntity(type: .success, title: "아티클 업데이트 완료", message: "")
                }
            }
            catch {
                await callToastMessage(type: .error, title: "아티클 로드 실패", message: error.localizedDescription)
            }
        }
        
    }
    
    // MARK: - 관심사 추가 / 삭제
    private func addInterest(_ title: String) {
        let entity = InterestEntity(title: title)
        guard !selectedInterests.contains(where: { $0.title == title }) else { return }
        selectedInterests.append(entity)
    }
    
    private func removeInterest(_ title: String) {
        if let index = selectedInterests.firstIndex(where: { $0.title == title }) {
            selectedInterests.remove(at: index)
        }
    }
    
    func toggleInterest(_ title: String) {
        if selectedInterests.contains(where: { $0.title == title }) {
            removeInterest(title)
            Task {
                do {
                    try await storageUsecase.deleteInterests(InterestEntity(title: title))
                }
                catch {
                    await callToastMessage(type: .error, title: "관심사 삭제 실패", message: error.localizedDescription)
                }
            }
        } else {
            addInterest(title)
            Task {
                do {
                    try await storageUsecase.insertInterests(InterestEntity(title: title))
                }
                catch {
                    await callToastMessage(type: .error, title: "관심사 추가 실패", message: error.localizedDescription)
                }
            }
            
        }
    }
    
    private func callToastMessage(type: ToastStyle, title: String, message: String) async {
        await MainActor.run { [weak self] in
            self?.toastMessage = ToastEntity(type: type, title: title, message: message)
        }
    }
    
    let dummyData = [
        "https://www.youtube.com/watch?v=jSuxMiRxnZg",
        "https://www.youtube.com/watch?v=2lDheJzSYeo",
        "https://www.youtube.com/watch?v=TEHS9dzSTZY",
        "https://www.youtube.com/watch?v=MjMkBaqimFo",
        "https://www.youtube.com/watch?v=Obu25eMlr4A",
        "https://www.youtube.com/watch?v=KFbeFLLJbWo",
        "https://www.youtube.com/watch?v=BHY0FxzoKZE",
        "https://www.youtube.com/watch?v=8so1WZ4j1oQ",
        "https://www.youtube.com/watch?v=zlaZGuXvL04",
        "https://www.youtube.com/watch?v=1D9ASR6gSc0",
        "https://www.youtube.com/watch?v=Cg_GW7yhq20",
        "https://www.youtube.com/watch?v=QWF9mGtjju4",
        "https://www.youtube.com/watch?v=YMnIhyWjrb4",
        "https://www.youtube.com/watch?v=FoRku07ShZM",
        "https://www.youtube.com/watch?v=YNsuneGBsMY",
        "https://www.youtube.com/watch?v=3DZqX_2YLiw",
        "https://www.youtube.com/watch?v=CSjRBBqfhko",
        "https://www.youtube.com/watch?v=wWGulLAa0O0",
        "https://www.youtube.com/watch?v=4WV7kAUGrgI",
        "https://www.youtube.com/watch?v=8so1WZ4j1oQ"
      ]
}
