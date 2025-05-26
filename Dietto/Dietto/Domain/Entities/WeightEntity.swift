//
//  WeightEntity.swift
//  Dietto
//
//  Created by 안정흠 on 5/21/25.
//

import Foundation

struct WeightEntity: Hashable {
    var date: Date
    var scale: Int
    // 차트 애니메이션 용
    var isAnimated: Bool = false
}
