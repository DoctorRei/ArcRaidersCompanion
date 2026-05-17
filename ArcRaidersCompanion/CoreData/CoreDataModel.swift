//
//  PersistenceController.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 05.05.2026.
//

import CoreData

enum CoreDataModel {
    static var currentVersion: Int = 2
    
    static func create() -> NSManagedObjectModel {
        let model = NSManagedObjectModel()
        
        let itemEntity = NSEntityDescription()
        itemEntity.name = "Item"
        itemEntity.managedObjectClassName = "Item"

        itemEntity.userInfo = ["version": currentVersion]

        let idAttribute = createAttribute(name: "id", type: .stringAttributeType)
        let nameAttribute = createAttribute(name: "name", type: .stringAttributeType)
        let iconAttribute = createAttribute(name: "icon", type: .stringAttributeType)

        itemEntity.properties = [idAttribute, nameAttribute, iconAttribute]
        model.entities = [itemEntity]

        return model
    }

    private static func createAttribute(name: String, type: NSAttributeType) -> NSAttributeDescription {
        let attribute = NSAttributeDescription()
        attribute.name = name
        attribute.attributeType = type
        attribute.isOptional = false
        return attribute
    }
}
