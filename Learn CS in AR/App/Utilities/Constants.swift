//
//  Constants.swift
//  Learn CS in AR
//
//  Created by Jayven Nhan on 4/26/18.
//  Copyright © 2018 Jayven Nhan. All rights reserved.
//

import UIKit

let scaleFactor: Float = 0.01
let scaleFactorAlternative: Float = 0.20
let eulerYAngle = 90
let eulerXAngle = 0
let eulerZAngle = 0

let degreesToRadians = CGFloat.pi / 180
let radiansToDegrees = 180 / CGFloat.pi

let fadeInAnimationDuration: TimeInterval = 0.3
let animationDuration: TimeInterval = 0.5 // 0.5

enum TableViewCellReuseIdentifier: String {
    case MenuTableViewCell = "MenuTableViewCell"
    case LessonTableViewCell = "LessonTableViewCell"
}
