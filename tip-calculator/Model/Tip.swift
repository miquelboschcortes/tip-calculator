//
//  Tip.swift
//  tip-calculator
//
//  Created by Miguel Bosch Cortés on 25/10/2023.
//

import Foundation

enum Tip {
    
    case none
    case ten
    case fiften
    case twenty
    case custom(value: Int)
    
    var stringValue: String {
        switch self {
        case .none:
            return ""
        case .ten:
            return "10%"
        case .fiften:
            return "15%"
        case .twenty:
            return "20%"
        case .custom(let value):
            return String(value)
        }
    }
}
