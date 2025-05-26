//
//  ArticleEntity.swift
//  Dietto
//
//  Created by 안세훈 on 5/23/25.
//

import Foundation

//MARK: - 아티클은 저장합니다.
struct ArticleEntity: Identifiable, Hashable, Decodable{
    var id = UUID()
    let title: String
}
