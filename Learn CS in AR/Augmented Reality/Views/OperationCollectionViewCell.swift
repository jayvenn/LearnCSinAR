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
    
    private let operationNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
//        label.minimumScaleFactor = 0.5
//        label.adjustsFontForContentSizeCategory = true
        label.sizeToFit()
        label.accessibilityLabel = "Operation name"
        return label
    }()
    
    var operation: Operation! {
        didSet {
            let operationName = operation.rawValue
            operationNameLabel.accessibilityLabel = operationName
            operationNameLabel.text = operationName
        }
    }
    
    func configureCell(_ operation: Operation) {
        self.operation = operation
        print("CELL OPERATION NAME:", operation.rawValue)
    }
    
    func setupLayout() {
        addSubview(operationNameLabel)
        operationNameLabel.snp.makeConstraints {
            $0.leading.trailing.top.bottom.equalToSuperview()
        }
    }
}
