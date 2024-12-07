import SwiftUI

struct ProgressBar: View {
    let value: Double
    let label: String
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.gray.opacity(0.2))
                    .frame(height: 12)
                
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.yellow)
                    .frame(width: min(geometry.size.width * value, geometry.size.width), height: 12)
                    .animation(.easeInOut(duration: 0.3), value: value)
                
                Text(label)
                    .font(.system(size: 12))
                    .foregroundColor(colorScheme == .dark ? .white : .black)
                    .padding(.leading, min(geometry.size.width * value + 5, geometry.size.width - 20))
            }
        }
    }
}
