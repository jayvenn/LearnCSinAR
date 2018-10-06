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
    
    private let operationButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.roundedRect)
        button.sizeToFit()
        button.accessibilityLabel = "Operation label"
        button.backgroundColor = .white
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
        button.setTitleColor(UIColor.black, for: .normal)
        return button
    }()
    
    var operation: Operation! {
        didSet {
            let operationName = operation.rawValue
            operationButton.accessibilityLabel = operationName
            operationButton.setTitle(operationName, for: .normal)
        }
    }
    
    func configureCell(_ operation: Operation) {
        self.operation = operation
        print("CELL OPERATION NAME:", operation.rawValue)
        layoutIfNeeded()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        addSubview(operationButton)
        operationButton.snp.makeConstraints {
            $0.leading.trailing.top.bottom.equalToSuperview()
        }
    }
}
