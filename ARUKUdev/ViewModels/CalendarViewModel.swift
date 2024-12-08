import Foundation
import Combine

class CalendarViewModel: ObservableObject {
    @Published var currentMonth: Date
    @Published var selectedDate: Date
    private let calendar = Calendar.current
    
    init() {
        self.currentMonth = Date()
        self.selectedDate = Date()
    }
    
    func previousMonth() {
        if let newDate = calendar.date(byAdding: .month, value: -1, to: currentMonth) {
            currentMonth = newDate
        }
    }
    
    func nextMonth() {
        if let newDate = calendar.date(byAdding: .month, value: 1, to: currentMonth) {
            currentMonth = newDate
        }
    }
    
    func formatYearMonth() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年M月"
        return formatter.string(from: currentMonth)
    }
    
    func daysInMonth() -> [(day: Int, date: Date)] {
        var days: [(day: Int, date: Date)] = []
        
        guard let range = calendar.range(of: .day, in: .month, for: currentMonth),
              let firstDayOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: currentMonth)) else {
            return days
        }
        
        let firstWeekday = calendar.component(.weekday, from: firstDayOfMonth)
        
        // 月初めの空白を追加
        for _ in 1..<firstWeekday {
            days.append((0, Date()))
        }
        
        // 月の日付を追加
        for day in range {
            if let date = calendar.date(byAdding: .day, value: day - 1, to: firstDayOfMonth) {
                days.append((day, date))
            }
        }
        
        return days
    }
}
