//
//  TipInputView.swift
//  tip-calculator
//
//  Created by Miguel Bosch Cortés on 24/10/2023.
//

import UIKit
import Combine
import CombineCocoa

class TipInputView: UIView {
    
    private let headerView: HeaderView = {
        let header = HeaderView()
        header.configure(
            topText: "Choose",
            bottomText: "your tip"
        )
        return header
    }()
    
    private lazy var customTipButton: UIButton = {
        let button = UIButton()
        button.setTitle("Custom tip", for: .normal)
        button.titleLabel?.font = ThemeFont.bold(ofSize: 20)
        button.backgroundColor = ThemeColor.primary
        button.tintColor = .white
        button.addCornerRadius(radius: 8)
        button.tapPublisher.sink { [weak self] _ in
            self?.handleCustomTipButton()
        }.store(in: &cancellables)
        return button
    }()
    
    private lazy var tenPercentTipButton: UIButton = {
        let button = buildTipButton(tip: .ten)
        button.tapPublisher.flatMap({
            Just(Tip.ten)
        })
        .assign(to: \.value, on: tipSubject)
        .store(in: &cancellables)
        return button
    }()
    
    private lazy var fiftyPercentTipButton: UIButton = {
        let button = buildTipButton(tip: .fifteen)
        button.tapPublisher.flatMap({
            Just(Tip.fifteen)
        })
        .assign(to: \.value, on: tipSubject)
        .store(in: &cancellables)
        return button
    }()
    
    private lazy var twentyPercentTipButton: UIButton = {
        let button = buildTipButton(tip: .twenty)
        button.tapPublisher.flatMap({
            Just(Tip.twenty)
        })
        .assign(to: \.value, on: tipSubject)
        .store(in: &cancellables)
        return button
    }()
    
    private lazy var buttonHStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                tenPercentTipButton,
                fiftyPercentTipButton,
                twentyPercentTipButton
            ]
        )
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        return stackView
    }()
    
    private lazy var buttonVStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                buttonHStackView,
                customTipButton
            ]
        )
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        return stackView
    }()
    
    private let tipSubject = CurrentValueSubject<Tip, Never>(.none)
    var valuePublisher: AnyPublisher<Tip, Never> {
        return tipSubject.eraseToAnyPublisher()
    }
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        super.init(frame: .zero)
        layout()
        observe()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reset() {
        tipSubject.send(.none)
    }
    
    private func layout() {
        
        [headerView, buttonVStackView].forEach(addSubview(_:))
        
        buttonVStackView.snp.makeConstraints { make in
            make.top.trailing.bottom.equalToSuperview()
        }
        
        headerView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalTo(buttonHStackView.snp.centerY)
            make.trailing.equalTo(buttonVStackView.snp.leading).offset(-24)
            make.width.equalTo(68)
        }
    }
    
    private func handleCustomTipButton() {
        let alertController: UIAlertController = {
            let controller = UIAlertController(
                title: "Enter custom tip",
                message: nil,
                preferredStyle: .alert
            )
            controller.addTextField { textField in
                textField.placeholder = "Make it generous!"
                textField.keyboardType = .numberPad
                textField.autocorrectionType = .no
            }
            
            let cancelAction = UIAlertAction(
                title: "Cancel",
                style: .cancel
            )
            
            let okAction = UIAlertAction(
                title: "OK",
                style: .default
            ) { [weak self] _ in
                
                guard
                    let text = controller.textFields?.first?.text,
                    let value = Int(text)
                else {
                    return
                }
                
                self?.tipSubject.send(.custom(value: value))
            }
            
            [okAction, cancelAction].forEach(controller.addAction(_:))
            return controller
        }()
        
        parentViewController?.present(alertController, animated: true)
    }
    
    private func observe() {
        tipSubject.sink { [unowned self] tip in
            resetView()
            
            switch tip {
            case .none:
                break
            case .ten:
                tenPercentTipButton.backgroundColor = ThemeColor.secundary
            case .fifteen:
                fiftyPercentTipButton.backgroundColor = ThemeColor.secundary
            case .twenty:
                twentyPercentTipButton.backgroundColor = ThemeColor.secundary
            case .custom(let value):
                customTipButton.backgroundColor = ThemeColor.secundary
                let text = NSMutableAttributedString(
                    string: "$\(value)",
                    attributes: [
                        .font: ThemeFont.bold(ofSize: 20)
                    ]
                )
                text.addAttributes([
                    .font: ThemeFont.bold(ofSize: 14)
                ], range: NSMakeRange(0, 1))
                
                customTipButton.setAttributedTitle(text, for: .normal)
            }
        }.store(in: &cancellables)
    }
    
    private func resetView() {
        [
            tenPercentTipButton,
            fiftyPercentTipButton,
            twentyPercentTipButton,
            customTipButton
        ].forEach {
            $0.backgroundColor = ThemeColor.primary
        }
        
        let text = NSMutableAttributedString(
            string: "Custom tip",
            attributes: [
                .font: ThemeFont.bold(ofSize: 20)
            ]
        )
        customTipButton.setAttributedTitle(text, for: .normal)
    }
    
    private func buildTipButton(tip: Tip) -> UIButton {
        let button = UIButton(type: .custom)
        button.backgroundColor = ThemeColor.primary
        button.tintColor = .white
        button.addCornerRadius(radius: 8)
        
        let text = NSMutableAttributedString(
            string: tip.stringValue,
            attributes: [
                .font: ThemeFont.bold(ofSize: 20),
                .foregroundColor: UIColor.white
            ]
        )
        text.addAttributes([.font: ThemeFont.demiBold(ofSize: 14)], range: NSMakeRange(2, 1))
        button.setAttributedTitle(text, for: .normal)
        return button
    }
}
