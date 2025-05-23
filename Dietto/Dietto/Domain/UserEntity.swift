//
//  User.swift
//  Dietto
//
//  Created by 안정흠 on 5/19/25.
//

import Foundation

struct UserEntity {
    var name: String
    var birth: Date
    var gender: Gender
    var height: Int
    var weight: Int
    var targetWeight: Int
    var targetDistance: Int
    var favorite: [String]
}

enum Gender: String {
    case male = "남성"
    case female = "여성"
}
