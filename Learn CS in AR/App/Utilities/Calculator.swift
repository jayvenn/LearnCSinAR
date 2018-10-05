//
//  Calculator.swift
//  Learn CS in AR
//
//  Created by Jayven Nhan on 9/27/18.
//  Copyright © 2018 Jayven Nhan. All rights reserved.
//

import UIKit

struct Calculator {
    static let shared = Calculator()
    struct CollectionView {
        static func getOperationCollectionViewCellSize(view: UIView, flowLayout: UICollectionViewFlowLayout) -> CGSize {
            let horizontalInsets = flowLayout.sectionInset.left + flowLayout.sectionInset.right
            let minimumInteritemSpacing = flowLayout.minimumLineSpacing
            let horizontalItemsCount: CGFloat = 2
            let width = ((view.frame.width - 2 - horizontalInsets) - (horizontalItemsCount - 1) * minimumInteritemSpacing) / horizontalItemsCount
//
////            let verticalItemsCount: CGFloat = 1
//            let verticalInsets = flowLayout.sectionInset.top + flowLayout.sectionInset.bottom
////            let height = ((view.frame.height - verticalInsets) - ((verticalItemsCount - 1) * minimumInteritemSpacing)) / verticalItemsCount
            let height = view.frame.height - 72
            let size = CGSize(width: width, height: height)
            return size
        }
    }
}
