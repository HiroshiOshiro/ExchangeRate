//
//  CurrencyListViewController.swift
//  CheckExchangeRate
//
//  Created by hiroshi on 2020/05/02.
//  Copyright © 2020 hiroshi. All rights reserved.
//

import UIKit
import PKHUD

class CurrencyListViewController: UIViewController {
    
    @IBOutlet weak var currencyTableView: UITableView!
    
    var presenter: CurrencyListPresentation!
    
    var isFromButton: Bool?
    var currencies: [Currency]?
    var selectedCurrency: Currency?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupScreen()
        presenter.viewDidLoad()
    }
    
    private func setupScreen() {
        currencyTableView.delegate = self
        currencyTableView.dataSource = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        presenter.viewWillDisappear()
    }
    
}

extension CurrencyListViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencies?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.currencyCell, for: indexPath) else {
            return UITableViewCell()
        }
        
        
        cell.textLabel?.text = currencies?[indexPath.row].code
        cell.detailTextLabel?.text = currencies?[indexPath.row].fullname
//        if currencies?[indexPath.row].code == self.selectedCurrency?.code ?? "" {
        if currencies?[indexPath.row].code == "GEL" {
            cell.accessoryType = .checkmark
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            if let selectedItem = currencies?[indexPath.row] {
                self.selectedCurrency = selectedItem
            }
            cell.accessoryType = .checkmark
            cell.isSelected = false
        }
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .none
            cell.isSelected = false
        }
    }
}

extension CurrencyListViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
         self.view.endEditing(true)
    }
}

extension CurrencyListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter.didChangeSearchKeyward(keyward: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
        presenter.didChangeSearchKeyward(keyward: searchBar.text ?? "")
    }
}


extension CurrencyListViewController: CurrencyListView {
    func showCurrencyList(currencies: [Currency]) {
        self.currencies = currencies
        currencyTableView.reloadData()
    }
}
