//
//  TestCurrencyListInteractor.swift
//  CheckExchangeRateTests
//
//  Created by hiroshi on 2020/05/07.
//  Copyright © 2020 hiroshi. All rights reserved.
//

import XCTest
import RealmSwift

@testable import ExcehangeRate

class TestCurrencyListInteractor: XCTestCase {

    var interctor: CurrencyListInteractor!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        interctor = CurrencyListInteractor()
        
        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = self.name
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // Test methods in TopInteractor for saving function
    func testTopInteractorSavingMethods() {
        XCTContext.runActivity(named: "Check saving Currency for From button") {_ in
            let topInteractor = TopInteractor()
            topInteractor.setDefaultUserPreferenceData()
            
            let currencyCode = "XXX"
            let currency = Currency()
            currency.code = currencyCode
            currency.fullname = "fullname of XXX "
            interctor.saveSelectedItem(currency: currency, isFromCurrency: true)
        
            let realm = try! Realm()
            let userPreferenceData = realm.objects(UserPreferenceData.self)
            XCTAssertEqual(userPreferenceData.count, 1)
            XCTAssertEqual(userPreferenceData.first?.fromCurrency, currencyCode)
            XCTAssertEqual(userPreferenceData.first?.toCurrency, Define.defaultToCurrency)
        }
        XCTContext.runActivity(named: "Check saving Currency for To button") {_ in
            let topInteractor = TopInteractor()
            topInteractor.setDefaultUserPreferenceData()
            
            let currencyCode = "XXX"
            let currency = Currency()
            currency.code = currencyCode
            currency.fullname = "fullname of XXX "
            interctor.saveSelectedItem(currency: currency, isFromCurrency: false)
        
            let realm = try! Realm()
            let userPreferenceData = realm.objects(UserPreferenceData.self)
            XCTAssertEqual(userPreferenceData.count, 1)
            XCTAssertEqual(userPreferenceData.first?.fromCurrency, Define.defaultFromCurrency)
            XCTAssertEqual(userPreferenceData.first?.toCurrency, currencyCode)
        }
    }
}
