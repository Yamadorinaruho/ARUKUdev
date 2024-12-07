import SwiftUI

struct DayCell: View {
    let day: Int
    let isSelected: Bool
    let isHighlighted: Bool
    
    var body: some View {
        Text("\(day)")
            .frame(width: 35, height: 35)
            .background(isSelected ? Color.yellow : Color.clear)
            .foregroundColor(isHighlighted ? .orange : .primary)
            .clipShape(Circle())
    }
}
