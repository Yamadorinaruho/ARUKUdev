import SwiftUI

struct ContentView: View {
    @State private var selectedTab: Int? = 0
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    var body: some View {
        TabView(selection: $selectedTab) {
            CalendarView()
                .tabItem {
                    Label("カレンダー", systemImage: "calendar")
                }
                .tag(0)
            
            SettingsView()
                .tabItem {
                    Label("設定", systemImage: "person.circle")
                }
                .tag(1)
        }
        .frame(maxWidth: 450) // iPhoneに近い最大幅を設定
        .environment(\.horizontalSizeClass, .compact) // 明示的にcompactを強制
        .ignoresSafeArea(.keyboard)
    }
}

#Preview("iPhone SE") {
    ContentView()
}

#Preview("iPad Air") {
    ContentView()
}

#Preview("Mac") {
    ContentView()
}
