import SwiftUI

struct ProgressBar: View {
    let value: Double
    let label: String
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.gray.opacity(0.15))
                
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.customYellow)  // .yellow から .customYellow に変更
                    .frame(width: max(min(geometry.size.width * value, geometry.size.width), 0))
                
                Text(label)
                    .font(.system(size: 14))
                    .foregroundColor(colorScheme == .dark ? .white : .black)
                    .padding(.leading, min(
                        max(geometry.size.width * value + 5, 25),
                        geometry.size.width - 25
                    ))
            }
        }
    }
}
