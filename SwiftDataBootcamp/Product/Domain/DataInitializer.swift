//
//  DataInitializer.swift
//  SwiftDataBootcamp
//
//  Created by Edgar Gonzalez Lira on 22/12/25.
//

import Foundation
import SwiftData

@MainActor
class DataInitializer{
    static func setup(container: ModelContainer){
        let context = container.mainContext
        
        // 1. Verificar si ya existen datos para no duplicar
        let descriptor = FetchDescriptor<TypeProduct>()
        if let count = try? context.fetchCount(descriptor), count > 0 {
            return // Ya hay datos, no hacer nada
        }
        
        // 2. Crear datos iniciales para type product
        let lacteos = TypeProduct(name: "Lácteos")
        let panaderia = TypeProduct(name: "Panadería")
        let frutas = TypeProduct(name: "Frutas")
        
        // 3. Crear products with relation ship type product
//        let milk = Product(id: UUID(), name: "Milk", price: 45.50, timestamp: Date())
//        let croissant = Product(id: UUID(), name: "Croissant", price: 15.20, timestamp: Date())
//        let apple = Product(id: UUID(), name: "Apple", price: 10.50, timestamp: Date())
//        let milk = Product(id: UUID(), name: "Milk", price: 45.50, timestamp: Date(), type: lacteos)
//        let croissant = Product(id: UUID(), name: "Croissant", price: 15.20, timestamp: Date(), type: panaderia)
//        let apple = Product(id: UUID(), name: "Apple", price: 10.50, timestamp: Date(), type: frutas)
        
        // 4. Insert into the context
        context.insert(lacteos)
        context.insert(panaderia)
        context.insert(frutas)
//        context.insert(milk)
//        context.insert(croissant)
//        context.insert(apple)
        
        // SwiftData save automatically but we can forze to save
        try? context.save()
    }
}
