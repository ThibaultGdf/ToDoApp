//
//  MissionViewModel.swift
//  ToDo App
//
//  Created by Thibault GODEFROY on 06/01/2023.
//

import Foundation
import SwiftUI
import CoreData

class MissionViewModel: ObservableObject {
    init() {
       fetchItems()
    }
    let container = PersistenceController.shared.container
    
    @Published var items: [Item] = []
    func saveData() {
        
        do {
            try container.viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
     func fetchItems() {
        let request = NSFetchRequest<Item>(entityName: "Item")
        do {
           items = try container.viewContext.fetch(request)
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    func addItem(title: String, mission: String, recompense: String) {
        withAnimation {
            let newItem = Item(context: container.viewContext)
            newItem.dueDate = Date()
            newItem.title = title
            newItem.mission = mission
            newItem.recompense = recompense
            
            saveData()
        }
    }
    
    
    func editItem(item: Item, title: String, mission: String, recompense: String) {
         
        item.title = title
        item.mission = mission
        item.recompense = recompense
         
    saveData()
     }
    
    
    func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(container.viewContext.delete)

        saveData()
        }
    }
    
    func deleteItem(item: Item) {
        PersistenceController.shared.container.viewContext.delete(item)
    }
}
