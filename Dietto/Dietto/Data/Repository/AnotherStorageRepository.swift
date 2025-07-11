//
//  AnotherStorageRepository.swift
//  Dietto
//
//  Created by 안정흠 on 5/31/25.
//


//
//  AnotherStorageRepository.swift
//  Dietto
//
//  Created by 안정흠 on 5/31/25.
//

import Foundation
import SwiftData

enum StorageError: String, Error {
    case insertError
    case updateError
    case fetchError
    case deleteError
}

protocol AnotherStorageRepository {
    associatedtype T: PersistentModel
    
    func insertData(data: T) async throws
    func updateData(predicate: Predicate<T>, updateBlock: @escaping (T) -> Void) async throws
    func fetchData(where predicate: Predicate<T>?, sort: [SortDescriptor<T>]) async throws -> [T]
    func deleteData(where predicate: Predicate<T>) async throws
    func deleteAll() async throws
}
@ModelActor
actor AnotherStorageRepositoryImpl<T: PersistentModel>: AnotherStorageRepository {
    
    init() {
        let configure = ModelConfiguration("\(T.self)") // 이름 지정
        do {
            let modelContainer = try ModelContainer(for: T.self, configurations: configure)
            self.init(modelContainer: modelContainer)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func insertData(data: T) async throws {
        modelContext.insert(data)
        try modelContext.save()
    }
    
    func updateData(predicate: Predicate<T>, updateBlock: @escaping (T) -> Void) async throws {
        let descriptor = FetchDescriptor<T>(predicate: predicate)
        guard let result = try modelContext.fetch(descriptor).first else { throw StorageError.updateError }
        updateBlock(result)
        try modelContext.save()
    }
    
    func fetchData(where predicate: Predicate<T>? = nil, sort: [SortDescriptor<T>] = []) async throws -> [T] {
        let descriptor = FetchDescriptor<T>(predicate: predicate, sortBy: sort)
        return try modelContext.fetch(descriptor)
    }
    
    func deleteData(where predicate: Predicate<T>) async throws {
        try modelContext.delete(model: T.self, where: predicate)
        try modelContext.save()
    }
    
    func deleteAll() async throws {
        let data = try await fetchData()
        for item in data {
            modelContext.delete(item)
        }
        try modelContext.save()
    }
}
