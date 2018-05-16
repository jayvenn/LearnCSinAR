//
//  ARButton.swift
//  Learn CS in AR
//
//  Created by Jayven Nhan on 5/6/18.
//  Copyright © 2018 Jayven Nhan. All rights reserved.
//

import UIKit

class ARButton: UIButton {
    
    init(image: UIImage, frame: CGRect = .zero) {
        super.init(frame: frame)
        setColorScheme()
        setCornerRadius()
        set(image: image)
    }
    
    fileprivate func setFont() {
        titleLabel?.font = Font(object: .button).instance
    }
    
    func setCornerRadius() {
        layer.cornerRadius = 30
        layer.masksToBounds = true
    }
    
    func setColorScheme() {
        setTitleColor(.white, for: .normal)
        setTitleColor(.gray, for: .selected)
        backgroundColor = .plantButtonBackground
    }
    
    func set(image: UIImage) {
        guard let imageView = self.imageView else { return }
        let image = image.withRenderingMode(.alwaysTemplate)
        setImage(image, for: .normal)
        imageView.tintColor = .white
        print("Set image tint color success")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
