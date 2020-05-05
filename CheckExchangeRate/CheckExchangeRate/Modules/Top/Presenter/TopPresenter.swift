//
//  TopPresenter.swift
//  CheckExchangeRate
//
//  Created by hiroshi on 2020/05/02.
//  Copyright © 2020 hiroshi. All rights reserved.
//

import Foundation
//import PromiseKit

class TopPresenter: TopPresentation {

    weak var view: TopView?
    var interactor: TopUseCase!
    var router: TopWireframe!
        
    var result: Double = 0.0 {
        didSet {
            view?.showCalculationResult(value: result)
        }
    }
    
    var userPreference: UserPreferenceData? {
        didSet {
            if let userPref = userPreference {
                view?.setCurrency(isFrom: true, title: userPref.fromCurrency)
                view?.setCurrency(isFrom: false, title: userPref.toCurrency)
            }
        }
    }
    
    func viewDidLoad() {
//        view?.showIndicator()
        interactor.getUserPreferenceData()
        fetchCurrencyListDataFromAPI()
        fetchRateDataFromAPI()
    }
    
//    func setInitialValue() {
//        view?.setIinitailValue()
//    }
    

    
    func didTapExcengeButton() {
        interactor.exchangeCurrency()
    }
    
    func didTapCurrencyButton(isFrom: Bool) {
        
    }
    
    func didChangeFromTextField(value: Int) {
        interactor.calcurate(fromAmount: value)
    }
    
    // MARK: Private Method
    private func fetchCurrencyListDataFromAPI() {
        view?.showIndicator()
        interactor.fetchCurrencyListData()
    }
    
    private func fetchRateDataFromAPI() {
        view?.showIndicator()
        interactor.fetchRateData()
    }
}

extension TopPresenter: TopInteractorOutput {
    func gotUserPreferenceData(userPreference: UserPreferenceData) {
        self.userPreference = userPreference
    }
    
    func gotCurrencyList(data: [Currency]) {
        DispatchQueue.main.async {
            self.view?.hideIndicator()
        }
//        interactor.saveCurrencyListData()
    }
    
    func gotRateList(data: [Rate]) {
        
        DispatchQueue.main.async {
            self.view?.hideIndicator()
        }
//        interactor.saveRateData()
    }
    
    func gotCaluculateResult(value: Double) {
        self.result = value
    }
}

