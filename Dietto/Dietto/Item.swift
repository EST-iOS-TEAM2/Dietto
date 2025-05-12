//
//  Item.swift
//  Dietto
//
//  Created by 안정흠 on 5/12/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
