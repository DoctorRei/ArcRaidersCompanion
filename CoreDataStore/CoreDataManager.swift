//
//  CoreDataManager.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 05.05.2026.
//

import CoreData

public class CoreDataManager {
    private let stack: CoreDataStack
    
    public init(stack: CoreDataStack = .shared) {
        self.stack = stack
    }
    
    // CREATE - создание нового Item
    public func createItem(id: String, name: String, icon: String) {
        let item = Item(context: stack.viewContext, id: id, name: name, icon: icon)
        item.id = id
        item.name = name
        item.icon = icon
        stack.save()
    }
    
    public func deleteItem(with id: String) {
        guard let item = fetchItem(for: id) else {
            print("Delete Item with id \(id) failed")
            return
        }
        
        deleteItem(item)
    }
    
    public func fetchItem(for id: String) -> Item? {
        let request = Item.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id)
        request.fetchLimit = 1
        
        do {
            return try stack.viewContext.fetch(request).first
        } catch {
            print("Fetch error: \(error)")
            return nil
        }
    }
    
    // READ - получение всех Item
    public func fetchAllItems() -> [Item] {
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
    public func updateItem(_ item: Item, newId: String) {
        item.id = newId
        stack.save()
    }
    
    // DELETE - удаление Item
    private func deleteItem(_ item: Item) {
        stack.viewContext.delete(item)
        stack.save()
    }
}
