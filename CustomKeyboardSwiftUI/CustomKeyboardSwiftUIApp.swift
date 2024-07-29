//
//  CustomKeyboardSwiftUIApp.swift
//  CustomKeyboardSwiftUI
//
//  Created by Rashid Latif on 29/07/2024.
//

import SwiftUI

@main
struct CustomKeyboardSwiftUIApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
