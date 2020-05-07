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
    func getCurrencyListFromDB(searchWord: String) {
        let realm = try! Realm()
        var list: [Currency] = []
        if searchWord.isEmpty {
            list = Array(realm.objects(Currency.self).sorted(byKeyPath: "code"))
        } else {
            list = Array(realm.objects(Currency.self).filter("code CONTAINS[c] %@ OR fullname CONTAINS %@", searchWord, searchWord).sorted(byKeyPath: "code"))
        }
        
        output?.gotCurrencyListFromDB(currencies: Array(list))
    }
    
    func saveSelectedItem(currency: Currency, isFromCurrency: Bool) {
        let realm = try! Realm()
        if let userPreferenceData = realm.objects(UserPreferenceData.self).first {
            do {
                try realm.write {
                    if isFromCurrency {
                        userPreferenceData.fromCurrency = currency.code
                    } else {
                        userPreferenceData.toCurrency = currency.code
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}


