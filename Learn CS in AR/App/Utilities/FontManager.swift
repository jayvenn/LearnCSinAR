//
//  FontManager.swift
//  Learn CS in AR
//
//  Created by Macbook on 8/13/18.
//  Copyright © 2018 Jayven Nhan. All rights reserved.
//

import UIKit

class FontManager {
    
    static let shared = FontManager()
    
    var titleFont: UIFont = Font(object: .titleLabel).instance
    var subtitleFont: UIFont = Font(object: .subTitleLabel).instance
    
}
