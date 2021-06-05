//
//  WeightApp.swift
//  Weight
//
//  Created by Hanjun Kang on 6/4/21.
//

import SwiftUI

@main
struct WeightApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
