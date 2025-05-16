//
//  RecommendViewModel.swift
//  Dietto
//
//  Created by 안세훈 on 5/16/25.
//

import SwiftUI

//MARK: - 임시 모델

struct recommendModel : Identifiable, Hashable {
    let id = UUID()
    let title : String
}

class RecommendViewModel : ObservableObject {
    
    @Published var recommendList : [recommendModel]  = [
        recommendModel(title: "음식1"),
        recommendModel(title: "음식2"),
        recommendModel(title: "음식3"),
        recommendModel(title: "음식4"),
        recommendModel(title: "음식5"),
        recommendModel(title: "음식6"),
        recommendModel(title: "음식7"),
        recommendModel(title: "음식8"),
        recommendModel(title: "음식9"),
        recommendModel(title: "음식10")
    ]
    
    
}
