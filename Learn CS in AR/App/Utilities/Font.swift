//
//  Font.swift
//  Learn CS in AR
//
//  Created by Jayven Nhan on 4/26/18.
//  Copyright © 2018 Jayven Nhan. All rights reserved.
//

import UIKit

enum UIObject {
    case titleLabel, subTitleLabel, textField, button, aRLabel,
    textViewTitle, textViewSubtitle, textViewBody
}

struct Font {
    
    enum StandardSize: Double {
        case h1 = 36
        case h2 = 18
        case h3 = 14
        case h4 = 16
    }
    
    enum FontType {
        case system
        case systemMedium
        case systemBold
        case systemItatic
        case systemWeighted(weight: Double)
        case monoSpacedDigit(size: Double, weight: Double)
    }
    
    enum FontSize {
        case standard(StandardSize)
        case custom(Double)
        var value: Double {
            switch self {
            case .standard(let size):
                return size.rawValue
            case .custom(let customSize):
                return customSize
            }
        }
    }
    
    var type: FontType
    var size: FontSize
    
    init(_ type: FontType, size: FontSize) {
        self.type = type
        self.size = size
    }
    
    init(object: UIObject) {
        switch object {
        case .titleLabel:
            type = FontType.systemBold
            size = FontSize.standard(.h1)
        case .subTitleLabel:
            type = FontType.system
            size = FontSize.standard(.h3)
        case .textField:
            type = FontType.system
            size = FontSize.standard(.h2)
        case .button:
            type = FontType.system
            size = FontSize.standard(.h2)
        case .aRLabel:
            type = FontType.systemBold
            size = FontSize.standard(.h4)
        case .textViewTitle:
            type = FontType.systemBold
            size = FontSize.standard(.h1)
        case .textViewSubtitle:
            type = FontType.systemBold
            size = FontSize.standard(.h2)
        case .textViewBody:
//            type = FontType.system
//            size = FontSize.standard(.h3)
            type = FontType.systemBold
            size = FontSize.standard(.h2)
        }
    }
    
    static func logAvailableFonts() {
        UIFont.familyNames.forEach { (familyName) in
            print("Font Family:", familyName)
            UIFont.fontNames(forFamilyName: familyName).forEach({ (fontName) in
                print("Font Name:", familyName)
            })
        }
    }
    
}

extension Font {
    var instance: UIFont {
        var instanceFont: UIFont!
        switch type {
        case .system:
            instanceFont = UIFont.systemFont(ofSize: CGFloat(size.value))
        case .systemBold:
            instanceFont = UIFont.boldSystemFont(ofSize: CGFloat(size.value))
        case .systemItatic:
            instanceFont = UIFont.italicSystemFont(ofSize: CGFloat(size.value))
        case .systemMedium:
            instanceFont = UIFont.systemFont(ofSize: CGFloat(size.value), weight: .medium)
        case .systemWeighted(let weight):
            instanceFont = UIFont.systemFont(ofSize: CGFloat(size.value),
                                             weight: UIFont.Weight(rawValue: CGFloat(weight)))
        case .monoSpacedDigit(let size, let weight):
            instanceFont = UIFont.monospacedDigitSystemFont(ofSize: CGFloat(size),
                                                            weight: UIFont.Weight(rawValue: CGFloat(weight)))
        }
        return instanceFont
    }
}

