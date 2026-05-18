//
//  ItemEntity.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 05.05.2026.
//

import CoreData

// Регистрируем класс в Objective-C рантайме (нужно для Core Data)
@objc(Item)
public class Item: NSManagedObject {
    // Объявляем свойство, которое Core Data будет управлять
    @NSManaged public var id: String
    @NSManaged public var name: String
    @NSManaged public var icon: String
}

// Добавляем удобные методы для работы
extension Item {
    // FetchRequest для получения всех Item
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }
    
    // Удобный инициализатор
    convenience init(context: NSManagedObjectContext, id: String, name: String, icon: String) {
        guard let entity = NSEntityDescription.entity(forEntityName: "Item", in: context) else {
            fatalError("Entity Item not found in model")
        }
        self.init(entity: entity, insertInto: context)
        self.id = id
        self.name = name
        self.icon = icon
    }
}
