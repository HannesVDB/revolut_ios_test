//
//  NotificationManager.swift
//  revolut_ios_test
//
//  Created by Hannes Van den Berghe on 25/10/2019.
//  Copyright © 2019 HannesVDB. All rights reserved.
//

import Foundation

protocol NotificationManaging {
    func observeNotification(with name: NSNotification.Name, block: (@escaping(Notification) -> Void))
    func publish(with name: NSNotification.Name, value: Any?)
    func removeObservers()
}

class NotificationManager: NotificationManaging {
    
    // MARK: - Properties
    
    private(set) var observers = [AnyObject]()
    
    // MARK: - Init
    
    deinit {
        removeObservers()
    }
    
    // MARK: - Register
    
    func observeNotification(with name: NSNotification.Name, block: (@escaping(Notification) -> Void)) {
        let observer = NotificationCenter.default.addObserver(forName: name, object: nil, queue: OperationQueue.main, using: block)
        observers.append(observer)
    }
    
    // MARK: - Publish
    
    func publish(with name: NSNotification.Name, value: Any? = nil) {
        NotificationCenter.default.post(name: name, object: value)
    }
    
    func removeObservers() {
        observers.forEach { NotificationCenter.default.removeObserver($0) }
        observers = []
    }
}
