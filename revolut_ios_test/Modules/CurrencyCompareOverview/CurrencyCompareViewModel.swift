//
//  CurrencyCompareViewModel.swift
//  revolut_ios_test
//
//  Created by Hannes Van den Berghe on 23/10/2019.
//  Copyright © 2019 HannesVDB. All rights reserved.
//

import UIKit

class CurrencyCompareViewModel {
    
    // MARK: - Translations
    
    let addCurrencyTitle = "Add currency"
    
    // MARK: - Handlers
    
    var reloadDataHandler:(() -> Void)?
    var errorHandler:((_ error: Error?) -> Void)?
    
    // MARK: - Translations
    
    // MARK: - Properties
    
    private(set) var currencyPairs: [CurrencyRateModel]? {
        didSet {
            reloadDataHandler?()
        }
    }
    
    var hasData: Bool {
        guard let pairs = currencyPairs else {
            return false
        }
        return pairs.count != 0
    }
    
    private let database: Persistence
    private let notificationManager: NotificationManaging
    private let service: BackendRequesting
    
    private(set) var timer: Timer?

    // MARK: - Init
    
    init(database: Persistence = Database.shared,
         notificationManager: NotificationManaging = NotificationManager(),
         service: BackendRequesting = Service.shared) {
        self.database = database
        self.notificationManager = notificationManager
        self.service = service
    }
    
    // MARK: - Methods
    
    func reloadData(completion:(() -> Void)? = nil) {
        let currencyPairs = database.currencyPairs ?? []
        service.exchangeRate(for: currencyPairs) { reponse in
            print("😍 Called")
            switch reponse {
            case .success(let response):
                guard let response = response else { return }
                self.currencyPairs = self.database.currencyPairs?.compactMap { CurrencyRateModel(currencyPair: $0, rate: response[$0.key]) }
                DispatchQueue.main.async {
                    completion?()
                }
            case .failure(let error):
                self.errorHandler?(error)
            }
        }
    }
    
    func delete(at row: Int) {
        guard let pair = currencyPairs?[row].currencyPair else { return }
        database.deleteCurrencyPair(pair)
    }
}

extension CurrencyCompareViewModel {
    func registerForUpdates() {
        resetTimer()
        self.reloadData {
            self.startTimer()
        }
        registerForBackgroundNotification {
            print("✋ Resetting timer")
            self.resetTimer()
        }
        registerForForegroundNotification {
            print("🤘 Restarting timer")
            self.startTimer()
        }
    }
    
    func unregisterForUpdates() {
        resetTimer()
        notificationManager.removeObservers()
    }
    
    private func resetTimer() {
        timer?.invalidate()
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { _ in
            self.reloadData()
        })
    }
    
    private func registerForForegroundNotification(_ handler: @escaping (() -> Void)) {
        notificationManager.observeNotification(with: UIApplication.willEnterForegroundNotification) { _ in
            handler()
        }
    }
    
    private func registerForBackgroundNotification(_ handler: @escaping (() -> Void)) {
        notificationManager.observeNotification(with: UIApplication.didEnterBackgroundNotification) { _ in
            handler()
        }
        notificationManager.observeNotification(with: UIApplication.willTerminateNotification) { _ in
            handler()
        }
    }
}

struct CurrencyRateModel {
    var currencyPair: CurrencyPair
    var rate: Double?
}
