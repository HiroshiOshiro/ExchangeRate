//
//  CurrencyListInteractor.swift
//  CheckExchangeRate
//
//  Created by hiroshi on 2020/05/02.
//  Copyright © 2020 hiroshi. All rights reserved.
//

import Foundation
import RealmSwift

class CurrencyListInteractor {
    weak var output: CurrencyListInteractorOutput?
}

extension CurrencyListInteractor: CurrencyListUseCase {
    func getCurrencyListFromDB(keyward: String) {
        
        let realm = try! Realm()
    
        var list: [Currency] = []
        if keyward.isEmpty {
            list = Array(realm.objects(Currency.self).sorted(byKeyPath: "code"))
        } else {
            list = Array(realm.objects(Currency.self).filter("code CONTAINS %@ OR fullname CONTAINS %@", keyward, keyward).sorted(byKeyPath: "code"))
        }
        
        output?.gotCurrencyListFromDB(currencies: Array(list))
    }
    
    func searchCurrencyWithKeyward(keyword: String) {
        
    }
    
    
   
}


