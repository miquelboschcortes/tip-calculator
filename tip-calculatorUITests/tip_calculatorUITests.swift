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
    
    func testRegularTip() {
        
        // User enters a $100 bill
        calculatorScreen.enterBill(amount: 100)
        XCTAssertEqual(calculatorScreen.amountPerPersonValueLabel.label, "$100")
        XCTAssertEqual(calculatorScreen.totalBillValueLabel.label, "$100")
        XCTAssertEqual(calculatorScreen.totalTipValueLabel.label, "$0")
        
        // User selects 10% Tip
        calculatorScreen.selectTip(tip: .tenPercent)
        XCTAssertEqual(calculatorScreen.amountPerPersonValueLabel.label, "$110")
        XCTAssertEqual(calculatorScreen.totalBillValueLabel.label, "$110")
        XCTAssertEqual(calculatorScreen.totalTipValueLabel.label, "$10")
        
        // User selects 15% Tip
        calculatorScreen.selectTip(tip: .fifteenPercent)
        XCTAssertEqual(calculatorScreen.amountPerPersonValueLabel.label, "$115")
        XCTAssertEqual(calculatorScreen.totalBillValueLabel.label, "$115")
        XCTAssertEqual(calculatorScreen.totalTipValueLabel.label, "$15")

        // User selects 20% Tip
        calculatorScreen.selectTip(tip: .twentyPercent)
        XCTAssertEqual(calculatorScreen.amountPerPersonValueLabel.label, "$120")
        XCTAssertEqual(calculatorScreen.totalBillValueLabel.label, "$120")
        XCTAssertEqual(calculatorScreen.totalTipValueLabel.label, "$20")

        // User splits the bill by 4
        calculatorScreen.selectIncrementButton(numberOfTaps: 3)
        XCTAssertEqual(calculatorScreen.amountPerPersonValueLabel.label, "$30")
        XCTAssertEqual(calculatorScreen.totalBillValueLabel.label, "$120")
        XCTAssertEqual(calculatorScreen.totalTipValueLabel.label, "$20")

        // User splits the bill by 2
        calculatorScreen.selectDecrementButton(numberOfTaps: 2)
        XCTAssertEqual(calculatorScreen.amountPerPersonValueLabel.label, "$60")
        XCTAssertEqual(calculatorScreen.totalBillValueLabel.label, "$120")
        XCTAssertEqual(calculatorScreen.totalTipValueLabel.label, "$20")
        
    }
    
    func testCustomTipAndSplitBillBy2() {
        calculatorScreen.enterBill(amount: 300)
        calculatorScreen.selectTip(tip: .custom(value: 200))
        calculatorScreen.selectIncrementButton(numberOfTaps: 1)
        XCTAssertEqual(calculatorScreen.amountPerPersonValueLabel.label, "$250")
        XCTAssertEqual(calculatorScreen.totalBillValueLabel.label, "$500")
        XCTAssertEqual(calculatorScreen.totalTipValueLabel.label, "$200")
    }
    
    func testResetButton() {
        calculatorScreen.enterBill(amount: 400)
        calculatorScreen.selectTip(tip: .twentyPercent)
        calculatorScreen.selectIncrementButton(numberOfTaps: 1)
        calculatorScreen.doubleTapLogoView()
        XCTAssertEqual(calculatorScreen.amountPerPersonValueLabel.label, "$0")
        XCTAssertEqual(calculatorScreen.totalBillValueLabel.label, "$0")
        XCTAssertEqual(calculatorScreen.totalTipValueLabel.label, "$0")
        XCTAssertEqual(calculatorScreen.billInputValueLabel.label, "")
        XCTAssertEqual(calculatorScreen.customTipButton.label, "Custom tip")
        XCTAssertEqual(calculatorScreen.quantityValueLabel.label, "1")
    }
    
}
