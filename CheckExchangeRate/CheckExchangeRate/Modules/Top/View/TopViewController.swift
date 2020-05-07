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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setIinitailValue()
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter.viewWillAppear(fromAmout: Int(fromCurrencyTextField.text ?? ""))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func whenFromCurrencyTextFieldChanged(_ sender: Any) {
        presenter.didChangeFromTextField(inputValue: Int(fromCurrencyTextField.text ?? "") ?? 0)
    }
    
    @IBAction func fromCurrencyButtonTapped(_ sender: UIButton) {
        presenter.didTapCurrencyButton(currencyCode: sender.titleLabel?.text ?? "", isFromButton: true)
    }
    
    @IBAction func toCurrencyButtonTapped(_ sender: UIButton) {
        presenter.didTapCurrencyButton(currencyCode: sender.titleLabel?.text ?? "", isFromButton: false)
    }
    
    @IBAction func exchangeButtonTapped(_ sender: UIButton) {
        setIinitailValue()
        presenter.didTapExcengeButton()
    }
}


extension TopViewController: TopView {
    func showIndicator() {
        PKHUD.sharedHUD.contentView = PKHUDProgressView(title: R.string.localizable.lodingText(), subtitle: nil)
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
    
    func setCurrencyTitle(title: String, isFromButton: Bool) {
        let button: UIButton
        if isFromButton {
            button = fromCurrencyButton
        } else {
            button = toCurrencyButton
        }
        
        button.setTitle(title, for: .normal)
    }
}
