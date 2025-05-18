//
//  APIClientDelegate.swift
//  Dietto
//
//  Created by 안세훈 on 5/19/25.
//

import Foundation

public protocol APIClientDelegate : Sendable{

    // urlrequest가 전송 직전
    // 토큰 검사용
    func client(_client : APIClient, willsendRequest request : inout URLRequest) async throws
    
    // urlrequest호출 후 상태 코드가 200..<300을 벗어날때
    // 에러 mapping용
    func client(_client : APIClient, validateResponse response : HTTPURLResponse, data : Data, task : URLSessionTask) throws
    
    // 네트워크 요청 실패 직후
    // 재시도 여부 결정
    func client(_ client: APIClient, shouldRetry task: URLSessionTask, error: Error, attempts: Int) async throws -> Bool
    
    //baseURL + path로 URL생성 직전
    func client<T>(_ client: APIClient, makeURLForRequest request: Request<T>) throws -> URL?
    
    // 바디를 JSONEncoder로 인코딩 직전
    func client<T>(_ client: APIClient, encoderForRequest request: Request<T>) -> JSONEncoder?
    
    //응답 데이터를 디코딩하기 직전
    func client<T>(_ client: APIClient, decoderForRequest request: Request<T>) -> JSONDecoder?


}

