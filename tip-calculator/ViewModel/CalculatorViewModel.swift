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
    
    private var cancellables = Set<AnyCancellable>()
    
    func transform(input: Input) -> Output {
        
        input.billPublisher.sink { bill in
            print("the bill is: \(bill)")
        }.store(in: &cancellables)
        
        input.tipPublisher.sink { tip in
            print("the tip is: \(tip)")
        }.store(in: &cancellables)
        
        let result = Result(
            amountPerPerson: 500,
            totalBill: 1000,
            totalTip: 50)
        return Output(updateViewPublisher: Just(result).eraseToAnyPublisher())
    }
    
}
