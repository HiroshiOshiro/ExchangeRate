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
    
    @IBOutlet weak var fromCurrencyTextField: UITextField!
    @IBOutlet weak var fromCurrencyButton: UIButton!
    @IBOutlet weak var toCurrencyLabel: UILabel!
    @IBOutlet weak var toCurrencyButton: UIButton!
    @IBOutlet weak var exchangeButton: UIButton!
    
    var presenter: CurrencyListPresentation!
    

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
    }
    
    
}


extension CurrencyListViewController: CurrencyListView {
    func showCurrencyList(currencies: [Currency]) {
        
    }
    
    
}
