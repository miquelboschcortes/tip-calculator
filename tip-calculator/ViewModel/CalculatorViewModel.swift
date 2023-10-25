//
//  CalculatorViewModel.swift
//  tip-calculator
//
//  Created by Miguel Bosch Cortés on 25/10/2023.
//

import Foundation
import Combine

class CalculatorViewModel {
    
    struct Input {
        let billPublisher: AnyPublisher<Double, Never>
        let tipPublisher: AnyPublisher<Tip, Never>
        let splitPublisher: AnyPublisher<Int, Never>
    }
    
    struct Output {
        let updateViewPublisher: AnyPublisher<Result, Never>
    }
    
    func transform(input: Input) -> Output {
        let result = Result(
            amountPerPerson: 500,
            totalBill: 1000,
            totalTip: 50)
        return Output(updateViewPublisher: Just(result).eraseToAnyPublisher())
    }
    
}
