import SwiftUI
import Foundation

@main
struct ARUKUdevApp: App {
    @StateObject private var calendarViewModel = CalendarViewModel()
    
    var body: some Scene {
        WindowGroup {
            TabView {
                CalendarView()
                    .environmentObject(calendarViewModel)
                    .tabItem {
                        Image(systemName: "calendar")
                        Text("カレンダー")
                    }
            }
        }
    }
}

// カレンダービューのプレビュー用
#Preview {
    CalendarView()
        .environmentObject(CalendarViewModel())
}
