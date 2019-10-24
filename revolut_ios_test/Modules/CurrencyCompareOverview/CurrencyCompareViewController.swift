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
        }
    }
    
    // MARK: - Properties
    
    private let viewModel = CurrencyCompareViewModel()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        redrawView()
    }
    
    // MARK: - Methods
    
    private func redrawView() {
        tableView.isHidden = !viewModel.hasData
        actionButton.isHidden = !viewModel.hasData
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let navigation = segue.destination as? UINavigationController,
            let controller = navigation.children.first as? CurrenciesViewController {
            controller.reloadHandler = {
                self.redrawView()
            }
        }
    }
    
    // MARK: - IBActions
}

extension CurrencyCompareViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.currencyPairs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = viewModel.currencyPairs[indexPath.row].comparisonCurrency?.abbreviation
        return cell
    }
}
