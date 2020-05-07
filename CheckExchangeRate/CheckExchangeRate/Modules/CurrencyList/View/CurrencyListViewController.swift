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
    @IBOutlet weak var currencySearchBar: UISearchBar!
    
    var presenter: CurrencyListPresentation!
    
    var isFromButton: Bool?
    var currencies: [Currency]?
    var selectedCurrencyCode: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupScreen()
        presenter.viewDidLoad()
    }
    
    private func setupScreen() {
        currencyTableView.delegate = self
        currencyTableView.dataSource = self
        currencySearchBar.delegate = self
        
        // set accessibilityIdentifier for UI Test
        currencyTableView.accessibilityIdentifier = "CurrencyList_table"
        currencySearchBar.accessibilityIdentifier = "CurrencyList_seachBar"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // call viewWillAppear in parent screen
        presentingViewController?.beginAppearanceTransition(true, animated: animated)
        presentingViewController?.endAppearanceTransition()
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
        if currencies?[indexPath.row].code == self.selectedCurrencyCode ?? "" {
            cell.accessoryType = .checkmark
            tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
        } else {
            cell.accessoryType = .none
        }
        
        // set accessibilityIdentifier for UI Test
        cell.accessibilityIdentifier = "CurrencyCell_\(indexPath.row)"
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            
            if let selectedItem = currencies?[indexPath.row] {
                self.selectedCurrencyCode = selectedItem.code
                self.presenter.didSelectCurrency(currency: selectedItem, isFromCurrency: self.isFromButton ?? true)
            }
            cell.accessoryType = .checkmark
        }
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .none
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
        presenter.didChangeSearchWord(searchWord: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
        presenter.didChangeSearchWord(searchWord: searchBar.text ?? "")
    }
}

extension CurrencyListViewController: CurrencyListView {
    func showCurrencyList(currencies: [Currency]) {
        self.currencies = currencies
        currencyTableView.reloadData()
    }
}
