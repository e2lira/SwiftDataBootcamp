//
//  SwiftDataBootcampApp.swift
//  SwiftDataBootcamp
//
//  Created by Edgar Gonzalez Lira on 22/12/25.
//

import SwiftUI
import SwiftData

@main
struct SwiftDataBootcampApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Product.self,
            TypeProduct.self,
        ])
        // isStoredInMemoryOnly: Usa true para pruebas rápidas y false para la base de datos real del usuario.
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)

        do {
           // return try ModelContainer(for: schema, configurations: [modelConfiguration])
            let container = try ModelContainer(for: schema, configurations: [modelConfiguration])
                      
                      // LLAMADA A LA PRECARGA
            Task { @MainActor in
                DataInitializer.setup(container: container)
            }
                      
            return container
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
