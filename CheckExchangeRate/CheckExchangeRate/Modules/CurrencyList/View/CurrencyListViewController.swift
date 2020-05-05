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
        
    var presenter: CurrencyListPresentation!
    
    var isFromButton: Bool?
    var currencies: [Currency]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
    }
    
    
}


extension CurrencyListViewController: CurrencyListView {
    func showCurrencyList(currencies: [Currency]) {
        self.currencies = currencies
//        table 表示
    }
    
    
}
