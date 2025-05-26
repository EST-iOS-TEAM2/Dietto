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
    var id: UUID
    var name: String
    var gender: String
    var height: Int
    var startWeight: Int
    var currentWeight: Int
    var targetWeight: Int
    var targetDistance: Int
    
    init(id: UUID, name: String, gender: String, height: Int, startWeight: Int, currentWeight: Int, targetWeight: Int, targetDistance: Int) {
        self.id = id
        self.name = name
        self.gender = gender
        self.height = height
        self.startWeight = startWeight
        self.currentWeight = currentWeight
        self.targetWeight = targetWeight
        self.targetDistance = targetDistance
    }
}
