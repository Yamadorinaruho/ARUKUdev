import Foundation

struct DayRecord: Identifiable, Codable {
    let id: UUID
    var date: Date
    var mood: Int? // Int から Int? に変更
    var sleepHours: Double
    var activities: Set<String>
    var createdAt: Date
    var updatedAt: Date
    
    init(date: Date, mood: Int? = nil, sleepHours: Double = 8.0, activities: Set<String> = []) {
        self.id = UUID()
        self.date = date
        self.mood = mood // デフォルト値は nil
        self.sleepHours = sleepHours  // デフォルト値は8.0時間
        self.activities = activities  // デフォルト値は空の配列
        self.createdAt = Date()
        self.updatedAt = Date()
    }
}
