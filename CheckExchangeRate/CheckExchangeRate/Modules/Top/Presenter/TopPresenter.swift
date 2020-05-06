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
        
    func viewDidLoad() {
        interactor.getUserPreferenceData()
        
        // Get data from APIs
        fetchCurrencyListDataFromAPI()
        fetchRateDataFromAPI()
    }
    
    func viewWillAppear(fromAmout: Int?) {
        interactor.getUserPreferenceData()
        
        // do calucutation when value is existeing (when return from CurrencyList screen)
        if let amount = fromAmout {
            interactor.calcurate(fromAmount: amount)
        }
    }
    
    func didTapExcengeButton() {
        interactor.exchangeCurrency()
    }
    
    func didTapCurrencyButton(currencyCode: String, isFromButton: Bool) {
        router.showCurrencyListScreen(currencyCode: currencyCode, isFromButton: isFromButton)
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
        self.view?.setCurrency(isFrom: true, title: userPreference.fromCurrency)
        self.view?.setCurrency(isFrom: false, title: userPreference.toCurrency)
    }
    
    func gotCurrencyList(data: [Currency]) {
        DispatchQueue.main.async {
            self.view?.hideIndicator()
        }
    }
    
    func gotRateList(data: [Rate]) {
        DispatchQueue.main.async {
            self.view?.hideIndicator()
        }
    }
    
    func gotCaluculateResult(value: Double) {
        self.view?.showCalculationResult(value: value)
    }
}

