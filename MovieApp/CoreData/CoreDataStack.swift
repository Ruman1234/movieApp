//
//  CoreDataStack.swift
//  MovieApp
//
//  Created by Ruman on 13/05/2022.
//

import Foundation
import CoreData

class CoreDataStack: NSObject {
    static let shared = CoreDataStack()
    // Make init private for singleton
    
    private override init() {
        
    }
    
    var storeName: String = "MovieApp"
    var storeURL : URL {
        let storePaths = NSSearchPathForDirectoriesInDomains(.applicationSupportDirectory, .userDomainMask, true)
        let storePath = storePaths[0] as NSString
        let fileManager = FileManager.default
        
        do {
            try fileManager.createDirectory(
                atPath: storePath as String,
                withIntermediateDirectories: true,
                attributes: nil)
        } catch {
//            DLog("Error creating storePath \(storePath): \(error)")
        }
        
        let sqliteFilePath = storePath
            .appendingPathComponent(storeName + ".sqlite")
        return URL(fileURLWithPath: sqliteFilePath)
    }
    
    lazy var storeDescription: NSPersistentStoreDescription = {
        let description = NSPersistentStoreDescription(url: self.storeURL)
        description.shouldMigrateStoreAutomatically = true
        description.shouldInferMappingModelAutomatically = true
        return description
    }()
    
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: self.storeName)
        container.persistentStoreDescriptions = [self.storeDescription]
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
//                DLog("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    //Main MOC
    lazy var managedObjectContext: NSManagedObjectContext = {
        return self.persistentContainer.viewContext
    }()
    
    //New Background MOC
    func newBackgroundContext() -> NSManagedObjectContext {
        return persistentContainer.newBackgroundContext()
    }
    
    // MARK: - Core Data Saving support
    @discardableResult class func saveContext(managedObjectContext:NSManagedObjectContext) -> Bool
    {
        var error = false
        if (managedObjectContext.hasChanges)
        {
            do {
                try managedObjectContext.save()
            } catch _ {
//                DLog("MOC Save Error: \(exp)")
                error = true
            }
        }
        return error
    }
    
    
}
