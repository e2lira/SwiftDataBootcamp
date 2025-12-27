//
//  TypeProduct.swift
//  SwiftDataBootcamp
//
//  Created by Edgar Gonzalez Lira on 22/12/25.
//

import Foundation
import SwiftData

@Model
final class TypeProduct {
    @Attribute(.unique) var name: String
    
    // Relación: Un tipo tiene muchos productos
    // .cascade elimina los productos si se elimina el tipo
    @Relationship(deleteRule: .cascade, inverse: \Product.typeProduct)
    var products: [Product]? = []
    
    init(name: String) {
        self.name = name
    }
}
