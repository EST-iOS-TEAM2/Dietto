//
//  RecommendEntity.swift
//  Dietto
//
//  Created by 안세훈 on 5/19/25.
//

import Foundation

struct RecommendEntity : Identifiable, Hashable, Decodable {
    var id = UUID()
    let title : String
    let description : String
}
