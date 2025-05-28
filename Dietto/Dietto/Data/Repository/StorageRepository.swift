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
    func updateData(predicate: Predicate<T>, updateBlock: @escaping (T) -> Void) throws
    func fetchData(where predicate: Predicate<T>?,sort: [SortDescriptor<T>]) throws -> [T]
    func deleteData(where predicate: Predicate<T>) throws
    func deleteAll() throws
}

final class StorageRepositoryImpl<T: PersistentModel>: StorageRepository {
    
    private let context: ModelContext
    
    init(modelContainer: ModelContainer) {
        self.context = ModelContext(modelContainer)
    }
    
    /*
     합쳐서 전역으로 앱단에서 주입할지
     https://www.hackingwithswift.com/quick-start/swiftdata/how-to-add-multiple-configurations-to-a-modelcontainer
     아니면 아래와 같이 따로따로 컨테이너를 사용할때 생성되게 할지..
     */
    init() {
        let configure = ModelConfiguration("\(T.self)") // 이름 지정 
        do {
            let modelContainer = try ModelContainer(for: T.self, configurations: configure)
            self.context = ModelContext(modelContainer)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func insertData(data: T) {
        
        Task {
            context.insert(data)
            do {
                try context.save()
            }
            catch {
                print("Data Save ERROR: \(error.localizedDescription)")
            }
        }
    }
    
    func updateData(predicate: Predicate<T>, updateBlock: @escaping (T) -> Void) throws {
        let descriptor = FetchDescriptor<T>(predicate: predicate)
        if let result = try context.fetch(descriptor).first {
            updateBlock(result)
            try context.save()
        }
    }
    
    func fetchData(where predicate: Predicate<T>? = nil, sort: [SortDescriptor<T>] = [] ) throws -> [T] {
        // MARK:
        let descriptor = FetchDescriptor(predicate: predicate, sortBy: sort)
        let data = try context.fetch(descriptor)
        return data
    }
    
    func deleteData(where predicate: Predicate<T>) throws {
        try context.delete(model: T.self, where: predicate)
        try context.save()
    }
    
    func deleteAll() throws {
        let data = try fetchData()
        for item in data {
            context.delete(item)
        }
        try context.save()
    }
}
