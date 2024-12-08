// ViewModels/DayRecordViewModel.swift
import Foundation

class DayRecordViewModel: ObservableObject {
    @Published private(set) var records: [DayRecord] = []
    private let userDefaults = UserDefaults.standard
    private let recordsKey = "dayRecords"
    
    init() {
        loadRecords()
    }
    
    private func loadRecords() {
        if let data = userDefaults.data(forKey: recordsKey),
           let decoded = try? JSONDecoder().decode([DayRecord].self, from: data) {
            records = decoded
        }
    }
    
    private func saveRecords() {
        if let encoded = try? JSONEncoder().encode(records) {
            userDefaults.set(encoded, forKey: recordsKey)
        }
    }
    
    func getRecord(for date: Date) -> DayRecord? {
        records.first { Calendar.current.isDate($0.date, inSameDayAs: date) }
    }
    
    func saveRecord(_ record: DayRecord) {
        if let index = records.firstIndex(where: { Calendar.current.isDate($0.date, inSameDayAs: record.date) }) {
            var updatedRecord = record
            updatedRecord.updatedAt = Date()
            records[index] = updatedRecord
        } else {
            records.append(record)
        }
        saveRecords()
    }
    
    func deleteRecord(_ record: DayRecord) {
        if let index = records.firstIndex(where: { $0.id == record.id }) {
            records.remove(at: index)
            saveRecords()
        }
    }
}
