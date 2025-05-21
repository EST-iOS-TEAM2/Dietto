//
//  DTO.swift
//  Dietto
//
//  Created by 안세훈 on 5/14/25.
//

import Foundation

//Encodable : Swift객체 -> Json
//Decodable : Json -> Swift객체
//Codable : Encodable + Decodable

//MARK: - Request

struct AlanRequest : Encodable {
    let client_id : String
    let content : String
}

//MARK: - Response

struct AlanResponse: Decodable {
    let content: String
}

