import Foundation

protocol DataServiceProtocol {
    func fetchRecords() -> [DayRecord]
    func save(_ record: DayRecord)
    func update(_ record: DayRecord)
    func delete(_ record: DayRecord)
}

class DataService: DataServiceProtocol {
    static let shared = DataService()
    private let defaults = UserDefaults.standard
    private let recordsKey = "dayRecords"
    
    private init() {}
    
    func fetchRecords() -> [DayRecord] {
        guard let data = defaults.data(forKey: recordsKey),
              let records = try? JSONDecoder().decode([DayRecord].self, from: data) else {
            return []
        }
        return records
    }
    
    func save(_ record: DayRecord) {
        var records = fetchRecords()
        records.append(record)
        saveRecords(records)
    }
    
    func update(_ record: DayRecord) {
        var records = fetchRecords()
        if let index = records.firstIndex(where: { $0.id == record.id }) {
            records[index] = record
            saveRecords(records)
        }
    }
    
    func delete(_ record: DayRecord) {
        var records = fetchRecords()
        records.removeAll(where: { $0.id == record.id })
        saveRecords(records)
    }
    
    private func saveRecords(_ records: [DayRecord]) {
        if let encoded = try? JSONEncoder().encode(records) {
            defaults.set(encoded, forKey: recordsKey)
        }
    }
}
