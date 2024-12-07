//
//  Item.swift
//  ARUKUdev
//
//  Created by yamadorinaruho on 2024/12/07.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
