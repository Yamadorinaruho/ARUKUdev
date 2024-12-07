import SwiftUI

struct DayDetailsView: View {
    let selectedDate: Date
    let sleepHours: Double
    @Environment(\.colorScheme) private var colorScheme
    
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM月dd日(E)"
        formatter.locale = Locale(identifier: "ja_JP")
        return formatter.string(from: selectedDate)
    }
    
    private var hasData: Bool {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.month, .day], from: selectedDate)
        return components.month == 12 && components.day == 7
    }
    
    var body: some View {
        if hasData {
            VStack(alignment: .leading, spacing: 15) {
                Text(formattedDate)
                    .font(.system(size: 18, weight: .medium))
                    .padding(.bottom, 5)
                    .accessibilityLabel("\(formattedDate)のデータ")
                
                HStack {
                    Image(systemName: "face.smiling.fill")
                        .foregroundColor(.orange)
                        .font(.system(size: 24))
                    Text("早起き / 散歩")
                        .font(.system(size: 16))
                }
                .accessibilityElement(children: .combine)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("睡眠時間")
                        .font(.system(size: 16))
                    
                    ProgressBar(value: sleepHours / 12.0, label: "\(Int(sleepHours))h")
                        .frame(height: 20)
                        .accessibilityLabel("睡眠時間\(Int(sleepHours))時間")
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(colorScheme == .dark ? Color(UIColor.systemGray6) : .white)
            .cornerRadius(15)
            .shadow(color: Color.black.opacity(0.05), radius: 1, x: 0, y: 1)
        } else {
            EmptyDayCard(date: formattedDate)
        }
    }
}

fileprivate struct EmptyDayCard: View {
    let date: String
    @Environment(\.colorScheme) private var colorScheme
    @State private var isPressed = false
    
    var body: some View {
        HStack {
            Text(date)
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(colorScheme == .dark ? .white : .black)
            
            Spacer()
            
            Image(systemName: "plus")
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(colorScheme == .dark ? .white : .black.opacity(0.8))
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(colorScheme == .dark ? Color(UIColor.systemGray6) : .white)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color.black.opacity(0.1), lineWidth: 0.5)
        )
        .shadow(color: Color.black.opacity(0.05), radius: 1, x: 0, y: 1)
        .scaleEffect(isPressed ? 0.98 : 1.0)
        .animation(.easeInOut(duration: 0.1), value: isPressed)
        .accessibilityLabel("\(date)にデータを追加")
        .accessibilityAddTraits(.isButton)
        .onTapGesture {
            withAnimation {
                isPressed = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    isPressed = false
                    // TODO: データ追加画面への遷移処理
                }
            }
        }
    }
}
