//
//  PedometerRepository.swift
//  Dietto
//
//  Created by 안정흠 on 5/19/25.
//

import Foundation
import CoreMotion
import Combine

protocol PedometerRepository {
    var authorizationStatus:  CMAuthorizationStatus { get }
    func startPedometer() -> AnyPublisher<CMPedometerData, Error>
    func stopPedometer()
    func fetchPedometerFromDate(start: Date, end: Date) -> AnyPublisher<CMPedometerData, Error>
}

final class PedometerRepositoryImpl: PedometerRepository {
    private let pedometer: CMPedometer
    private var querySubject = PassthroughSubject<CMPedometerData, Error>()
    private var liveSubject = PassthroughSubject<CMPedometerData, Error>()
    var authorizationStatus: CMAuthorizationStatus { CMPedometer.authorizationStatus() }
    
    init(pedometer: CMPedometer = CMPedometer()) {
        self.pedometer = pedometer   
    }
    
    func startPedometer() -> AnyPublisher<CMPedometerData, any Error> {
        pedometer.startUpdates(from: Calendar.current.startOfDay(for: Date())) { [weak self] data, error in
            if let data { self?.liveSubject.send(data) }
            else if let error { self?.liveSubject.send(completion: .failure(error)) }
        }
        return liveSubject.eraseToAnyPublisher()
    }
    
    func stopPedometer() {
        pedometer.stopUpdates()
    }
    
    func fetchPedometerFromDate(start: Date, end: Date) -> AnyPublisher<CMPedometerData, any Error> {
        pedometer.queryPedometerData(from: start, to: end) { [weak self] data, error in
            if let data { self?.querySubject.send(data) }
            else if let error { self?.querySubject.send(completion: .failure(error)) }
        }
        return querySubject.eraseToAnyPublisher()
    }
}
