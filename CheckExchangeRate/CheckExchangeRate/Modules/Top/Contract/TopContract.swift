//
//  TopContract.swift
//  CheckExchangeRate
//
//  Created by hiroshi on 2020/05/02.
//  Copyright © 2020 hiroshi. All rights reserved.
//

import UIKit

protocol TopView: class {
    func showResult(value: Double)
    func setCurrency(isFrom: Bool, title: String)
//    func exchangeCurrency()
}

protocol TopPresentation: class {
    var view: TopView? { get set }
    var interactor: TopUseCase! { get set }
    var router: TopWireframe! { get set }
    
    func viewDidLoad()
    func didTapExcengeButton()
    func didTapCurrencyButton(isFrom: Bool)
}

protocol TopUseCase: class {
    func setDefaultUserPreferenceData()
    func getUserPreferenceData()
    func getCurrencyListData()
    func saveCurrencyListData()
    func getRateData()
    func saveRateData()
    func exchangeCurrency()
    func calcurate()
}

protocol TopInteractorOutput: class {
    func gotUserPreferenceData(userPreference: UserPreferenceData)
    func gotCurrencyListData()
    func gotRateData()
    func gotCaluculateResult(value: Double)
}

protocol TopWireframe: class {
    var viewController: UIViewController? { get set }
    static func assembleModule() -> UIViewController
    func showCurrencyListScreen()
}
