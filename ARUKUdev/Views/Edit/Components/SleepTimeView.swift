import SwiftUI

struct SleepTimeView: View {
    @Binding var sleepHours: Double
    
    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            Text("睡眠時間")
                .font(.system(size: 16, weight: .medium))
            
            HStack {
                Slider(value: $sleepHours, in: 0...15, step: 0.5)
                    .accentColor(.yellow)
                    .frame(width: UIScreen.main.bounds.width * 0.7)
                    .padding(.horizontal, 20)
            }
            
            Text("\(Int(sleepHours))h")
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.black)
        }
        .padding(.vertical, 24)
        .frame(maxWidth: .infinity)
        .cardStyle()
        .accessibilityValue("\(Int(sleepHours))時間")
    }
}
