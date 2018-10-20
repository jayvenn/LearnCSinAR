//
//  BaseNode.swift
//  Learn CS in AR
//
//  Created by Jayven Nhan on 5/17/18.
//  Copyright © 2018 Jayven Nhan. All rights reserved.
//

import UIKit
import ARKit

protocol FullAccessibleProtocol {
    var accessibilityLabel: String { get set }
}

class BaseNode: SCNNode {
    
    let lesson: Lesson
    let cubeLength: CGFloat
    let cubeSpacing: CGFloat
    let trackerNodeLength: CGFloat
    
    init(cubeLength: CGFloat, cubeSpacing: CGFloat, trackerNodeLength: CGFloat, lesson: Lesson) {
        self.cubeLength = cubeLength
        self.cubeSpacing = cubeSpacing
        self.trackerNodeLength = trackerNodeLength
        self.lesson = lesson
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
