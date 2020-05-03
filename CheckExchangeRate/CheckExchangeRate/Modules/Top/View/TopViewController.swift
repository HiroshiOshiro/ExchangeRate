//
//  TopViewController.swift
//  CheckExchangeRate
//
//  Created by hiroshi on 2020/05/02.
//  Copyright © 2020 hiroshi. All rights reserved.
//

import UIKit

class TopViewController: UIViewController {
    
    @IBOutlet weak var fromCurrencyTextField: UITextField!
    @IBOutlet weak var fromCurrencyButton: UIButton!
    @IBOutlet weak var toCurrencyLabel: UILabel!
    @IBOutlet weak var toCurrencyButton: UIButton!
    @IBOutlet weak var exchangeButton: UIButton!
    
    var presenter: TopPresentation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
    }
    
    @IBAction func exchangeButtonTapped(_ sender: Any) {
//        exchangeCurrency()
        presenter.didTapExcengeButton()
    }
}


extension TopViewController: TopView {
    func showResult(value: Double) {
        toCurrencyLabel.text = value.formatWithComma
    }
    
    func setCurrency(isFrom: Bool, title: String) {
        let button: UIButton
        if isFrom {
            button = fromCurrencyButton
        } else {
            button = toCurrencyButton
        }
        
        button.setTitle(title, for: .normal)
    }
    
//    func exchangeCurrency() {
//        let fromTemp = fromCurrencyButton.titleLabel?.text
//        
//        
//        setCurrency(isFrom: true, title: toCurrencyButton.titleLabel?.text ?? "")
//        setCurrency(isFrom: false, title: fromTemp ?? "")
//    }
}
