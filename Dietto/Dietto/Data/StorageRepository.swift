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
    func updateData() async throws
    func fetchData() async throws -> [T]
    func deleteData() async throws
}

final class StorageRepositoryImpl<T: PersistentModel>: StorageRepository {
    var modelContainer: ModelContainer

    
    init(modelContainer: ModelContainer) {
        self.modelContainer = modelContainer
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
    
    func updateData() {
        
    }
    
    func fetchData() async throws -> [T] {
        let descriptor = FetchDescriptor<T>(predicate: nil)
        let context = ModelContext(modelContainer)
        let data = try context.fetch(descriptor)
        return data
    }
    
    func deleteData() {
        
    }
    
    
}


//    var modelContainer: ModelContainer = {
//
//        // 1. Schema 생성
//        let schema = Schema([UserDTO.self])
//
//        // 2. Model 관리 규칙을 위한 ModelConfiguration 생성
//        let configuration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
//
//        // 3. ModelContainer 생성
//        do {
//            let container = try ModelContainer(for: schema, configurations: [configuration])
//            return container
//        } catch {
//            fatalError("ModelContainer 생성 실패!!!: \(error)")
//        }
//    }()
