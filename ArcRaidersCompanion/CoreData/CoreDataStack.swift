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
        // Создаём модель ПРОГРАММНО (без xcdatamodeld файла!)
        let model = CoreDataModel.create()
        
        // Создаём контейнер с нашей моделью
        persistentContainer = NSPersistentContainer(
            name: "AppModel",  // это имя не важно, т.к. мы передали модель
            managedObjectModel: model
        )
        
        // Настраиваем хранилище (где будут сохраняться данные)
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
            ?? URL(fileURLWithPath: NSTemporaryDirectory())
        let storeURL = documentsURL.appendingPathComponent("AppModel.sqlite")

        let storeDescription = NSPersistentStoreDescription(url: storeURL)
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
}
