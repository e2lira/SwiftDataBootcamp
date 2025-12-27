//
//  Item.swift
//  SwiftDataBootcamp
//
//  Created by Edgar Gonzalez Lira on 22/12/25.
//

import Foundation
import SwiftData

@Model
final class Product {
    var id: UUID
    var name: String
    var price: Double
    var enabled: Bool
    var timestamp: Date
    // Relation one product belons to ane type of product
    var typeProduct: TypeProduct?
    
    init(id: UUID, name: String, enabled: Bool = true, timestamp: Date, typeProduct: TypeProduct? = nil) {
        self.id = id
        self.name = name
        self.enabled = enabled
        self.timestamp = timestamp
        self.typeProduct = typeProduct
    }
    
}
