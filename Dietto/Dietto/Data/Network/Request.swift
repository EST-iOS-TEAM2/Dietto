//
//  Request.swift
//  Dietto
//
//  Created by 안세훈 on 5/18/25.
//

import Foundation

enum HTTPMethod{
    case get
}



public struct Request<Response> {
    var method: HTTPMethod
    var url: URL?
    var query: [String: String]?
    var body: Encodable?
}
