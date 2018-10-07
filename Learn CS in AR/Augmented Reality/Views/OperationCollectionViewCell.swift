//
//  OperationCollectionViewCell.swift
//  Learn CS in AR
//
//  Created by Jayven Nhan on 9/3/18.
//  Copyright © 2018 Jayven Nhan. All rights reserved.
//

import UIKit
import SnapKit

final class OperationCollectionViewCell: UICollectionViewCell {
    
    lazy var operationButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.roundedRect)
        button.sizeToFit()
        button.accessibilityLabel = "Operation label"
        button.backgroundColor = .white
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(operationButtonDidTouchUpDown), for: .touchUpInside)
        return button
    }()
    
    let operationLabel: UILabel = {
        let label = UILabel()
        label.accessibilityLabel = "Operation"
        label.backgroundColor = .black
        label.textColor = .white
        label.layer.borderColor = UIColor.black.cgColor
        label.layer.borderWidth = 1
        label.layer.cornerRadius = 15
        return label
    }()
    
    let notificationCenter = NotificationCenter.default
    
    var operation: Operation! {
        didSet {
            let operationName = operation.rawValue
//            operationLabel.accessibilityLabel = operationName
//            operationLabel.text = operationName
            operationButton.accessibilityLabel = operationName
            operationButton.setTitle(operationName, for: .normal)
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.1) {
                let scale: CGFloat = 0.95
                self.transform = self.isHighlighted ? CGAffineTransform(scaleX: scale, y: scale) : .identity
            }
        }
    }
    
    func configureCell(_ operation: Operation) {
        self.operation = operation
    }
    
    @objc func operationButtonDidTouchUpDown(sender: UIButton) {
        notificationCenter.post(name: .operationButtonDidTouchUpInside, object: operation)
    }
    
//    func operationButton
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        addSubview(operationButton)
        operationButton.snp.makeConstraints { $0.leading.trailing.top.bottom.equalToSuperview() }
    }
}
