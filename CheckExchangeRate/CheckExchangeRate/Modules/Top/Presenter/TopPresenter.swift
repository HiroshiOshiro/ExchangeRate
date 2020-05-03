//
//  TopPresenter.swift
//  CheckExchangeRate
//
//  Created by hiroshi on 2020/05/02.
//  Copyright © 2020 hiroshi. All rights reserved.
//

import Foundation

class TopPresenter: TopPresentation {

    
    
    weak var view: TopView?
    var interactor: TopUseCase!
    var router: TopWireframe!
    
    var result: Double? {
        didSet {
            view?.showResult(value: result ?? 0.0)
        }
    }
    
    var userPreference: UserPreferenceData? {
        didSet {
            if let userPref = userPreference {
                view?.setCurrency(isFrom: true, title: userPref.lastFromCurrency)
                view?.setCurrency(isFrom: false, title: userPref.lastToCurrency)
            }
        }
    }
    
    func viewDidLoad() {
        result = 0.0
        interactor.getUserPreferenceData()
        interactor.getCurrencyListData()
        interactor.getRateData()
    }
    
    func didTapExcengeButton() {
        interactor.exchangeCurrency()
    }
    
    func didTapCurrencyButton(isFrom: Bool) {
        
    }
}

extension TopPresenter: TopInteractorOutput {
    func gotUserPreferenceData(userPreference: UserPreferenceData) {
        self.userPreference = userPreference
    }
    
    func gotCurrencyListData() {
        interactor.saveCurrencyListData()
    }
    
    func gotRateData() {
        interactor.saveRateData()
    }
    
    func gotCaluculateResult(value: Double) {
        self.result = value
    }
}

