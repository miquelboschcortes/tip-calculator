//
//  CalculatorScreen.swift
//  tip-calculator
//
//  Created by Miguel Bosch Cortés on 26/10/2023.
//

import XCTest

class CalculatorScreen {
    
    private let app: XCUIApplication
    
    init(app: XCUIApplication) {
        self.app = app
    }
    
    // MARK: - Logo View
    
    var logoView: XCUIElement {
        app.otherElements[ScreenIdentifier.LogoView.logoView.rawValue]
    }
    
    // MARK: - Result View
    
    var amountPerPersonValueLabel: XCUIElement {
        app.staticTexts[ScreenIdentifier.ResultView.totalAmountPerPersonaValueLabel.rawValue]
    }
    
    var totalBillValueLabel: XCUIElement {
        app.staticTexts[ScreenIdentifier.ResultView.totalBillValueLabel.rawValue]
    }
    
    var totalTipValueLabel: XCUIElement {
        app.staticTexts[ScreenIdentifier.ResultView.totalTipValueLabel.rawValue]
    }
    
    // MARK: - Bill Input View
    
    var billInputValueLabel: XCUIElement {
        app.textFields[ScreenIdentifier.BillInputView.textField.rawValue]
    }
    
    // MARK: - Tip Input View
    
    var tenPercentTipButton: XCUIElement {
        app.buttons[ScreenIdentifier.TipInputView.tenPercentButton.rawValue]
    }
    
    var fifteenPercentTipButton: XCUIElement {
        app.staticTexts[ScreenIdentifier.TipInputView.fifteenPercentButton.rawValue]
    }
    
    var twentyPercentTipButton: XCUIElement {
        app.staticTexts[ScreenIdentifier.TipInputView.twentyPercentButton.rawValue]
    }
    
    var customTipButton: XCUIElement {
        app.staticTexts[ScreenIdentifier.TipInputView.customTipButton.rawValue]
    }
    
    var customTipAlertTextField: XCUIElement {
        app.textFields[ScreenIdentifier.TipInputView.customTipAlertTextField.rawValue]
    }
    
    // MARK: - Split Input View
    
    var decrementButton: XCUIElement {
        app.staticTexts[ScreenIdentifier.SplitInputView.decrementButton.rawValue]
    }
    
    var incrementButton: XCUIElement {
        app.staticTexts[ScreenIdentifier.SplitInputView.incrementButton.rawValue]
    }
    
    var quantityValueLabel: XCUIElement {
        app.staticTexts[ScreenIdentifier.SplitInputView.quantityValueLabel.rawValue]
    }
    
    // MARK: - Actions
    
    func enterBill(amount: Double) {
        billInputValueLabel.tap()
        billInputValueLabel.typeText("\(amount)\n")
    }
    
    func selectTip(tip: Tip) {
        switch tip {
        case .tenPercent:
            tenPercentTipButton.tap()
        case .fifteenPercent:
            fifteenPercentTipButton.tap()
        case .twentyPercent:
            twentyPercentTipButton.tap()
        case .custom(let value):
            customTipButton.tap()
            XCTAssertTrue(customTipAlertTextField.waitForExistence(timeout: 1.0))
            customTipAlertTextField.typeText("\(value)\n")
        }
    }
    
    func selectIncrementButton(numberOfTaps: Int) {
        incrementButton.tap(
            withNumberOfTaps: numberOfTaps,
            numberOfTouches: 1
        )
    }
    
    func selectDecrementButton(numberOfTaps: Int) {
        decrementButton.tap(
            withNumberOfTaps: numberOfTaps,
            numberOfTouches: 1
        )
    }
    
    func doubleTapLogoView() {
        logoView.tap(
            withNumberOfTaps: 2,
            numberOfTouches: 1
        )
    }
    
    enum Tip {
        case tenPercent
        case fifteenPercent
        case twentyPercent
        case custom(value: Int)
    }
}
