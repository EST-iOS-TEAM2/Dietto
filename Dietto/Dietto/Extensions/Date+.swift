//
//  Date+.swift
//  Dietto
//
//  Created by 안정흠 on 5/14/25.
//

import Foundation

extension Date {
    func formattedString() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "M월 d일"
        return formatter.string(from: self)
    }
    
    func isSameDateWithoutTime(date: Date) -> Bool {
        let date1 = Calendar.current.dateComponents([.year, .month, .day], from: self)
        let date2 = Calendar.current.dateComponents([.year, .month, .day], from: date)
        
        return date1.year == date2.year && date1.month == date2.month && date1.day == date2.day
    }
}
