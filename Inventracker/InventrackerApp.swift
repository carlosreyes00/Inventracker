//
//  InventrackerApp.swift
//  Inventracker
//
//  Created by Carlos Rafael Reyes Magadán on 4/3/23.
//

import SwiftUI

@main
struct InventrackerApp: App {
    let viewContext = PersistenceController.shared.container.viewContext
    
    @Environment(\.undoManager) private var undoManager
    
    @Environment(\.scenePhase) private var scenePhase

    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    viewContext.undoManager = UndoManager()
                }
                .environment(\.managedObjectContext, viewContext)
        }
        .onChange(of: scenePhase) { _ in
            saveContext(context: viewContext)
        }
    }
}
