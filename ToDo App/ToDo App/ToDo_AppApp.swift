//
//  ToDo_AppApp.swift
//  ToDo App
//
//  Created by Zdenko Čepan on 18.09.2023.
//

import SwiftUI

@main
struct ToDo_AppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            //ContentView()
            ToDoListScene()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
