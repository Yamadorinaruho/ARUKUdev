import SwiftUI

struct CalendarHeaderView: View {
    let dateString: String
    
    var body: some View {
        HStack {
            Text(dateString)
                .font(.system(size: 18, weight: .medium))
            Image(systemName: "chevron.down")
        }
    }
}
