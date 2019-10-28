//
//  DatabaseSpec.swift
//  revolut_ios_testTests
//
//  Created by Hannes Van den Berghe on 28/10/2019.
//  Copyright © 2019 HannesVDB. All rights reserved.
//

import XCTest
@testable import revolut_ios_test
import CoreData

class DatabaseSpec: XCTestCase {

    lazy var mockPersistantContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreDataUnitTesting", managedObjectModel: self.managedObjectModel)
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        description.shouldAddStoreAsynchronously = false
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores { (description, error) in

        }
        return container
    }()
    
    var managedObjectModel: NSManagedObjectModel = {
        let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle.main])!
        return managedObjectModel
    }()
    
    var sut: Database!
    
    override func setUp() {
        sut = Database(container: mockPersistantContainer)
    }
    
    func testItemShouldbeNilForNonExisting() {
        let item = sut.object(for: MockObject.self)
        XCTAssertNil(item)
    }
}

fileprivate class MockObject: NSManagedObject {
    
}
