//
//  UIResponder+Extension.swift
//  tip-calculator
//
//  Created by Miguel Bosch Cortés on 25/10/2023.
//

import UIKit

extension UIResponder {
    var parentViewController: UIViewController? {
        return next as? UIViewController ?? next?.parentViewController
    }
}
