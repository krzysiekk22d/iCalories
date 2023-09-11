//
//  AddFoodView.swift
//  iCalories
//
//  Created by Krzysztof Czura on 11/09/2023.
//

import SwiftUI
import CoreData

struct AddFoodView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var calories: Double = 0
    
    var body: some View {
        Form {
            Section {
                TextField("Food name", text: $name)
                
                VStack {
                    
                    Text("Calories: \(Int(calories))")
                    Slider(value: $calories, in: 0...1000, step: 1) // Adjust the step value
                }
                .padding()
                
                HStack {
                    Spacer()
                    Button("Submit") {
                        DataController.shared.addFood(name: name, calories: calories, context: managedObjectContext)
                        dismiss()
                    }
                    Spacer()
                }
            }
        }
    }
}
