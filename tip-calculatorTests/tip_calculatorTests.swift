//
//  tip_calculatorTests.swift
//  tip-calculatorTests
//
//  Created by Miguel Bosch Cortés on 24/10/2023.
//

import XCTest
import Combine
@testable import tip_calculator

final class tip_calculatorTests: XCTestCase {
    
    // sut -> system under test
    private var sut: CalculatorViewModel!
    private var cancellable: Set<AnyCancellable>!
    
    private let logoViewTapSubject = PassthroughSubject<Void, Never>()

    override func setUp() {
        sut = .init()
        cancellable = .init()
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        cancellable = nil
    }
    
    func testResultWithoutTipFor1Person() {
        // given
        let bill: Double = 100
        let tip: Tip = .none
        let split: Int = 1
        
        let input = buildInput(bill: bill, tip: tip, split: split)
        
        // when
        let output = sut.transform(input: input)
        
        // then
        output.updateViewPublisher.sink { result in
            XCTAssertEqual(result.amountPerPerson, 100)
            XCTAssertEqual(result.totalBill, 100)
            XCTAssertEqual(result.totalTip, 0)
        }.store(in: &cancellable)
    }
    
    func testResultWithoutTipFor2Person() {
        // given
        let bill: Double = 100
        let tip: Tip = .none
        let split: Int = 2
        
        let input = buildInput(bill: bill, tip: tip, split: split)
        
        // when
        let output = sut.transform(input: input)
        
        // then
        output.updateViewPublisher.sink { result in
            XCTAssertEqual(result.amountPerPerson, 50)
            XCTAssertEqual(result.totalBill, 100)
            XCTAssertEqual(result.totalTip, 0)
        }.store(in: &cancellable)
    }
    
    func testResultWith10PercentTipFor2Person() {
        // given
        let bill: Double = 100
        let tip: Tip = .ten
        let split: Int = 2
        
        let input = buildInput(bill: bill, tip: tip, split: split)
        
        // when
        let output = sut.transform(input: input)
        
        // then
        output.updateViewPublisher.sink { result in
            XCTAssertEqual(result.amountPerPerson, 55)
            XCTAssertEqual(result.totalBill, 110)
            XCTAssertEqual(result.totalTip, 10)
        }.store(in: &cancellable)
    }
    
    func testResultWithCustomTipFor4Person() {
        // given
        let bill: Double = 100
        let tip: Tip = .custom(value: 4)
        let split: Int = 4
        
        let input = buildInput(bill: bill, tip: tip, split: split)
        
        // when
        let output = sut.transform(input: input)
        
        // then
        output.updateViewPublisher.sink { result in
            XCTAssertEqual(result.amountPerPerson, 26)
            XCTAssertEqual(result.totalBill, 104)
            XCTAssertEqual(result.totalTip, 4)
        }.store(in: &cancellable)
    }

}

// MARK: - Helpers

extension tip_calculatorTests {
    
    private func buildInput(bill: Double, tip: Tip, split: Int) -> CalculatorViewModel.Input {
        return .init(
            billPublisher: Just(bill).eraseToAnyPublisher(),
            tipPublisher: Just(tip).eraseToAnyPublisher(),
            splitPublisher: Just(split).eraseToAnyPublisher(),
            logoViewTapPublisher: logoViewTapSubject.eraseToAnyPublisher()
        )
    }
    
}
