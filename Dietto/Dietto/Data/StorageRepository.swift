//
//  StorageRepository.swift
//  Dietto
//
//  Created by 안정흠 on 5/20/25.
//

import Foundation
import SwiftData

protocol StorageRepository {
    func addUserData(data: UserDTO)
    func updateUserData()
    func getUserData() -> UserDTO?
    func deleteUserData()
}

final class StorageRepositoryImpl: StorageRepository {
    //    var modelContainer: ModelContainer
    var modelContext: ModelContext

    
    init(modelContainer: ModelContainer) {
        modelContext = ModelContext(modelContainer)
    }
    
    func addUserData(data: UserDTO) {
        do {
            modelContext.insert(data)
            try modelContext.save()
        }
        catch {
            print("User Data Save ERROR")
        }
    }
    
    func updateUserData() {
        
    }
    
    func getUserData() -> UserDTO? {
        do {
            let user = try modelContext.fetch(FetchDescriptor<UserDTO>())
            return user.first
        } catch {
            print("Learner 데이터를 찾을 수 없습니다.")
            return nil
        }
    }
    
    func deleteUserData() {
        do {
            if let user = getUserData() {
                modelContext.delete(user)
                try modelContext.save()
            }
        }
        catch {
            print("User Data Delete ERROR")
        }
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
