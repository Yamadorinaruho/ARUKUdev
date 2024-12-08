import SwiftUI

struct CalendarGridView: View {
    @ObservedObject var viewModel: CalendarViewModel
    @Environment(\.colorScheme) private var colorScheme
    private let columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: 8), count: 7)
    private let weekDays = ["日", "月", "火", "水", "木", "金", "土"]
    
    var body: some View {
        VStack(spacing: 8) {
            // 月選択部分
            HStack {
                Button(action: { viewModel.previousMonth() }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.primary)
                }
                
                Text(viewModel.formatYearMonth())
                    .font(.headline)
                    .frame(minWidth: 100)
                    .accessibilityLabel("\(viewModel.currentMonth.formatted(.dateTime.year().month()))")
                
                Button(action: { viewModel.nextMonth() }) {
                    Image(systemName: "chevron.right")
                        .foregroundColor(.primary)
                }
            }
            .padding(.bottom, 12)
            
            // 曜日ヘッダー
            LazyVGrid(columns: columns) {
                ForEach(weekDays, id: \.self) { day in
                    Text(day)
                        .font(.system(size: 16))
                        .frame(height: 30)
                        .foregroundColor(day == "日" ? .red : (day == "土" ? .blue : .primary))
                        .accessibilityLabel("\(day)曜日")
                }
            }
            
            // カレンダー日付
            LazyVGrid(columns: columns, spacing: 8) {
                ForEach(viewModel.daysInMonth(), id: \.date) { day in
                    if day.day == 0 {
                        Color.clear
                            .frame(width: 35, height: 35)
                    } else {
                        DayCell(
                            day: day.day,
                            isSelected: Calendar.current.isDate(day.date, inSameDayAs: viewModel.selectedDate),
                            isHighlighted: Calendar.current.isDateInToday(day.date)
                        )
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                viewModel.selectedDate = day.date
                            }
                        }
                        .accessibilityLabel("\(day.day)日")
                        .accessibilityHint("タップして選択")
                    }
                }
            }
        }
        .padding(.horizontal)
    }
}
