//
//  AddProductView.swift
//  SwiftDataBootcamp
//
//  Created by Edgar Gonzalez Lira on 26/12/25.
//

import SwiftUI
import SwiftData

struct AddProductView: View {
    
    @Bindable var product: Product
    
    var body: some View {
        Form {
            Section(header: Text("Información")) {
                TextField("Nombre", text: Binding<String>(
                    get: { product.name ?? "" },
                    set: { product.name = $0.isEmpty ? nil : $0 }
                ))
                TextField("Precio", value: $product.price, format: .number)
                    .keyboardType(.decimalPad)
            }

            TypeProductPicker(selectedType: $product.type)
        }
        .navigationTitle("Agregar producto")
    }
}

private struct TypeProductPicker: View {
    @Query(sort: \TypeProduct.name) private var types: [TypeProduct]
    @Binding var selectedType: TypeProduct?

    var body: some View {
        Section(header: Text("Tipo")) {
            if types.isEmpty {
                HStack {
                    Image(systemName: "exclamationmark.triangle")
                    Text("No hay tipos disponibles")
                        .foregroundStyle(.secondary)
                }
            } else {
                Picker("Tipo", selection: $selectedType) {
                    Text("Sin tipo").tag(Optional<TypeProduct>.none)
                    ForEach(types, id: \.self) { type in
                        Text(type.name).tag(Optional(type))
                    }
                }
            }
        }
    }
}

#Preview {
    var product = Product(id: UUID(), name: "Leche de coco", price: 30.00, timestamp: Date(), type: TypeProduct(name: "Lácteos")  )
    AddProductView(product: product)
}
