//
//  TypeProductDTO.swift
//  SwiftDataBootcamp
//
//  Created by Edgar Gonzalez Lira on 06/01/26.
//
import Foundation

struct TypeProductDTO: Codable {
    let name: String
    
    init(name: String) {
        self.name = name
    }
}
