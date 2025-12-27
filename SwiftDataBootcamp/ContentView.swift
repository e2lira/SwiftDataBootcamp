//
//  ContentView.swift
//  SwiftDataBootcamp
//
//  Created by Edgar Gonzalez Lira on 22/12/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
//    ¿Por qué no usar @Environment dentro de la clase?
//    El property wrapper @Environment es exclusivo de los tipos que conforman el protocolo View. Una clase de lógica (ViewModel) no tiene acceso directo al árbol de entorno de SwiftUI, por lo que siempre debes inyectar el contexto manualmente desde la vista.
    @Environment(\.modelContext) private var modelContext
    
    @State private var viewModel: ContentViewModel?
    @State private var showSheet: Bool = false
    @State private var addProduct = Product()
    @State private var showErrorAlert: Bool = false
    
    @Query private var types: [TypeProduct]
    @Query private var products: [Product]

    var body: some View {
        NavigationSplitView {
            List{
                Section("Categorías (Tipos)") {
                    ForEach(types) { tipo in
                        Text("\(tipo.name) (\(tipo.products?.count ?? 0) items)")
                    }
                }

                    ForEach(products) { item in
                        NavigationLink {
                            Text("Item at \(item.id)")
                        } label: {
                            Text(item.name ?? "")
                            Text(item.type?.name ?? "Sin categoría")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Text(item.timestamp ?? Date(), format: Date.FormatStyle(date: .numeric, time: .standard))
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
            .sheet(isPresented: $showSheet, onDismiss: sheetDismissed) {
                AddProductView(product: addProduct)
            }
            
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                    }
                    ToolbarItem {
                        Button(action: addItem) {
                            Label("Add Item", systemImage: "plus")
                        }
                    }
                    ToolbarItem {
                        Button(action: newProduct) {
                            Label("New Product", systemImage: "plus")
                        }
                    }
                }

            } detail: {
                Text("Select an item")
            }
            .onChange(of: viewModel?.errorMessage) { _, newValue in
                showErrorAlert = newValue != nil
            }
            .onAppear {
                // Inicialización tardía para catpurar el contexto del entorno
                if (viewModel == nil){
                    viewModel = ContentViewModel(modelContext: modelContext)
                }
            }
            .alert("Error", isPresented: $showErrorAlert, presenting: viewModel?.errorMessage) { _ in
                Button("OK", role: .cancel) {
                    // Clear the error after dismissing
                    viewModel?.errorMessage = nil
                }
            } message: { errorMessage in
                Text(errorMessage)
            }
        }
    
    
    private func sheetDismissed() { 
        // Ejecuta la acción cuando el sheet se oculta.
        // Ejemplos:
        // - Guardar el producto si está completo
        // - Reiniciar el estado temporal
        // Aquí por defecto solo reiniciamos el producto temporal
        withAnimation {
//            viewModel?.insertProduct(name: addProduct.name ?? "", price: addProduct.price ?? 0.0, typeName: addProduct.type?.name ?? "Panadería")
            viewModel?.insertObjProduct(product: addProduct)
        }
        addProduct = Product()
    }
    
    private func newProduct() {
        showSheet.toggle()
    }
    
    private func addItem() {
        withAnimation {
            viewModel?.insertProduct(name: "Donut", price: 12.10, typeName: "Panadería")
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(products[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Product.self, inMemory: true)
}

