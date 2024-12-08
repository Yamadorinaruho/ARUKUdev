import SwiftUI

struct ActivityButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 14))
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .frame(height: 46)
                .frame(maxWidth: .infinity)
                .background(isSelected ? .customYellow : Color(UIColor.systemGray5))
                .foregroundColor(isSelected ? .black : .gray)
                .cornerRadius(15)
        }
    }
}
