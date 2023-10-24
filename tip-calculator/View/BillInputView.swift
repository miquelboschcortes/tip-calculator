//
//  BillInputView.swift
//  tip-calculator
//
//  Created by Miguel Bosch Cortés on 24/10/2023.
//

import UIKit

class BillInputView: UIView {
    
    init() {
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        backgroundColor = .green
    }
}
