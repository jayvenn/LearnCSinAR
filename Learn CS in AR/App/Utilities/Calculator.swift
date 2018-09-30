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
            let minimumInteritemSpacing = flowLayout.minimumInteritemSpacing
            let horizontalItemsCount: CGFloat = 2
            let width = ((view.frame.width - horizontalInsets) - (horizontalItemsCount - 1) * minimumInteritemSpacing) / horizontalItemsCount
            
            let verticalInsets = flowLayout.sectionInset.top + flowLayout.sectionInset.bottom
//            let minimumLineSpacingSpacing = flowLayout.minimumLineSpacing
//            let verticalItemsCount: CGFloat = 2
//            let height = width * 1.5
            print(verticalInsets)
            let height = ((view.frame.height - verticalInsets) - (horizontalItemsCount - 1) * minimumInteritemSpacing) / horizontalItemsCount
            let size = CGSize(width: width, height: height)
            return size
        }
    }
}
