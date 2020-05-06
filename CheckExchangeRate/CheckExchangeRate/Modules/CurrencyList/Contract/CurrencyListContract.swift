//
//  CurrencyListContract.swift
//  CheckExchangeRate
//
//  Created by hiroshi on 2020/05/02.
//  Copyright © 2020 hiroshi. All rights reserved.
//

import UIKit

protocol CurrencyListView: class {
    func showCurrencyList(currencies: [Currency])
}

protocol CurrencyListPresentation: class {
    var view: CurrencyListView? { get set }
    var interactor: CurrencyListUseCase! { get set }
    var router: CurrencyListWireframe! { get set }
    
    func viewDidLoad()
    func didChangeSearchWord(searchWord: String)
    func didSelectCurrency(currency: Currency, isFromCurrency: Bool)
}

protocol CurrencyListUseCase: class {
    func getCurrencyListFromDB(searchWord: String)
    func saveSelectedItem(currency: Currency, isFromCurrency: Bool)
}

protocol CurrencyListInteractorOutput: class {
    func gotCurrencyListFromDB(currencies: [Currency])
}

protocol CurrencyListWireframe: class {
    var viewController: UIViewController? { get set }
    static func assembleModule() -> UIViewController
}
