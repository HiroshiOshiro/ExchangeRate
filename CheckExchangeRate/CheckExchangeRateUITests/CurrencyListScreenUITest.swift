//
//  CurrencyListScreenUITest.swift
//  CheckExchangeRateUITests
//
//  Created by hiroshi on 2020/05/07.
//  Copyright © 2020 hiroshi. All rights reserved.
//

import XCTest
import RealmSwift

@testable import ExcehangeRate

class CurrencyListScreenUITest: XCTestCase {
    let app = XCUIApplication()
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app.launch()
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = self.name
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testCurrencyListScreen() {
        XCTContext.runActivity(named: "Check Search function") {_ in
            app.buttons["Top_fromCurrencyButton"].tap()
            
            waitToAppear(for: app.tables["CurrencyList_table"])
            let table = app.tables.matching(identifier: "CurrencyList_table")
            let searchField = XCUIApplication().otherElements["CurrencyList_seachBar"].searchFields.firstMatch
            XCTAssertNotEqual(table.cells.count, 0)
            
            XCTContext.runActivity(named: "Search by JPY") {_ in
                searchField.tap()
                let searchWord = "JPY"
                searchField.typeText(searchWord)
                
                // check cell count and content
                XCTAssertEqual(table.cells.count, 1)
                let cell = table.cells.element(matching: .cell, identifier: "CurrencyCell_0")
                XCTAssertEqual(cell.staticTexts["CurrencyCell_title"].label, searchWord)
                
                for _ in 0...searchWord.count-1 {
                    app.keys["delete"].tap()
                }
            }
            
            XCTContext.runActivity(named: "Search by Japan") {_ in
                
                searchField.tap()
                let searchWord = "Japan"
                searchField.typeText(searchWord)
                
                // check cell count and content
                XCTAssertEqual(table.cells.count, 1)
                let cell = table.cells.element(matching: .cell, identifier: "CurrencyCell_0")
                XCTAssertEqual(cell.staticTexts["CurrencyCell_title"].label, "JPY")
                
                for _ in 0...searchWord.count-1 {
                    app.keys["delete"].tap()
                }
            }
            
            XCTContext.runActivity(named: "Search by unmatching word") {_ in
                searchField.tap()
                let searchWordNoHit = "XXXXXXXXXXXXXX"
                searchField.typeText(searchWordNoHit)
                
                // check cell count
                XCTAssertEqual(table.cells.count, 0)
            }
            app.swipeDown()
        }
        
        XCTContext.runActivity(named: "Check currency button after select currency") {_ in
            XCTContext.runActivity(named: "Check Top_fromCurrencyButton") {_ in
                app.buttons["Top_fromCurrencyButton"].tap()
                
                waitToAppear(for: app.tables["CurrencyList_table"])
                let table = app.tables.matching(identifier: "CurrencyList_table")
                
                let cell = table.cells.element(matching: .cell, identifier: "CurrencyCell_0")
                print(cell.staticTexts["CurrencyCell_title"].label)
                let selectedCode = cell.staticTexts["CurrencyCell_title"].label
                
                XCTContext.runActivity(named: "Select index[0] cell") {_ in
                    cell.tap()
                    app.swipeDown()
                    waitToAppear(for: app.buttons["Top_fromCurrencyButton"])
                    XCTAssertEqual(app.buttons["Top_fromCurrencyButton"].label, selectedCode)
                }
            }
            
            XCTContext.runActivity(named: "Check Top_toCurrencyButton") {_ in
                app.buttons["Top_toCurrencyButton"].tap()
                
                waitToAppear(for: app.tables["CurrencyList_table"])
                let table = app.tables.matching(identifier: "CurrencyList_table")
                
                let cell = table.cells.element(matching: .cell, identifier: "CurrencyCell_1")
                print(cell.staticTexts["CurrencyCell_title"].label)
                let selectedCode = cell.staticTexts["CurrencyCell_title"].label
                
                XCTContext.runActivity(named: "Select index[0] cell") {_ in
                    cell.tap()
                    app.swipeDown()
                    waitToAppear(for: app.buttons["Top_toCurrencyButton"])
                    XCTAssertEqual(app.buttons["Top_toCurrencyButton"].label, selectedCode)
                }
            }
        }
    }
    
}
