//
//  NotificationManagerSpec.swift
//  revolut_ios_testTests
//
//  Created by Hannes Van den Berghe on 25/10/2019.
//  Copyright © 2019 HannesVDB. All rights reserved.
//

import XCTest
@testable import revolut_ios_test

class NotificationManagerSpec: XCTestCase {

    var sut: NotificationManager!
    private let notification = NSNotification.Name(rawValue: "Test")

    override func setUp() {
        sut = NotificationManager()
    }
    
    func testObservingNotificationShouldAddObserver() {
        sut.observeNotification(with: notification) { _ in
            
        }
        XCTAssert(sut.observers.count == 1)
    }
    
    func testPostingNotificationShouldCallObserver() {
        var observerCalled = false
        sut.observeNotification(with: notification) { _ in
            observerCalled = true
        }
        sut.publish(with: notification)
        XCTAssert(observerCalled)
    }
    
    func testRemoveObserversShouldcleanTheObservers() {
        sut.observeNotification(with: notification) { _ in

        }
        XCTAssert(sut.observers.count == 1)
        sut.removeObservers()
        XCTAssert(sut.observers.isEmpty)
    }
}
