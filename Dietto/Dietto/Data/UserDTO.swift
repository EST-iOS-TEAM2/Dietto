//
//  UserDTO.swift
//  Dietto
//
//  Created by 안정흠 on 5/20/25.
//

import Foundation
import SwiftData

@Model
final class UserDTO {
    var name: String
    var birth: Date
    var gender: String
    var height: Int
    var weight: Int
    var targetWeight: Int
    var targetDistance: Int
    var favorite: [FavoriteItem]
    
    init(name: String, birth: Date, gender: String, height: Int, weight: Int, targetWeight: Int, targetDistance: Int, favorite: [FavoriteItem]) {
        self.name = name
        self.birth = birth
        self.gender = gender
        self.height = height
        self.weight = weight
        self.targetWeight = targetWeight
        self.targetDistance = targetDistance
        self.favorite = favorite
    }
}

@Model
final class FavoriteItem {
    var name: String
    init(name: String) {
        self.name = name
    }
}
