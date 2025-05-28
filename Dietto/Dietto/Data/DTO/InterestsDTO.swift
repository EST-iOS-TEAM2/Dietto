//
//  InterestsDTO.swift
//  Dietto
//
//  Created by 안정흠 on 5/28/25.
//

import Foundation
import SwiftData

@Model
final class InterestsDTO {
    var title: String
    
    init(title: String) {
        self.title = title
    }
}
