// Views/Calendar/CalendarView.swift
import SwiftUI

struct CalendarView: View {
    @StateObject private var viewModel = CalendarViewModel()
    @State private var sleepHours: Double = 8.0
    
    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                CalendarHeaderView(dateString: viewModel.formatYearMonth())
                    .padding(.top, 8)
                
                CalendarGridView(viewModel: viewModel)
                
                DayDetailsView(selectedDate: viewModel.selectedDate, sleepHours: sleepHours)
                    .padding(.horizontal, 16)
                
                Spacer()
                
                CustomTabBar()
            }
            .navigationBarHidden(true)
            .background(Color(UIColor.systemGray6))
        }
    }
}
#Preview {
    CalendarView()
}
