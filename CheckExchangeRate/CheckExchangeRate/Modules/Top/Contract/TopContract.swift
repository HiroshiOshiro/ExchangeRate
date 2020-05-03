//
//  TopContract.swift
//  CheckExchangeRate
//
//  Created by hiroshi on 2020/05/02.
//  Copyright © 2020 hiroshi. All rights reserved.
//

import UIKit

protocol TopView: class {
    func showResult()
    func setCurrency()
    func exchangeCurrency()
}

protocol TopPresentation: class {
    var view: TopView? { get set }
    var interactor: TopUseCase! { get set }
    var router: TopWireframe! { get set }
    
    func viewDidLoad()
}

protocol TopUseCase: class {
    func getCurrencyListData()
    func saveCurrencyListData()
    func getRateData()
    func saveRateData()
    func calcurate()
}

protocol TopInteractorOutput: class {
    func gotCurrencyListData()
    func gotRateData()
    func gotCaluculateResult()
}

protocol TopWireframe: class {
    var viewController: UIViewController? { get set }
    static func assembleModule() -> UIViewController
    func showCurrencyListScreen()
}
