//
//  Database+CurrencySpec.swift
//  revolut_ios_testTests
//
//  Created by Hannes Van den Berghe on 28/10/2019.
//  Copyright © 2019 HannesVDB. All rights reserved.
//

import XCTest
@testable import revolut_ios_test
import CoreData

class Database_CurrencySpec: XCTestCase {

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
    
    var sut: Persistence!
    
    override func setUp() {
        sut = Database(container: mockPersistantContainer)
    }
    
    func testPersistPairShouldSave() {
        let pair = CurrencyPair(id: "1", currency: Currency(abbreviation: "USD"), comparisonCurrency: Currency(abbreviation: "EUR"), dateAdded: Date())
        sut.persist(pair: pair)
        XCTAssertEqual(sut.currencyPairs?.count, 1)
    }
    
    func testDeleteShouldRemoveItem() {
        let pair = CurrencyPair(id: "1", currency: Currency(abbreviation: "USD"), comparisonCurrency: Currency(abbreviation: "EUR"), dateAdded: Date())
        sut.persist(pair: pair)
        XCTAssertEqual(sut.currencyPairs?.count, 1)
        sut.deleteCurrencyPair(pair)
        XCTAssertEqual(sut.currencyPairs?.count, 0)
    }
}
