//
//  TestTopInteractor.swift
//  CheckExchangeRateTests
//
//  Created by hiroshi on 2020/05/06.
//  Copyright © 2020 hiroshi. All rights reserved.
//

import XCTest
import RealmSwift

@testable import ExcehangeRate

class TestTopInteractor: XCTestCase {

    var interctor: TopInteractor!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        interctor = TopInteractor()
        
        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = self.name
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // Test methods in TopInteractor for saving function
    func testTopInteractorSavingMethods() {        
        XCTContext.runActivity(named: "Check initializing UserPreferenceData") {_ in
            interctor.setDefaultUserPreferenceData()
        
            let realm = try! Realm()
            let userPreferenceData = realm.objects(UserPreferenceData.self)
            XCTAssertEqual(userPreferenceData.count, 1)
            XCTAssertEqual(userPreferenceData.first?.fromCurrency, Define.defaultFromCurrency)
            XCTAssertEqual(userPreferenceData.first?.toCurrency, Define.defaultToCurrency)
        }
        
        XCTContext.runActivity(named: "Check saving UserPreferenceData with initializing") {_ in
            let codeFrom = "TestFrom"
            let codeTo = "TestTo"
            interctor.setDefaultUserPreferenceData()
            interctor.setUserPreferenceData(fromCurrency: codeFrom, toCUrrency: codeTo)
            
            let realm = try! Realm()
            let userPreferenceData = realm.objects(UserPreferenceData.self)
            XCTAssertEqual(userPreferenceData.count, 1)
            XCTAssertEqual(userPreferenceData.first?.fromCurrency, codeFrom)
            XCTAssertEqual(userPreferenceData.first?.toCurrency, codeTo)
        }
        XCTContext.runActivity(named: "[ABNORMAL]Check saving UserPreferenceData without initializing") {_ in
            let codeFrom = "TestFrom"
            let codeTo = "TestTo"
            interctor.setUserPreferenceData(fromCurrency: codeFrom, toCUrrency: codeTo)
            
            let realm = try! Realm()
            let userPreferenceData = realm.objects(UserPreferenceData.self)
            XCTAssertEqual(userPreferenceData.count, 0)
        }
        XCTContext.runActivity(named: "Check saving CurrencyData") {_ in
            let realm = try! Realm()
            let currencyData = realm.objects(CurrencyData.self)
            XCTAssertEqual(currencyData.count, 0)
            
            let json = """
            {
            "success": true,
            "currencies": {
                "AED": "United Arab Emirates Dirham",
                "AFN": "Afghan Afghani"
                }
            }
            """
            
            let data = json.data(using: .utf8)!
            _ = interctor.saveCurrencyData(with: data)
            
            let currencyDataSaved = realm.objects(CurrencyData.self)
            XCTAssertEqual(currencyDataSaved.count, 1)
            let currencis = realm.objects(Currency.self)
            XCTAssertEqual(currencis.count, 2)
        }
        XCTContext.runActivity(named: "Check saving ExchangeRateData") {_ in
            let json = """
            {
            "success": true,
            "timestamp": 1588782907,
            "source": "USD",
            "quotes": {
                "USDAED": 3.673104,
                "USDAFN": 76.2023,
                "USDALL": 114.000375
                }
            }
            """
            
            let data = json.data(using: .utf8)!
            _ = interctor.saveRateData(with: data)
            
            let realm = try! Realm()
            let exchangeRateData = realm.objects(ExchangeRateData.self)
            XCTAssertEqual(exchangeRateData.count, 1)
            let currencis = realm.objects(Rate.self)
            XCTAssertEqual(currencis.count, 3)
        }
    }
    func testDataRefreshing() {
        XCTContext.runActivity(named: "Check 30 min restriction of refreshing CurrencyData") {_ in
            // check initial state
            let realm = try! Realm()
            let currencyData = realm.objects(CurrencyData.self)
            XCTAssertEqual(currencyData.count, 0)
            
            // save mock data
            let json = """
                   {
                   "success": true,
                   "currencies": {
                       "AED": "United Arab Emirates Dirham",
                       "AFN": "Afghan Afghani"
                       }
                   }
                   """
            
            let data = json.data(using: .utf8)!
            _ = interctor.saveCurrencyData(with: data)
            
            var currencyDataSaved = realm.objects(CurrencyData.self).first
            XCTAssertEqual(currencyDataSaved?.currencies.count, 2)
            
            // change savedAt to 29 min ago
            try! realm.write{
                let date = Date()
                currencyDataSaved?.savedAt = Calendar.current.date(byAdding: .minute, value: -29, to: date)!
            }
            print(currencyDataSaved?.savedAt! as Any)
            // check that data will NOT be updated
            interctor.fetchCurrencyListData()
            
            currencyDataSaved = realm.objects(CurrencyData.self).first
            XCTAssertEqual(currencyDataSaved?.currencies.count, 2)
            
            // change savedAt to 30 min ago
            try! realm.write{
                let date = Date()
                currencyDataSaved?.savedAt = Calendar.current.date(byAdding: .minute, value: -31, to: date)!
            }
            print(currencyDataSaved?.savedAt! as Any)
            
            // check that data will be updated
            interctor.fetchCurrencyListData()
            
            // wait for api calling
            sleep(5)
            
            // Check that data was updated
            currencyDataSaved = realm.objects(CurrencyData.self).first
            XCTAssertNotEqual(currencyDataSaved?.currencies.count, 2) // This check should be passed, but can not as of now.
        }
        
        XCTContext.runActivity(named: "Check 30 min restriction of refreshing ExchangeRateData") {_ in
            // check initial state
            let realm = try! Realm()
            let rateData = realm.objects(ExchangeRateData.self)
            XCTAssertEqual(rateData.count, 0)
            
            // save mock data
            let json = """
                   {
                   "success": true,
                   "timestamp": 1588782907,
                   "source": "USD",
                   "quotes": {
                       "USDAED": 3.673104,
                       "USDAFN": 76.2023,
                       "USDALL": 114.000375
                       }
                   }
                   """
            
            let data = json.data(using: .utf8)!
            _ = interctor.saveRateData(with: data)
            
            var rateDataSaved = realm.objects(ExchangeRateData.self).first
            XCTAssertEqual(rateDataSaved?.quotes.count, 3)
            
            // change savedAt to 29 min ago
            try! realm.write{
                let date = Date()
                rateDataSaved?.savedAt = Calendar.current.date(byAdding: .minute, value: -29, to: date)!
            }
            print(rateDataSaved?.savedAt! as Any)
            // check that data will NOT be updated
            interctor.fetchRateData()
            
            rateDataSaved = realm.objects(ExchangeRateData.self).first
            XCTAssertEqual(rateDataSaved?.quotes.count, 3)
            
            // change savedAt to 30 min ago
            try! realm.write{
                let date = Date()
                rateDataSaved?.savedAt = Calendar.current.date(byAdding: .minute, value: -31, to: date)!
            }
            print(rateDataSaved?.savedAt! as Any)
            
            // check that data will be updated
            interctor.fetchRateData()
            
            // wait for api calling
            sleep(5)
            
            // Check that data was updated
            rateDataSaved = realm.objects(ExchangeRateData.self).first
            XCTAssertNotEqual(rateDataSaved?.quotes.count, 3) // This check should be passed, but can not as of now.
        }
    }


    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
