//
//  DTO.swift
//  Dietto
//
//  Created by 안세훈 on 5/14/25.
//

import Foundation

//MARK: - Request

struct AlanRequest : Decodable {
    let client_id : String
    let content : String
}

//MARK: - Response

struct AlanResponse: Codable {
    let content: String
}

