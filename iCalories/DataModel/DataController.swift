//
//  DataController.swift
//  iCalories
//
//  Created by Krzysztof Czura on 11/09/2023.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    static let shared = DataController()
    
    let container = NSPersistentContainer(name: "FoodModel")
    
    init() {
        container.loadPersistentStores { desc, error in
            if let error = error {
                print("Failed to load the data. \(error.localizedDescription)")
            }
        }
    }
    
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("Data saved.")
        } catch {
            print("Couldn't save.")
        }
        
        // uncomment code below to check the Core Data file path:
        
//        guard let url = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).last else {
//            fatalError("Unable to locate application support directory.")
//        }
//
//        let sqliteFilePath = url.appendingPathComponent("YourDataModelName.sqlite")
//        print("Path to SQLite file: \(sqliteFilePath.path)")

        
    }
    
    func addFood(name: String, calories: Double, context: NSManagedObjectContext) {
        let food = Food(context: context)
        food.id = UUID()
        food.date = Date()
        food.name = name
        food.calories = calories
        
        save(context: context)
    }
    
    func editFood(food: Food, name: String, calories: Double, context: NSManagedObjectContext) {
        food.date = Date()
        food.name = name
        food.calories = calories
        
        save(context: context)
    }
}
