import SwiftUI

struct ActivitiesSelectionView: View {
    let activities: [String]
    @Binding var selectedActivities: Set<String>
    
    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            Text("今日できたことは何ですか？")
                .font(.system(size: 16, weight: .medium))
            
            ActivitiesGrid(
                activities: activities,
                selectedActivities: $selectedActivities
            )
        }
        .padding(24)
        .frame(maxWidth: .infinity)
        .cardStyle()
    }
}

private struct ActivitiesGrid: View {
    let activities: [String]
    @Binding var selectedActivities: Set<String>
    
    var body: some View {
        LazyVGrid(
            columns: [
                GridItem(.flexible()),
                GridItem(.flexible()),
                GridItem(.flexible())
            ],
            spacing: 16
        ) {
            ForEach(activities, id: \.self) { activity in
                ActivityButton(
                    title: activity,
                    isSelected: selectedActivities.contains(activity),
                    action: {
                        if selectedActivities.contains(activity) {
                            selectedActivities.remove(activity)
                        } else {
                            selectedActivities.insert(activity)
                        }
                    }
                )
            }
        }
    }
}
