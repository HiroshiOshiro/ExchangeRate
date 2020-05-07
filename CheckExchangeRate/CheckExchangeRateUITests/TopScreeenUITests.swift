//
//  TopScreeenUITests.swift
//  CheckExchangeRateUITests
//
//  Created by hiroshi on 2020/05/06.
//  Copyright © 2020 hiroshi. All rights reserved.
//

import XCTest
import RealmSwift

@testable import ExcehangeRate

class TopScreeenUITests: XCTestCase {
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

    func testTopScreen() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTContext.runActivity(named: "Check Initial string in Top_fromTextField") {_ in
            waitToAppear(for: app.textFields["Top_fromTextField"])
            XCTAssertEqual(app.textFields["Top_fromTextField"].title, "")
        }
        XCTContext.runActivity(named: "Check Initial string in Top_toCurrencyLabel") {_ in
            waitToAppear(for: app.staticTexts["Top_toCurrencyLabel"])
            XCTAssertEqual(app.staticTexts["Top_toCurrencyLabel"].label, "0")
        }
        XCTContext.runActivity(named: "Check Initial string in Top_toCurrencyLabel") {_ in
            waitToAppear(for: app.buttons["Top_fromCurrencyButton"])
            XCTAssertEqual(app.buttons["Top_fromCurrencyButton"].label, "USD")
        }
        XCTContext.runActivity(named: "Check Initial string in Top_toCurrencyLabel") {_ in
            waitToAppear(for: app.buttons["Top_toCurrencyButton"])
            XCTAssertEqual(app.buttons["Top_toCurrencyButton"].label, "JPY")
        }
        XCTContext.runActivity(named: "Check update of string in Top_toCurrencyLabel by Top_fromTextField") {_ in
            waitToAppear(for: app.staticTexts["Top_toCurrencyLabel"])
            let textField = app.textFields["Top_fromTextField"]
            textField.tap()
            textField.typeText(String(1))
            let result1 = app.staticTexts["Top_toCurrencyLabel"].label
            XCTAssertNotEqual(result1, "0")
            
            XCTContext.runActivity(named: "Input \"2\" to Top_fromTextField") {_ in
                app.keys["Delete"].tap()
                textField.typeText(String(2))
                XCTAssertEqual(Int(Double(app.staticTexts["Top_toCurrencyLabel"].label) ?? 0), Int((Double(result1)!) * 2))
            }
        }
    }
}

