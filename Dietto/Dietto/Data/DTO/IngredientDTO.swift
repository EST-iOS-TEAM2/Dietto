//
//  IngredientDTO.swift
//  Dietto
//
//  Created by 안정흠 on 6/9/25.
//


import Foundation
import SwiftData

@Model
final class IngredientDTO {
    var id: UUID
    var ingredient: String
    
    init(id: UUID, ingredient: String) {
        self.id = id
        self.ingredient = ingredient
    }
}