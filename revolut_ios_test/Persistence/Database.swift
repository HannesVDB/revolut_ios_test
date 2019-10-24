//
//  Database.swift
//  revolut_ios_test
//
//  Created by Hannes Van den Berghe on 23/10/2019.
//  Copyright © 2019 HannesVDB. All rights reserved.
//

import CoreData

class Database {
    
    static var shared = Database()
    private let container: NSPersistentContainer
    
//
//    // MARK: - Core Data Saving support
//
//    func saveContext () {
//        let context = persistentContainer.viewContext
//        if context.hasChanges {
//            do {
//                try context.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nserror = error as NSError
//                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
//            }
//        }
//    }
    
    init(container: NSPersistentContainer = NSPersistentContainer(name: "revolut_ios_test")) {
        self.container = container
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Error \(error)")
                return
            }
            print(description)
        }
    }
}
