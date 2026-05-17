//
//  CoreDataManager.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 05.05.2026.
//

import CoreData

final class CoreDataStack {
    static let shared = CoreDataStack()
    
    let persistentContainer: NSPersistentContainer
    let viewContext: NSManagedObjectContext
    
    private init() {
        let model = CoreDataModel.create()
        let storeURL = Self.getStoreURL()

        if FileManager.default.fileExists(atPath: storeURL.path) {
            if !Self.isStoreCompatible(with: model, at: storeURL) {
                try? FileManager.default.removeItem(at: storeURL)
            }
        }

        persistentContainer = NSPersistentContainer(
            name: "AppModel",
            managedObjectModel: model
        )
        
        let _ = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
            ?? URL(fileURLWithPath: NSTemporaryDirectory())

        let storeDescription = NSPersistentStoreDescription(url: storeURL)
        storeDescription.shouldMigrateStoreAutomatically = true
        storeDescription.shouldInferMappingModelAutomatically = true
        persistentContainer.persistentStoreDescriptions = [storeDescription]

        // Загружаем хранилище
        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Failed to load Core Data stack: \(error)")
            }
        }

        // Сохраняем viewContext для удобства
        viewContext = persistentContainer.viewContext
    }
    
    // Сохранение контекста
    func save() {
        guard viewContext.hasChanges else { return }

        do {
            try viewContext.save()
        } catch {
            print("Failed to save context: \(error)")
        }
    }

    // Выполнение операций в фоновом контексте
    func performBackgroundTask(_ block: @escaping (NSManagedObjectContext) -> Void) {
        persistentContainer.performBackgroundTask(block)
    }
    
    private static func getStoreURL() -> URL {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentsURL.appendingPathComponent("AppModel.sqlite")
    }
    
    private static func isStoreCompatible(with model: NSManagedObjectModel, at storeURL: URL) -> Bool {
        do {
            let metadata = try NSPersistentStoreCoordinator.metadataForPersistentStore(
                ofType: NSSQLiteStoreType,
                at: storeURL,
                options: nil
            )
            return model.isConfiguration(withName: nil, compatibleWithStoreMetadata: metadata)
        } catch {
            return false
        }
    }
}
