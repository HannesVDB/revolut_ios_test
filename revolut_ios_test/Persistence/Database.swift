//
//  Database.swift
//  revolut_ios_test
//
//  Created by Hannes Van den Berghe on 23/10/2019.
//  Copyright © 2019 HannesVDB. All rights reserved.
//

import CoreData

protocol Persistence {
    var currencyPairs: [CurrencyPair]? { get }
    func persist(pair: CurrencyPair)
    func deleteCurrencyPair(_ pair: CurrencyPair)
}

class Database: Persistence {
    
    // MARK: - Properties
    
    static var shared = Database()
    internal let container: NSPersistentContainer
    
    // MARK: - Init
    
    init(container: NSPersistentContainer = NSPersistentContainer(name: AppConstants.coreDataContainer)) {
        self.container = container
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Error \(error)")
                return
            }
        }
    }
    
    // MARK: - Methods
    
    func object<T: NSManagedObject>(for type: T.Type) -> NSManagedObject? {
        guard let entity = NSEntityDescription.entity(forEntityName: type.name, in: container.viewContext) else { return nil }
        return NSManagedObject(entity: entity, insertInto: container.viewContext)
    }
    
    func save() {
        do {
            try container.viewContext.save()
        } catch let error as NSError {
          print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func fetch<T: NSManagedObject>(for type: T.Type) -> [T]? {
        do {
            let request = fetchRequest(for: type)
            return try container.viewContext.fetch(request) as? [T]
        } catch {
            print("Could not retreive \(error)")
            return nil
        }
    }
    
    func fetch<T: NSManagedObject>(for type: T.Type, with primaryKey: String) -> T? {
        do {
            let request = fetchRequest(for: type)
            request.predicate = NSPredicate(format: "id = %@", primaryKey)
            return try container.viewContext.fetch(request).first as? T
        } catch {
            print("Could not retreive \(error)")
            return nil
        }
    }
    
    func delete<T: NSManagedObject>(value: T) {
        container.viewContext.delete(value)
    }
}

// MARK: - Helper

private extension Database {
    private func fetchRequest<T: NSManagedObject>(for type: T.Type) -> NSFetchRequest<NSManagedObject> {
        return NSFetchRequest<NSManagedObject>(entityName: type.name)
    }
}

extension NSManagedObject {
    class var name: String {
        return String(describing: self)
    }
}
