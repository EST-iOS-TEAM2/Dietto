//
//  WeightDTO.swift
//  Dietto
//
//  Created by 안정흠 on 5/21/25.
//

import Foundation
import SwiftData

@Model
final class WeightDTO {
    var date: Date
    var scale: Int
    
    init(date: Date, scale: Int) {
        self.date = date
        self.scale = scale
    }
    
    func convertEntity() -> WeightEntity {
        return WeightEntity(date: date, scale: scale)
    }
}
