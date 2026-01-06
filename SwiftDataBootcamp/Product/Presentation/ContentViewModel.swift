//
//  ContentViewModel.swift
//  SwiftDataBootcamp
//
//  Created by Edgar Gonzalez Lira on 22/12/25.
//

import Foundation
import SwiftData

@Observable
final class ContentViewModel {
    var modelContext: ModelContext
    var errorMessage: String?
    var allProducts: [Product] = []
    
    // Dependency Injection
    // 1 Declarar una variable con el protocolo o interface
    let getProductsUseCase: GetProductsUseCaseProtocol
//    Nota sobre hilos (Threads)
//    Si planeas hacer operaciones pesadas en segundo plano dentro de tu clase:
//    El modelContext principal está ligado al Main Actor.
//    Si necesitas procesar datos en background, deberás pasar el modelContainer a la clase y crear un ModelContext nuevo (o usar un ModelActor) para operaciones fuera del hilo principal.
    
    // Dependency Injection
    // 2 Pasar como parametro la variable de tipo Protocol en el init
    init(modelContext: ModelContext, getProductsUseCase: GetProductsUseCaseProtocol) {
        self.modelContext = modelContext
        self.getProductsUseCase = getProductsUseCase
    }
    
    // Dependency Injection
    // 3 Ejecutar mediante la variable de tipo protocolo el método de la clase
    func getAllProducts(){
        allProducts = getProductsUseCase.Execute()
    }
    
    func insertObjProduct(product: Product){
        if product.isValid(){
            do {
                modelContext.insert(product)
                try modelContext.save()
            } catch {
                print("Error al insertar: \(error.localizedDescription)")
                self.errorMessage = error.localizedDescription
            }
        } else {
            let message = "El producto no es válido. Verifica los campos."
            print(message)
            self.errorMessage = message
        }
    }
    
    func insertProduct(name: String, price: Double, typeName: String){
        // 1. Crea un descriptor para buscar el tipo por nombre
        let descriptor = FetchDescriptor<TypeProduct>(
            predicate: #Predicate { $0.name ==  typeName }
        )
        
        do {
            // 2. Intentar buscar el tipo de producto en la base de datos
            let typesFinded = try modelContext.fetch(descriptor)
            let typeSelected: TypeProduct
            
            if let typeFinded = typesFinded.first {
                // Si existe lo reutilizamos
                typeSelected = typeFinded
            } else {
                // Si no existe, creamos uno nuevo
                typeSelected = TypeProduct(name: typeName)
                modelContext.insert(typeSelected)
            }
            
            // 3. Crear el producto y asignarle el tipo de producto  (existente o nuevo)
            let newProduct = Product(id: UUID(), name: name, price: price, timestamp: Date(), type: typeSelected)
            modelContext.insert(newProduct)
            
            // 4. Guardar cambios
            try modelContext.save()
            
            
        } catch {
            print("Error al insertar: \(error.localizedDescription)")
            self.errorMessage = error.localizedDescription
        }
    }
    
}
