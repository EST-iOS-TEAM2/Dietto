//
//  NetworkError.swift
//  Dietto
//
//  Created by 안세훈 on 5/19/25.
//

import Foundation

public enum NetworkError: LocalizedError {
    case badRequest           // 400
    case unauthorized         // 401
    case forbidden            // 403
    case notFound             // 404
    case serverError(Int)     // 500+
    case invalidResponse
    case decodingFailed(Error)
    case requestCancelled
    case unknown(Error)
    case unacceptableStatusCode
    
    public var errorDescription: String? {
        switch self {
        case .badRequest:
            return "요청이 잘못되었습니다."
        case .unauthorized:
            return "인증에 실패했습니다."
        case .forbidden:
            return "접근이 거부되었습니다."
        case .notFound:
            return "요청한 자원을 찾을 수 없습니다."
        case .serverError(let code):
            return "서버 오류가 발생했습니다. (\(code))"
        case .invalidResponse:
            return "서버 응답이 유효하지 않습니다."
        case .decodingFailed(let error):
            return "잠시 후 다시 시도해주세요."
        case .requestCancelled:
            return "요청이 취소되었습니다."
        case .unknown(let error):
            return "알 수 없는 에러가 발생했습니다. 관리자에게 문의하세요."
        case .unacceptableStatusCode:
            return "에러가 발생했습니다. 잠시후 다시 시도하세요."
        }
    }
}
