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
    var name: String?
    var price: Double?
    var enabled: Bool?
    var timestamp: Date?
    // Relation one product belons to ane type of product
    var type: TypeProduct?
    
    init(){
        self.id = UUID()
    }
    
    init(id: UUID, name: String, price: Double,enabled: Bool = true, timestamp: Date, type: TypeProduct? = nil) {
        self.id = id
        self.name = name
        self.price = price
        self.enabled = enabled
        self.timestamp = timestamp
        self.type = type
    }
    
    // Reglas de negocio
    // Para insertar el producto se debe tener el nombre y el precio
    public func isValid() -> Bool {
        return name != nil && price != nil
    }
    
    
    
}
