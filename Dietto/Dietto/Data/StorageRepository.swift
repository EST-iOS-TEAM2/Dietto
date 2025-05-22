//
//  StorageRepository.swift
//  Dietto
//
//  Created by 안정흠 on 5/20/25.
//

import Foundation
import SwiftData

protocol StorageRepository {
    associatedtype T: PersistentModel
    
    func insertData(data: T)
    func updateData(predicate: Predicate<T>, updateBlock: @escaping (T) -> Void) async throws
    func fetchData(where predicate: Predicate<T>?,sort: [SortDescriptor<T>] ) async throws -> [T]
    func deleteData(where predicate: Predicate<T>) async throws
}

final class StorageRepositoryImpl<T: PersistentModel>: StorageRepository {
    
    private let modelContainer: ModelContainer

    
    init(modelContainer: ModelContainer) {
        self.modelContainer = modelContainer
    }
    
    /*
     합쳐서 전역으로 앱단에서 주입할지
     https://www.hackingwithswift.com/quick-start/swiftdata/how-to-add-multiple-configurations-to-a-modelcontainer
     아니면 아래와 같이 따로따로 컨테이너를 사용할때 생성되게 할지..
     */
    init() {
        let configure = ModelConfiguration("\(T.self)") // 이름 지정 
        do {
            self.modelContainer = try ModelContainer(for: T.self, configurations: configure)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func insertData(data: T) {
        Task {
            let modelContext = ModelContext(modelContainer)
            modelContext.insert(data)
            do {
                try modelContext.save()
            }
            catch {
                print("Data Save ERROR: \(error.localizedDescription)")
            }
        }
    }
    
    func updateData(predicate: Predicate<T>, updateBlock: @escaping (T) -> Void) async throws {
        let context = ModelContext(modelContainer)
        let descriptor = FetchDescriptor<T>(predicate: predicate)
        if let result = try context.fetch(descriptor).first {
            updateBlock(result)
            try context.save()
        }
    }
    
    @MainActor
    func fetchData(where predicate: Predicate<T>? = nil, sort: [SortDescriptor<T>] = [] ) async throws -> [T] {
        let descriptor = FetchDescriptor(predicate: predicate, sortBy: sort)
        let context = ModelContext(modelContainer)
        let data = try context.fetch(descriptor)
        return data
    }
    
    func deleteData(where predicate: Predicate<T>) async throws {
        let context = ModelContext(modelContainer)
        try context.delete(model: T.self, where: predicate)
        try context.save()
    }
}
