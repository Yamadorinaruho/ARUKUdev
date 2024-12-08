import SwiftUI

struct DataEditView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: DayRecordViewModel
    let date: Date
    
    @State private var selectedMood: Int? = nil
    @State private var sleepHours: Double = 8.0
    @State private var selectedActivities: Set<String> = []
    @State private var showingDeleteAlert = false
    
    private let activities = ["早起き", "散歩", "運動", "食事", "熟睡", "掃除"]
    
    init(viewModel: DayRecordViewModel, date: Date) {
        self.viewModel = viewModel
        self.date = date
        
        if let existingRecord = viewModel.getRecord(for: date) {
            _selectedMood = State(initialValue: existingRecord.mood)
            _sleepHours = State(initialValue: existingRecord.sleepHours)
            _selectedActivities = State(initialValue: existingRecord.activities)
        }
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    MoodSelectionView(selectedMood: $selectedMood)
                    
                    SleepTimeView(sleepHours: $sleepHours)
                    
                    ActivitiesSelectionView(
                        activities: activities,
                        selectedActivities: $selectedActivities
                    )
                    
                    if viewModel.getRecord(for: date) != nil {
                        Button(action: { showingDeleteAlert = true }) {
                            Text("削除")
                                .foregroundColor(.red)
                                .font(.system(size: 16, weight: .medium))
                                .frame(width: 120, height: 44)
                                .background(
                                    RoundedRectangle(cornerRadius: 22)
                                        .fill(Color.white)
                                        .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
                                )
                        }
                        .padding(.vertical, 12)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 20)
            }
            .background(Color.customYellow.ignoresSafeArea())
            .navigationBarItems(
                leading: Button("キャンセル") {
                    dismiss()
                }
                    .foregroundColor(.red),
                trailing: Button("保存") {
                    saveRecord()
                }
                    .foregroundColor(.black)
                    .fontWeight(.medium)
            )
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(formattedDate)
                        .font(.system(size: 16, weight: .medium))
                }
            }
            .alert("記録を削除", isPresented: $showingDeleteAlert) {
                Button("キャンセル", role: .cancel) { }
                Button("削除", role: .destructive) {
                    deleteRecord()
                }
            } message: {
                Text("この日の記録を削除してもよろしいですか？")
            }
        }
    }
    
    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY年MM月dd日(E)"
        formatter.locale = Locale(identifier: "ja_JP")
        return formatter.string(from: date)
    }
    
    private func saveRecord() {
        let record = DayRecord(
            date: date,
            mood: selectedMood,
            sleepHours: sleepHours,
            activities: selectedActivities
        )
        viewModel.saveRecord(record)
        dismiss()
    }
    
    private func deleteRecord() {
        if let record = viewModel.getRecord(for: date) {
            viewModel.deleteRecord(record)
        }
        dismiss()
    }
}

#Preview {
    DataEditView(
        viewModel: DayRecordViewModel(),
        date: Date()
    )
}
