//
//  TopContract.swift
//  CheckExchangeRate
//
//  Created by hiroshi on 2020/05/02.
//  Copyright © 2020 hiroshi. All rights reserved.
//

import UIKit

protocol TopView: class {
    func showIndicator()
    func hideIndicator()
    func setIinitailValue()
    func showCalculationResult(value: Double)
    func setCurrency(isFrom: Bool, title: String)
}

protocol TopPresentation: class {
    var view: TopView? { get set }
    var interactor: TopUseCase! { get set }
    var router: TopWireframe! { get set }
    
    func viewDidLoad()
    func viewWillAppear(fromAmout: Int?)
    func didTapExcengeButton()
    func didTapCurrencyButton(currencyCode: String, isFromButton: Bool)
    func didChangeFromTextField(value: Int)
}

protocol TopUseCase: class {
    func setDefaultUserPreferenceData()
    func getUserPreferenceData()
    func fetchCurrencyListData()
    func saveCurrencyListData()
    func fetchRateData()
    func saveRateData()
    func exchangeCurrency()
    func calcurate(fromAmount: Int)
}

protocol TopInteractorOutput: class {
    func gotUserPreferenceData(userPreference: UserPreferenceData)
    func gotCurrencyList(data: [Currency])
    func gotRateList(data: [Rate])
    func gotCaluculateResult(value: Double)
}

protocol TopWireframe: class {
    var viewController: UIViewController? { get set }
    static func assembleModule() -> UIViewController
    func showCurrencyListScreen(currencyCode: String, isFromButton: Bool)
}
