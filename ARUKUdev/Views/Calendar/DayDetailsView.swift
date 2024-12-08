import SwiftUI

struct DayDetailsView: View {
    let selectedDate: Date
    @StateObject private var viewModel = DayRecordViewModel()
    @Environment(\.colorScheme) private var colorScheme: ColorScheme
    @State private var showingEditView = false
    @State private var isPressed = false
    
    private var currentRecord: DayRecord? {
        viewModel.getRecord(for: selectedDate)
    }
    
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "M月d日(E)"
        formatter.locale = Locale(identifier: "ja_JP")
        return formatter.string(from: selectedDate)
    }
    
    var body: some View {
        Group {
            if let record = currentRecord {
                VStack(alignment: .leading, spacing: 15) {
                    Text(formattedDate)
                        .font(.system(size: 18, weight: .medium))
                        .padding(.bottom, 5)
                    
                    HStack(spacing: 16) {
                        Image(MoodItem.allMoods[record.mood ?? 2].selectedImage)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                        
                        if !record.activities.isEmpty {
                            Text(record.activities.joined(separator: " / "))
                                .font(.system(size: 16))
                                .lineLimit(1)
                        }
                    }
                    .accessibilityElement(children: .combine)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("睡眠時間")
                            .font(.system(size: 16))
                        
                        ProgressBar(
                            value: record.sleepHours / 15.0,
                            label: "\(Int(record.sleepHours))h"
                        )
                        .frame(height: 24)
                        .accessibilityLabel("睡眠時間\(Int(record.sleepHours))時間")
                    }
                }
                .contentShape(Rectangle())  // タップ領域を確保
                .padding(.horizontal, 30)
                .padding(.vertical, 18)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(colorScheme == .dark ? Color(UIColor.systemGray6) : .white)
                .cornerRadius(15)
                .shadow(color: Color.black.opacity(0.05), radius: 1, x: 0, y: 1)
                .scaleEffect(isPressed ? 0.98 : 1.0)
                .animation(.easeInOut(duration: 0.1), value: isPressed)
                .onTapGesture {
                    withAnimation {
                        isPressed = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            isPressed = false
                            showingEditView = true
                        }
                    }
                }
                .accessibilityAddTraits(.isButton)
            } else {
                EmptyDayCard(date: formattedDate, showingEditView: $showingEditView)
            }
        }
        .sheet(isPresented: $showingEditView) {
            DataEditView(
                viewModel: viewModel,
                date: selectedDate
            )
        }
    }
}

private struct EmptyDayCard: View {
    let date: String
    @Binding var showingEditView: Bool
    @Environment(\.colorScheme) private var colorScheme: ColorScheme
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
                    showingEditView = true
                }
            }
        }
    }
}
