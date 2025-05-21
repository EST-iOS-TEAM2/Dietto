//
//  IngredientEntity.swift
//  Dietto
//
//  Created by 안세훈 on 5/19/25.
//

import Foundation

//MARK: - 식재료는 저장합니다.

struct IngredientEntity: Identifiable, Hashable {
    let id = UUID()
    let name: String
}
