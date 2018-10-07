//
//  OperationView.swift
//  Learn CS in AR
//
//  Created by Jayven Nhan on 9/4/18.
//  Copyright © 2018 Jayven Nhan. All rights reserved.
//

import UIKit
import SnapKit

final class OperationView: BaseARView {
    
    let flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 16
        flowLayout.scrollDirection = .horizontal
        let verticalInset: CGFloat = 16
        let horizontalInset: CGFloat = 0
        flowLayout.sectionInset = UIEdgeInsets(top: verticalInset, left: horizontalInset, bottom: verticalInset, right: horizontalInset)
        return flowLayout
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    let cellId = "OperationCollectionViewCell"
    let collectionViewHeight: CGFloat = 240
    
    var collectionViewBottomConstraint: Constraint?
    
    override init(lesson: Lesson) {
        super.init(lesson: lesson)
        sliderButton.isHidden = true
        expanderView.isHidden = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setUpLayout() {
        super.setUpLayout()
        stackView.addArrangedSubview(collectionView)
        
        collectionView.register(OperationCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
}

// MARK: OperationView - UICollectionViewDelegate
extension OperationView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

// MARK: OperationView - UICollectionViewDataSource
extension OperationView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return lesson.operations.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? OperationCollectionViewCell else { fatalError() }
        let operation = lesson.operations[indexPath.item]
        cell.configureCell(operation)
        return cell
    }
}

// MARK: OperationView - UICollectionViewDelegateFlowLayout
extension OperationView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = Calculator.CollectionView.getOperationCollectionViewCellSize(view: collectionView, flowLayout: flowLayout)
        return size
    }
    
//    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
//        UIView.animate(withDuration: 0.5) {
//            guard let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: self.cellId, for: indexPath) as? OperationCollectionViewCell else { fatalError() }
//            cell.operationLabel.transform = .init(scaleX: 0.95, y: 0.95)
//            cell.contentView.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
//        }
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
//        UIView.animate(withDuration: 0.5) {
//            guard let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: self.cellId, for: indexPath) as? OperationCollectionViewCell else { fatalError() }
//            cell.operationLabel.transform = .identity
//            cell.contentView.backgroundColor = .clear
//        }
//    }
}


// MARK: OperationView - Operation
extension OperationView {
    func setOperation() {
        setOperationTitleLabel()
    }
    
    func setOperationTitleLabel() {
        let titleColor = UIColor.black
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: titleColor,
                                   NSAttributedString.Key.font: getTitleLabelFont()]
        let titleAttributedText = NSMutableAttributedString(string: LocalizedString.operation, attributes: titleTextAttributes)
        titleLabel.attributedText = titleAttributedText
        titleLabel.lineBreakMode = .byTruncatingTail
        titleLabel.accessibilityLabel = "Operation"
    }
}
