//
//  NetworkError.swift
//  Dietto
//
//  Created by 안세훈 on 5/19/25.
//

import Foundation

public enum NetworkError: Error {
    case invalidResponse
    case unacceptableStatusCode(Int)
    case decodingFailed(Error)
    case requestCancelled
    
    public var errorDescription: String? {
        switch self{
        case .invalidResponse: return "Invalid Response"
        case .unacceptableStatusCode(let code): return "\(code)"
        case .decodingFailed(let error): return ""
        case .requestCancelled: return ""
        }
    }
}
