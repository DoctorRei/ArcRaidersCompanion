//
//  PersistenceController.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 05.05.2026.
//

import CoreData

enum CoreDataModel {
    static func create() -> NSManagedObjectModel {
        let model = NSManagedObjectModel()
        
        // Создаём Entity
        let itemEntity = NSEntityDescription()
        itemEntity.name = "Item"
        itemEntity.managedObjectClassName = "Item"
        
        // Создаём атрибут "name" типа String
        let idAttribute = NSAttributeDescription()
        idAttribute.name = "id"
        idAttribute.attributeType = .stringAttributeType
        idAttribute.isOptional = false  // не может быть nil
        
        // Добавляем атрибут к сущности
        itemEntity.properties = [idAttribute]
        
        // Добавляем сущность в модель
        model.entities = [itemEntity]
        
        return model
    }
}

