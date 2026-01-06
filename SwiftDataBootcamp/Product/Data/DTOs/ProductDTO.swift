//
//  ProductDTO.swift
//  SwiftDataBootcamp
//
//  Created by Edgar Gonzalez Lira on 06/01/26.
//

import Foundation

struct ProductDTO: Codable {
    let id: UUID
    let name: String?
    let price: Double?
    let enabled: Bool?
    let timestamp: Date?
    // Relation one product belons to ane type of product
    let type: TypeProductDTO?
}
