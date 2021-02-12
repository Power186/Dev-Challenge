//
//  Add_Save_ProjectApp.swift
//  Add Save Project
//
//  Created by Scott on 2/11/21.
//

import SwiftUI

@main
struct Add_Save_ProjectApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environment(\.colorScheme, .light)
        }
    }
}
