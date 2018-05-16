//
//  AlternateARButton.swift
//  Learn CS in AR
//
//  Created by Jayven Nhan on 5/6/18.
//  Copyright © 2018 Jayven Nhan. All rights reserved.
//

import UIKit

class AlternateARButton: ARButton {
    
    override func setColorScheme() {
        super.setColorScheme()
        backgroundColor = .resetButtonBackground
    }
    
    override func setCornerRadius() {
        super.setCornerRadius()
        layer.cornerRadius = 25
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
