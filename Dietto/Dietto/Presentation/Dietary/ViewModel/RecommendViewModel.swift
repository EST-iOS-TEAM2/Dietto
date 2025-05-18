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
    let description : String
}

class RecommendViewModel : ObservableObject {
    
    @Published var recommendList : [recommendModel]  = [
        recommendModel(title: "음식1", description: "대충만듭니다.하지만 대충 만든다고 맛이 없지는 않습니다. 요리하는 사람의 정성이 들어가야하며 손맛도 중요합니다. 하지만 손맛이 중요하다고 손을 넣는 것은 아닙니다. 왜냐하면 손을 넣기 위해서는 왼손, 오른손 중 하나를 택해야 하기 때문입니다. 왼손잡이일 경우 왼손을 넣는 다면, 사는데 불편할 것이 분명합니다. 그럼 오른손을 넣겠지요? 그럼 인도 여행을 가지 못합니다. 인도는 오른손으로 밥을 먹기 때문입니다."),
        recommendModel(title: "음식2", description: "대충만듭니다."),
        recommendModel(title: "음식3", description: "대충만듭니다."),
        recommendModel(title: "음식4", description: "대충만듭니다."),
        recommendModel(title: "음식5", description: "대충만듭니다."),
        recommendModel(title: "음식6", description: "대충만듭니다."),
        recommendModel(title: "음식7", description: "대충만듭니다."),
        recommendModel(title: "음식8", description: "대충만듭니다."),
        recommendModel(title: "음식9", description: "대충만듭니다."),
        recommendModel(title: "음식10", description: "대충만듭니다.")
    ]
    
    
}
