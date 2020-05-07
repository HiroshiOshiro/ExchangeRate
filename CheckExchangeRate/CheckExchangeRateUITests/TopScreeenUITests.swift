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
        XCTContext.runActivity(named: "Check update of string in Top_toCurrencyLabel by Top_fromTextField") {_ in
            waitToAppear(for: app.staticTexts["Top_toCurrencyLabel"])
            let textField = app.textFields["Top_fromTextField"]
            textField.tap()
            textField.typeText(String(1))
            let result1 = app.staticTexts["Top_toCurrencyLabel"].label
            XCTAssertNotEqual(result1, "0")
            
            XCTContext.runActivity(named: "Top_fromTextFieldに\"2\"入力後のTop_toCurrencyLabelの値を確認") {_ in
                app.keys["Delete"].tap()
                textField.typeText(String(2))
                XCTAssertEqual(Int(Double(app.staticTexts["Top_toCurrencyLabel"].label) ?? 0), Int((Double(result1)!) * 2))
            }
        }
        
        XCTContext.runActivity(named: "Check Initial string in Top_toCurrencyLabel") {_ in
//            waitToAppear(for: app.staticTexts["Top_toCurrencyLabel"])
//            XCTAssertEqual(app.staticTexts["Top_toCurrencyLabel"].label, "0")
//            let realm = try! Realm()
//            _ = realm.objects(UserPreferenceData.self)
            
            let app = XCUIApplication()
            app/*@START_MENU_TOKEN@*/.textFields["Top_fromTextField"]/*[[".textFields[\"Input amount of money.\"]",".textFields[\"Top_fromTextField\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
            
            let key = app/*@START_MENU_TOKEN@*/.keys["2"]/*[[".keyboards.keys[\"2\"]",".keys[\"2\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
            key.tap()
            key.tap()
            app/*@START_MENU_TOKEN@*/.buttons["Top_fromCurrencyButton"]/*[[".buttons[\"AFN\"]",".buttons[\"Top_fromCurrencyButton\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
                        
        }
        
    }
//


}

extension XCTestCase {
    func waitToAppear(for element: XCUIElement,
                      timeout: TimeInterval = 5,
                      file: StaticString = #file,
                      line: UInt = #line) {
        let predicate = NSPredicate(format: "exists == true")
        let expectation = XCTNSPredicateExpectation(predicate: predicate, object: element)
        let result = XCTWaiter().wait(for: [expectation], timeout: timeout)
        XCTAssertEqual(result, .completed, file: file, line: line)
    }

    func waitToHittable(for element: XCUIElement,
                        timeout: TimeInterval = 5,
                        file: StaticString = #file,
                        line: UInt = #line) -> XCUIElement {
        let predicate = NSPredicate(format: "hittable == true")
        let expectation = XCTNSPredicateExpectation(predicate: predicate, object: element)
        let result = XCTWaiter().wait(for: [expectation], timeout: timeout)
        XCTAssertEqual(result, .completed, file: file, line: line)
        return element
    }
}
