//
//  iCaloriesApp.swift
//  iCalories
//
//  Created by Krzysztof Czura on 11/09/2023.
//

import SwiftUI

@main
struct iCaloriesApp: App {
    
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
