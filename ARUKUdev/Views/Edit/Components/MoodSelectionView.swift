import SwiftUI

struct MoodSelectionView: View {
    @Binding var selectedMood: Int?
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Text("今日の気分はどうですか？")
                .font(.system(size: 16, weight: .medium))
            
            HStack(spacing: 20) {
                ForEach(MoodItem.allMoods) { mood in
                    MoodButton(mood: mood, isSelected: selectedMood == mood.id) {
                        selectedMood = mood.id
                    }
                }
            }
            .padding(.bottom, 8)
        }
        .padding(.vertical, 24)
        .frame(maxWidth: .infinity)
        .cardStyle()
    }
}

private struct MoodButton: View {
    let mood: MoodItem
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(isSelected ? mood.selectedImage : mood.defaultImage)
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
        }
        .accessibilityLabel(mood.description)
    }
}
