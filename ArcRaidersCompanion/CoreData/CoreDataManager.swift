//
//  CoreDataManager.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 05.05.2026.
//

import CoreData

final class CoreDataManager {
    private let stack: CoreDataStack
    
    init(stack: CoreDataStack = .shared) {
        self.stack = stack
    }
    
    // CREATE - создание нового Item
    func createItem(id: String) {
        let item = Item(context: stack.viewContext, id: id)
        item.id = id
        stack.save()
    }
    
    // READ - получение всех Item
    func fetchAllItems() -> [Item] {
        let request = Item.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        
        do {
            return try stack.viewContext.fetch(request)
        } catch {
            print("Fetch error: \(error)")
            return []
        }
    }
    
    // UPDATE - обновление имени Item
    func updateItem(_ item: Item, newId: String) {
        item.id = newId
        stack.save()
    }
    
    // DELETE - удаление Item
    func deleteItem(_ item: Item) {
        stack.viewContext.delete(item)
        stack.save()
    }
}
