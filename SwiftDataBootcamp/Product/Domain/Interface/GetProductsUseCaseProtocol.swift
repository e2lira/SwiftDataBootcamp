//
//  ProductInterface.swift
//  SwiftDataBootcamp
//
//  Created by Edgar Gonzalez Lira on 06/01/26.
//

import Foundation

// Protocolo o Interface contiene el contrato o función a ejecutar
protocol GetProductsUseCaseProtocol {
    func Execute() -> [Product]
}
