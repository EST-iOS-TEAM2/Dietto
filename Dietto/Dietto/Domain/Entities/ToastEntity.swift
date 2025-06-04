//
//  ToastEntity.swift
//  Dietto
//
//  Created by 안세훈 on 6/4/25.
//

import Foundation

struct ToastEntity: Equatable {
    var type: ToastStyle
    var title: String
    var message: String
    var duration: Double = 3
}
