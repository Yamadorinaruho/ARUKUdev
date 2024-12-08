import Foundation

struct MoodItem: Identifiable {
    let id: Int
    let defaultImage: String
    let selectedImage: String
    let description: String
    
    static let allMoods: [MoodItem] = [
        MoodItem(id: 0, defaultImage: "very_sad", selectedImage: "very_sad_selected", description: "とても悲しい"),
        MoodItem(id: 1, defaultImage: "sad", selectedImage: "sad_selected", description: "悲しい"),
        MoodItem(id: 2, defaultImage: "neutral", selectedImage: "neutral_selected", description: "普通"),
        MoodItem(id: 3, defaultImage: "happy", selectedImage: "happy_selected", description: "嬉しい"),
        MoodItem(id: 4, defaultImage: "very_happy", selectedImage: "very_happy_selected", description: "とても嬉しい")
    ]
}
