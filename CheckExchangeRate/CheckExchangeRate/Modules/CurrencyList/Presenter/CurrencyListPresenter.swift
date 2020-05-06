//
//  CurrencyListPresenter.swift
//  CheckExchangeRate
//
//  Created by hiroshi on 2020/05/02.
//  Copyright © 2020 hiroshi. All rights reserved.
//

import Foundation
//import PromiseKit

class CurrencyListPresenter: CurrencyListPresentation {
    weak var view: CurrencyListView?
    var interactor: CurrencyListUseCase!
    var router: CurrencyListWireframe!
        
    func viewDidLoad() {
        interactor.getCurrencyListFromDB(keyward: "")
    }
    
    func didChangeSearchKeyward(keyward: String) {
        
    }
    
    func didSelectCurrency(currency: Currency, isFromCurrency: Bool) {
        interactor.saveSelectedItem(currency: currency, isFromCurrency: isFromCurrency)
    }
    
    func viewWillDisappear() {
//        interactor.saveSelectedItem(currency: Currency, isFromCurrency: true)
    }
}

extension CurrencyListPresenter: CurrencyListInteractorOutput {
    func gotCurrencyListFromDB(currencies: [Currency]) {
        self.view?.showCurrencyList(currencies: currencies)
    }
    
//    func searchedCurrency(currencies: [Currency]) {
//
//        self.view?.showCurrencyList(currencies: currencies)
//    }
    

}

