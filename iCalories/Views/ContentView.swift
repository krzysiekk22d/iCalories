//
//  ContentView.swift
//  iCalories
//
//  Created by Krzysztof Czura on 11/09/2023.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var managedObjContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var food: FetchedResults<Food>
    
    @State private var showingAddView = false
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("\(Int(totalCaloriesToday())) kcal Today")
                    .foregroundColor(.gray)
                    .padding(.horizontal)
                List {
                    ForEach(food) { food in
                        NavigationLink {
                            EditFoodView(food: food)
                        } label: {
                            HStack {
                                VStack(alignment: .leading, spacing: 6) {
                                    Text(food.name ?? "")
                                        .bold()
                                    
                                    Text("\(Int(food.calories)) calories")
                                        .foregroundColor(.red)
                                }
                                Spacer()
                                Text(dateFormatter.string(from: food.date ?? Date()))
                                    .foregroundColor(.gray)
                                    .italic()
                            }
                        }
                    }
                    .onDelete(perform: deleteFood)
                }
                .listStyle(.plain)
            }
            .navigationTitle("iCalories")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddView.toggle()
                    } label: {
                        Label("Add Food", systemImage: "plus.circle")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
            }
            .sheet(isPresented: $showingAddView) {
                AddFoodView()
            }
        }
        .navigationViewStyle(.stack)
    }
    
    private func deleteFood(offsets: IndexSet) {
        withAnimation {
            offsets.map { food[$0] }.forEach(managedObjContext.delete)
            
            DataController.shared.save(context: managedObjContext)
        }
    }
    
    private func totalCaloriesToday() -> Double {
            let today = Calendar.current.startOfDay(for: Date())
            
            return food
                .filter { Calendar.current.isDate($0.date ?? Date(), inSameDayAs: today) }
                .reduce(0) { $0 + $1.calories }
        }
    }
