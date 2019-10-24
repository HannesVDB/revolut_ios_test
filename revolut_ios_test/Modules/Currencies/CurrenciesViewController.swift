//
//  CurrenciesViewController.swift
//  revolut_ios_test
//
//  Created by Hannes Van den Berghe on 23/10/2019.
//  Copyright © 2019 HannesVDB. All rights reserved.
//

import UIKit

class CurrenciesViewController: UIViewController {
    
    // MARK: - Handlers
    
    var reloadHandler:(() -> Void)?
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(class: CurrencyCell.self)
        }
    }
    
    // MARK: - Properties
    
    private var viewModel = CurrenciesViewModel()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.continueHandler = {
            if self.viewModel.hasCompletedFlow {
                self.reloadHandler?()
                self.dismiss(animated: true, completion: nil)
                return
            }
            let storyboard = UIStoryboard(name: "Currencies", bundle: nil)
            guard let controller = storyboard.instantiateViewController(identifier: "CurrenciesViewController") as? CurrenciesViewController else { return }
            controller.viewModel = self.viewModel
            controller.reloadHandler = {
                self.reloadHandler?()
            }
            self.navigationController?.show(controller, sender: self)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    // MARK: - Methods
    
    // MARK: - IBActions
}

extension CurrenciesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.currencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyCell.reuseIdentifier, for: indexPath) as? CurrencyCell else {
            return UITableViewCell()
        }
        cell.item = viewModel.currencies[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectItem(at: indexPath.row)
    }
}
