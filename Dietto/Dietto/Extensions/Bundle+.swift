//
//  Bundle+.swift
//  Dietto
//
//  Created by 안정흠 on 5/13/25.
//

import Foundation

extension Bundle {
    static var AlanKey: String {
        guard let url = Bundle.main.url(forResource: "keyContainer", withExtension: "plist"),
              let data = try? Data(contentsOf: url),
              let plist = try? PropertyListSerialization.propertyList(from: data, format: nil) as? [String: Any],
              let clientID = plist["AlanClientKey"] as? String else {
            fatalError("AlanClientKey not found in API_KEY.plist")
        }
        return clientID
    }
}

