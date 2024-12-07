import SwiftUI

struct CustomTabBar: View {
    @Environment(\.colorScheme) private var colorScheme
    @State private var selectedTab = 0
    
    var body: some View {
        HStack {
            Spacer()
            TabBarButton(
                image: "calendar",
                isSelected: selectedTab == 0,
                action: { selectedTab = 0 }
            )
            Spacer()
            TabBarButton(
                image: "person.circle",
                isSelected: selectedTab == 1,
                action: { selectedTab = 1 }
            )
            Spacer()
        }
        .padding(.vertical, 8)
        .background(colorScheme == .dark ? Color(UIColor.systemGray6) : .white)
        .overlay(
            Rectangle()
                .frame(height: 0.5)
                .foregroundColor(Color.black.opacity(0.1)),
            alignment: .top
        )
    }
}

struct TabBarButton: View {
    let image: String
    let isSelected: Bool
    let action: () -> Void
    @State private var isPressed = false
    
    var body: some View {
        Image(systemName: image)
            .foregroundColor(isSelected ? .yellow : .gray)
            .font(.system(size: 24))
            .scaleEffect(isPressed ? 0.9 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: isPressed)
            .onTapGesture {
                withAnimation {
                    isPressed = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        isPressed = false
                        action()
                    }
                }
            }
            .accessibilityAddTraits(isSelected ? [.isButton, .isSelected] : [.isButton])
    }
}
