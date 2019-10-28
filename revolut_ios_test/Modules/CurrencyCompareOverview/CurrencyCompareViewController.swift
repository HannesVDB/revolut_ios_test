//
//  CurrencyCompareViewController.swift
//  revolut_ios_test
//
//  Created by Hannes Van den Berghe on 23/10/2019.
//  Copyright © 2019 HannesVDB. All rights reserved.
//

import UIKit

class CurrencyCompareViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var addPairContainer: UIView!
    @IBOutlet weak var actionButton: ActionButton!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(class: CurrencyRateCell.self)
        }
    }
    
    // MARK: - Properties
    
    private let viewModel = CurrencyCompareViewModel()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.reloadDataHandler = {
            DispatchQueue.main.async {
                self.redrawView()
            }
        }
        viewModel.registerForUpdates()
    }
    
    // MARK: - Methods
    
    private func redrawView() {
        tableView.isHidden = !viewModel.hasData
        actionButton.isHidden = !viewModel.hasData
        tableView.reloadData()
        actionButton.title = viewModel.addCurrencyTitle
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let navigation = segue.destination as? UINavigationController,
            let controller = navigation.children.first as? CurrenciesViewController {
            viewModel.unregisterForUpdates()
            controller.reloadHandler = {
                self.viewModel.reloadData {
                    self.viewModel.registerForUpdates()
                }
            }
        }
    }
}

extension CurrencyCompareViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.currencyPairs?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyRateCell.reuseIdentifier) as? CurrencyRateCell {
            cell.model = viewModel.currencyPairs?[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        viewModel.delete(at: indexPath.row)
    }
}
