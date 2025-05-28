//
//  OnboardingViewModel.swift
//  Dietto
//
//  Created by 안세훈 on 5/24/25.
//

import SwiftUI

final class OnboardingViewModel: ObservableObject {
    
    
    @Published var name: String = "name"
    @Published var birthString: String = "birthString"
    @Published var gender: String = "남성"
    @Published var weight: Int = 60
    @Published var distance: Int = 60
    @Published var showPhotoSheet: Bool = false
    @Published var showDatePicker: Bool = false
    
    let weights: [Int] = Array(20...100).reversed()
    let distances: [Int] = Array(1...10).reversed()
    
    let interestData: [(topic: String, titles: [String])] = [
        ("운동", ["근육량 증가", "규칙적인 운동", "체지방률 감소"]),
        ("식습관 개선", ["음식 섭취 패턴 안정화", "안정된 영양소 섭취", "수분 섭취", "외식 줄이기", "저염식"]),
        ("건강 관리", ["금연 / 금주", "혈당 안정화", "음식 일기", "피부 개선"]),
        ("수면 및 스트레스", ["수면 개선", "스트레스"])
    ]
    
    @Published private(set) var selectedArticles: [ArticleEntity] = []
    
    //MARK: - 프로필 설정
    func saveProfile() {
        print("프로필이 저장되었습니다.")
        print("이름: \(name), 생일: \(birthString), 성별: \(gender), 몸무게: \(weight), 거리: \(distance)")
    }
    
    func selectGender(_ gender: String) {
        self.gender = gender
    }
    
    
    //MARK: - 목표 설정
    func setGoals(weight: Int, distance: Int) {
        self.weight = weight
        self.distance = distance
    }
    
    // MARK: - 관심사 추가 / 삭제
//    
//    func addInterest(_ title: String) {
//        let entity = ArticleEntity(title: title)
//        guard !selectedArticles.contains(where: { $0.title == title }) else { return }
//        selectedArticles.append(entity)
//    }
//    
//    func removeInterest(_ title: String) {
//        if let index = selectedArticles.firstIndex(where: { $0.title == title }) {
//            selectedArticles.remove(at: index)
//        }
//    }
//    
//    func toggleInterest(_ title: String) {
//        if selectedArticles.contains(where: { $0.title == title }) {
//            removeInterest(title)
//        } else {
//            addInterest(title)
//        }
//        print(selectedArticles)
//    }
}
