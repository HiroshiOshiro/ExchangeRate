//
//  TopInteractor.swift
//  CheckExchangeRate
//
//  Created by hiroshi on 2020/05/02.
//  Copyright © 2020 hiroshi. All rights reserved.
//

import Foundation
import RealmSwift

class TopInteractor {
    weak var output: TopInteractorOutput?
}

extension TopInteractor: TopUseCase {
    
    
    func setDefaultUserPreferenceData() {
        let realm = try! Realm()
        let userPreference = UserPreferenceData()
        userPreference.fromCurrency = Define.defaultFromCurrency
        userPreference.toCurrency = Define.defaultToCurrency
        try! realm.write {
            realm.delete(realm.objects(UserPreferenceData.self))
            realm.add(userPreference)
        }
    }
    
    func setUserPreferenceData(fromCurrency: String?, toCUrrency: String?) {
        let realm = try! Realm()
        let userPreference = realm.objects(UserPreferenceData.self).first
        try! realm.write {
            if let fromCurrency = fromCurrency {
                userPreference?.fromCurrency = fromCurrency
            }
            if let toCUrrency = toCUrrency {
                userPreference?.toCurrency = toCUrrency
            }
        }
    }
    
    func getUserPreferenceData() {
        let realm = try! Realm()
        let userPreference = realm.objects(UserPreferenceData.self).first
        
        if let userPreference = userPreference {
            self.output?.gotUserPreferenceData(userPreference: userPreference)
        }
    }
    
    func fetchCurrencyListData() {
        let realm = try! Realm()
        if let currencyData = realm.objects(CurrencyData.self).first,
            let savedAt = currencyData.savedAt {
            if Date().timeIntervalSince(savedAt) < 60 * 30 {
                // return existing data from DB
                self.output?.gotCurrencyList(data: Array(currencyData.currencies))
                return
            }
        }
        
        guard let url = URL(string: Define.getCurrencyListAPIPath) else {
            return
        }
        
        let task: URLSessionTask  = URLSession.shared.dataTask(with: url, completionHandler: {data, response, error in
            guard let data = data else {
                return
            }
            let currencyData = self.saveCurrencyData(with: data)
            self.output?.gotCurrencyList(data: Array(currencyData.currencies))
            
        })
        task.resume()
    }
    
    func saveCurrencyData(with data: Data) -> CurrencyData {
        let currencyData = CurrencyData()
        
        let currencyListResponse = try! JSONDecoder().decode(CurrencyListResponse.self, from: data)
        
        let currencies = List<Currency>()
        for currencyDic in currencyListResponse.currencies {
            let currency = Currency()
            currency.code = currencyDic.key
            currency.fullname = currencyDic.value
            currencies.append(currency)
        }
        currencyData.currencies = currencies
        currencyData.savedAt = Date()
        
        let realm = try! Realm()
        try! realm.write {
            realm.delete(realm.objects(Currency.self))
            realm.add(currencyData)
        }
        
        return currencyData
    }
    
    func fetchRateData() {
        let realm = try! Realm()
        if let exchangeRateData = realm.objects(ExchangeRateData.self).first,
            let savedAt = exchangeRateData.savedAt {
            if Date().timeIntervalSince(savedAt) < 60 * 30 {
                // return existing data from DB
                self.output?.gotRateList(data: Array(exchangeRateData.quotes))
                return
            }
        }
        
        guard let url = URL(string: Define.getRateAPIPath) else {
            return
        }
        
        let task: URLSessionTask  = URLSession.shared.dataTask(with: url, completionHandler: {data, response, error in
            guard let data = data else {
                return
            }
            let exchangeRateData = self.saveRateData(with: data)
            self.output?.gotRateList(data: Array(exchangeRateData.quotes))
        })
        task.resume()
    }
    
    func saveRateData(with data: Data) -> ExchangeRateData {
        let exchangeRateData = ExchangeRateData()
        
        let rateListResponse = try! JSONDecoder().decode(RateListResponse.self, from: data)
        
        let rateList = List<Rate>()
        for rateDic in rateListResponse.quotes {
            let rate = Rate()
            rate.code = rateDic.key
            rate.rate = rateDic.value
            rateList.append(rate)
        }
        
        let exchangeRate = ExchangeRateData()
        exchangeRate.timestamp = rateListResponse.timestamp
        exchangeRate.source = rateListResponse.source
        exchangeRate.quotes = rateList
        exchangeRate.savedAt = Date()
        
        let realm = try! Realm()
        try! realm.write {
            realm.delete(realm.objects(ExchangeRateData.self))
            realm.delete(realm.objects(Rate.self))
            realm.add(exchangeRate)
        }
        
        return exchangeRateData
    }
    
    func exchangeCurrency() {
        let realm = try! Realm()
        let userPreference = realm.objects(UserPreferenceData.self).first
        
        if let userPreference = userPreference {
            setUserPreferenceData(fromCurrency: userPreference.toCurrency, toCUrrency: userPreference.fromCurrency)
            getUserPreferenceData()
        }
    }
    
    func calcurate(fromAmount: Int) {
        let realm = try! Realm()
        guard let userPreference = realm.objects(UserPreferenceData.self).first,
            let source = realm.objects(ExchangeRateData.self).first?.source else {
            // error: Required paramenters are missing
            return
        }
        
        let fromCurrency = userPreference.fromCurrency
        let toCurrency = userPreference.toCurrency
        
        let rateFrom = realm.objects(Rate.self).filter("code == %@", source + fromCurrency)
        let rateTo = realm.objects(Rate.self).filter("code == %@", source + toCurrency)
        
        if let rateFromValue = rateFrom.first?.rate,
            let rateToValue = rateTo.first?.rate {
            
            let result = Double(fromAmount) / rateFromValue * rateToValue
            self.output?.gotCaluculateResult(value: result)
        } else {
            // error: rates to calulation were not found
            self.output?.gotCaluculateResult(value: 0.0)
        }
    }
}


