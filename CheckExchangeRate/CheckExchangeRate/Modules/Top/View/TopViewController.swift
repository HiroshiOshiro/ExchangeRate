//
//  TopViewController.swift
//  CheckExchangeRate
//
//  Created by hiroshi on 2020/05/02.
//  Copyright © 2020 hiroshi. All rights reserved.
//

import UIKit
import PKHUD

class TopViewController: UIViewController {
    
    @IBOutlet weak var fromCurrencyTextField: UITextField!
    @IBOutlet weak var fromCurrencyButton: UIButton!
    @IBOutlet weak var toCurrencyLabel: UILabel!
    @IBOutlet weak var toCurrencyButton: UIButton!
    @IBOutlet weak var exchangeButton: UIButton!
    
    var presenter: TopPresentation!
    
//    var result: Double = 0.0 {
//        didSet {
//            showCalculationResult(value: result)
//        }
//    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setIinitailValue()
        presenter.viewDidLoad()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func didFromCurrencyTextFieldChanged(_ sender: Any) {
        presenter.didChangeFromTextField(value: Int(fromCurrencyTextField.text ?? "") ?? 0)
    }
    
    @IBAction func exchangeButtonTapped(_ sender: Any) {
        setIinitailValue()
        presenter.didTapExcengeButton()
    }
}


extension TopViewController: TopView {
    func showIndicator() {
        PKHUD.sharedHUD.contentView = PKHUDProgressView(title: "Fetching Data...", subtitle: nil)
        PKHUD.sharedHUD.show(onView: self.view)
    }
    
    func hideIndicator() {
        PKHUD.sharedHUD.hide()
    }
    
    func setIinitailValue() {
        fromCurrencyTextField.text = ""
        toCurrencyLabel.text = String(0)
    }
    
    func showCalculationResult(value: Double) {
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
