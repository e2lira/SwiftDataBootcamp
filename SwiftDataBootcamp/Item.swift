//
//  Item.swift
//  SwiftDataBootcamp
//
//  Created by Edgar Gonzalez Lira on 22/12/25.
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
