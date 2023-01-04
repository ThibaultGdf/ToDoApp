//
//  ToDo_AppApp.swift
//  ToDo App
//
//  Created by Thibault GODEFROY on 04/01/2023.
//

import SwiftUI

@main
struct ToDo_AppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
