//
//  APIClient.swift
//  Dietto
//
//  Created by 안세훈 on 5/18/25.
//

import Foundation

public actor APIClient { //data race를 피하기 위해 참조 타입 actor를 사용. 클래스와 비슷하지만, 상속이 안됨
    public nonisolated let configuration: Configuration
    public nonisolated let session: URLSession
    
    private let decoder: JSONDecoder
    private let encoder: JSONEncoder
    private let delegate: APIClientDelegate
    private let dataLoader = DataLoader()
    
    public struct Configuration: @unchecked Sendable {
        public var baseURL: URL?
        public var delegate: APIClientDelegate?
        public var sessionConfiguration: URLSessionConfiguration = .default
        public var sessionDelegate: URLSessionDelegate?
        public var sessionDelegateQueue: OperationQueue?
        public var decoder: JSONDecoder
        public var encoder: JSONEncoder
        
        public init(
            baseURL: URL?,
            sessionConfiguration: URLSessionConfiguration = .default,
            delegate: APIClientDelegate? = nil
        ) {
            self.baseURL = baseURL
            self.sessionConfiguration = sessionConfiguration
            self.delegate = delegate
            self.decoder = JSONDecoder()
            self.decoder.dateDecodingStrategy = .iso8601
            self.encoder = JSONEncoder()
            self.encoder.dateEncodingStrategy = .iso8601
        }
    }
    
    // MARK: Initializers
    public init(baseURL: URL?, _ configure: @Sendable (inout APIClient.Configuration) -> Void = { _ in }) {
        var configuration = Configuration(baseURL: baseURL)
        configure(&configuration)
        self.init(configuration: configuration)
    }
}
