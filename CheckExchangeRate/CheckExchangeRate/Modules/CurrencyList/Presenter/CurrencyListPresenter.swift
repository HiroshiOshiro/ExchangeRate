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
        
    }
    
    func didChangeSearchKeyward(keyward: String) {
        
    }
    
    func didSelectCurrency(currency: Currency) {
        
    }
}

extension CurrencyListPresenter: CurrencyListInteractorOutput {
    func searchedCurrency(currencies: [Currency]) {
        
    }
    

}

