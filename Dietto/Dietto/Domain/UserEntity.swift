//
//  User.swift
//  Dietto
//
//  Created by 안정흠 on 5/19/25.
//

import Foundation

struct UserEntity {
    var id: UUID
    var name: String
    var gender: Gender
    var height: Int
    var startWeight: Int
    var currentWeight: Int
    var targetWeight: Int
    var targetDistance: Int
}

enum Gender: String {
    case male = "남성"
    case female = "여성"
}
