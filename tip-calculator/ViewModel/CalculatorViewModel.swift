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
        
        let updateViewPublisher = Publishers.CombineLatest3(
            input.billPublisher,
            input.tipPublisher,
            input.splitPublisher
        ).flatMap { [unowned self] (bill, tip, split) in
            let totalTip = getTipAmount(bill: bill, tip: tip)
            let totalBill = bill + totalTip
            let amountPerPerson = totalBill / Double(split)
            
            let result = Result(
                amountPerPerson: amountPerPerson,
                totalBill: totalBill,
                totalTip: totalTip
            )
            
            return Just(result)
        }.eraseToAnyPublisher()

        return Output(updateViewPublisher: updateViewPublisher)
    }
    
    private func getTipAmount(bill: Double, tip: Tip) -> Double {
        switch tip {
        case .none:
            return 0
        case .ten:
            return bill * 0.1
        case .fifteen:
            return bill * 0.15
        case .twenty:
            return bill * 0.2
        case .custom(let value):
            return Double(value)
        }
    }
    
}
