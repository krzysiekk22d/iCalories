//
//  EditFoodView.swift
//  iCalories
//
//  Created by Krzysztof Czura on 11/09/2023.
//

import SwiftUI

struct EditFoodView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.dismiss) var dismiss
    
    var food: FetchedResults<Food>.Element
    
    @State private var name = ""
    @State private var calories: Double = 0
    
    var body: some View {
        Form {
            Section {
                TextField("\(food.name ?? "")", text: $name)
                    .onAppear {
                        name = food.name ?? ""
                        calories = food.calories
                    }
                VStack {
                    Text("Calories: \(Int(calories))")
                    Slider(value: $calories, in: 0...1000, step: 1) // Adjust the step value
                }
                .padding()
                
                HStack {
                    Spacer()
                    Button("Submit") {
                        DataController.shared.editFood(food: food, name: name, calories: calories, context: managedObjectContext)
                        dismiss()
                    }
                    Spacer()
                }
            }
        }
    }
}
