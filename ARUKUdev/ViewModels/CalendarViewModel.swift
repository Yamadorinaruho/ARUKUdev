import Foundation
import SwiftUI

class CalendarViewModel: ObservableObject {
    @Published var currentDate = Date()
    @Published var selectedDate = Date()
    
    func daysInMonth() -> [(day: Int, date: Date)] {
        let calendar = Calendar.current
        let currentMonth = calendar.component(.month, from: currentDate)
        let currentYear = calendar.component(.year, from: currentDate)
        
        // 月の初日を取得
        guard let startDate = calendar.date(from: DateComponents(year: currentYear, month: currentMonth, day: 1)) else {
            return []
        }
        
        // 月の日数を取得
        let range = calendar.range(of: .day, in: .month, for: currentDate)!
        
        var days: [(day: Int, date: Date)] = []
        
        // 初日の曜日のオフセットを追加
        let weekday = calendar.component(.weekday, from: startDate)
        let offset = weekday - 1 // 日曜日から開始
        
        // オフセット用の空の日付を追加
        for _ in 0..<offset {
            days.append((day: 0, date: Date()))
        }
        
        // 実際の日付を追加
        for day in 1...range.count {
            if let date = calendar.date(from: DateComponents(year: currentYear, month: currentMonth, day: day)) {
                days.append((day: day, date: date))
            }
        }
        
        return days
    }
    
    func formatYearMonth() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年MM月"
        formatter.locale = Locale(identifier: "ja_JP")
        return formatter.string(from: currentDate)
    }
}
