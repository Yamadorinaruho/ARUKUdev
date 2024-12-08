// Views/Calendar/CalendarView.swift
import SwiftUI

struct CalendarView: View {
    @EnvironmentObject var dayRecordViewModel: DayRecordViewModel
    @StateObject private var viewModel: CalendarViewModel
    
    init() {
        _viewModel = StateObject(wrappedValue: CalendarViewModel())
    }
    
    
    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                CalendarGridView(viewModel: viewModel)
                
                DayDetailsView(selectedDate: viewModel.selectedDate)
                    .padding(.horizontal, 16)
                
                Spacer()
                
            }
            .padding(.top, 16)
            .navigationBarHidden(true)
            .background(Color(UIColor.systemGray6))
        }
    }
}
#Preview {
    CalendarView()
        .environmentObject(DayRecordViewModel())
}
