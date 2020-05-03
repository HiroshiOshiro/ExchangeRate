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
        userPreference.lastFromCurrency = Define.defaultFromCurrency
        userPreference.lastToCurrency = Define.defaultToCurrency
        try! realm.write {
            realm.add(userPreference)
        }
    }
    
    func setUserPreferenceData(fromCurrency: String?, toCUrrency: String?) {
        let realm = try! Realm()
        let userPreference = realm.objects(UserPreferenceData.self)
        try! realm.write {
            if let fromCurrency = fromCurrency {
                userPreference[0].lastFromCurrency = fromCurrency
            }
            if let toCUrrency = toCUrrency {
                userPreference[0].lastToCurrency = toCUrrency
            }
        }
    }
    
    func getUserPreferenceData() {
        let realm = try! Realm()
        let userPreference = realm.objects(UserPreferenceData.self)
        
        if userPreference.isEmpty {
            setDefaultUserPreferenceData()
        }
        
        output?.gotUserPreferenceData(userPreference: userPreference[0])
    }
    
    func getCurrencyListData() {
        guard let url = URL(string: Define.getCurrencyListAPIPath) else {
            return
        }
        
        let task: URLSessionTask  = URLSession.shared.dataTask(with: url, completionHandler: {data, response, error in
            guard let data = data else {
                return
            }
            do {
                let currencyListResponse = try JSONDecoder().decode(CurrencyListResponse.self, from: data)
//                print(currencyListResponse.self)
                
                var currencies: [Currency] = []
                for currencyDic in currencyListResponse.currencies {
                    let currency = Currency()
                    currency.code = currencyDic.key
                    currency.fullname = currencyDic.value
                    currencies.append(currency)
                }
                
                let realm = try Realm()
                try realm.write {
                    realm.delete(realm.objects(Currency.self))
                    realm.add(currencies)
                }
//                print(Realm.Configuration.defaultConfiguration.fileURL!)
            } catch {
                print(error.localizedDescription)
            }
        })
        task.resume()
    }
    
    func saveCurrencyListData() {
        
    }
    
    func getRateData() {
        guard let url = URL(string: Define.getRateAPIPath) else {
            return
        }
        
//        let realm = try! Realm()
//        let exchangeRate = realm.objects(ExchangeRate.self)
//        if !exchangeRate.isEmpty && exchangeRate[0].timestamp < Date.init(timeIntervalSince1970: 0)
        
        let task: URLSessionTask  = URLSession.shared.dataTask(with: url, completionHandler: {data, response, error in
            guard let data = data else {
                return
            }
            do {
                let response = try JSONDecoder().decode(RateListResponse.self, from: data)
                print(response.self)
                
                let rateList = List<Rate>()
                for rateDic in response.quotes {
                    let rate = Rate()
                    rate.code = rateDic.key
                    rate.rate = rateDic.value
                    rateList.append(rate)
                }
                
                let exchangeRate = ExchangeRate()
                exchangeRate.timestamp = response.timestamp
                exchangeRate.source = response.source
                exchangeRate.quotes = rateList
                
                let realm = try Realm()
                try realm.write {
                    realm.delete(realm.objects(ExchangeRate.self))
                    realm.delete(realm.objects(Rate.self))
                    realm.add(exchangeRate)
                }
                                print(Realm.Configuration.defaultConfiguration.fileURL!)
            } catch {
                print(error.localizedDescription)
            }
        })
        task.resume()
    }
    
    func saveRateData() {
    
    }
    
    func exchangeCurrency() {
        let realm = try! Realm()
        let userPreference = realm.objects(UserPreferenceData.self)
        
        setUserPreferenceData(fromCurrency: userPreference[0].lastToCurrency, toCUrrency: userPreference[0].lastFromCurrency)
        getUserPreferenceData()
    }
    
    func calcurate() {
    
    }
    

    
    
}


