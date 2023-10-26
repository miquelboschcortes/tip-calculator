//
//  tip_calculatorUITests.swift
//  tip-calculatorUITests
//
//  Created by Miguel Bosch Cortés on 24/10/2023.
//

import XCTest

final class tip_calculatorUITests: XCTestCase {

    private var app: XCUIApplication!
    
    private var calculatorScreen: CalculatorScreen {
        CalculatorScreen(app: app)
    }
    
    override func setUp() {
        super.setUp()
        app = .init()
        app.launch()
    }
    
    override func tearDown() {
        super.tearDown()
        app = nil
    }
    
    func testResultViewDefaultValues() {
        XCTAssertEqual(calculatorScreen.amountPerPersonValueLabel.label, "$0")
        XCTAssertEqual(calculatorScreen.totalBillValueLabel.label, "$0")
        XCTAssertEqual(calculatorScreen.totalTipValueLabel.label, "$0")
    }
}
