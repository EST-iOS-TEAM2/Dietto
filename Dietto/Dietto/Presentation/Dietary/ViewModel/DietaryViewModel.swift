//
//  DietaryViewModel.swift
//  Dietto
//
//  Created by 안세훈 on 5/14/25.
//

import SwiftUI


//MARK: - 임시 Entity
struct Ingredient: Identifiable, Hashable {
    let id = UUID()
    let name: String
}

class DietaryViewModel: ObservableObject {
    
    @Published var presentIngredients: [Ingredient] = [
        Ingredient(name: "재료1"),
        Ingredient(name: "재료2"),
        Ingredient(name: "재료3"),
        Ingredient(name: "재료4"),
        Ingredient(name: "재료5"),
        Ingredient(name: "재료6"),
        Ingredient(name: "재료7"),
        Ingredient(name: "재료8"),
        Ingredient(name: "재료9"),
        Ingredient(name: "재료10"),
        Ingredient(name: "재료11"),
        Ingredient(name: "재료12"),
        Ingredient(name: "재료13"),
        Ingredient(name: "재료14"),
        Ingredient(name: "재료15"),
        Ingredient(name: "재료16"),
        Ingredient(name: "재료17"),
        Ingredient(name: "재료18"),
        Ingredient(name: "재료19"),
        Ingredient(name: "재료20")
    ]
    
    @Published var pastIngredients : [Ingredient] = [
        Ingredient(name: "재료21"),
        Ingredient(name: "재료22"),
        Ingredient(name: "재료23"),
        Ingredient(name: "재료24"),
        Ingredient(name: "재료25"),
        Ingredient(name: "재료26"),
        Ingredient(name: "재료27"),
        Ingredient(name: "재료28"),
        Ingredient(name: "재료29"),
        Ingredient(name: "재료30"),
        Ingredient(name: "재료31"),
        Ingredient(name: "재료32"),
        Ingredient(name: "재료33"),
        Ingredient(name: "재료34"),
        Ingredient(name: "재료35"),
        Ingredient(name: "재료36"),
        Ingredient(name: "재료37"),
        Ingredient(name: "재료38")
    ]
    
    //MARK: - 지금 식단에 있는거 생성 / 삭제
    func addpresentIngredients(_ ingredient: String) {
        let trimmed = ingredient.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty,
              !presentIngredients.contains(where: { $0.name == trimmed }) else { return }
        
        presentIngredients.append(Ingredient(name: trimmed))
    }
    
    func removepresentIngredients(_ ingredient: Ingredient) {
        presentIngredients.removeAll { $0.id == ingredient.id }
    }
    
    //MARK: - 과거 식단에 있던거 삭제
    func removepastIngredients(_ ingredient: Ingredient) {
        pastIngredients.removeAll { $0.id == ingredient.id }
    }
    
    
}
