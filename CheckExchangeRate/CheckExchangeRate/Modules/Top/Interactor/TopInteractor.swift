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
        
    }
    
    func saveCurrencyListData() {
        
    }
    
    func getRateData() {
    
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


