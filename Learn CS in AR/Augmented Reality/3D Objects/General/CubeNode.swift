//
//  CubeNode.swift
//  Learn CS in AR
//
//  Created by Jayven Nhan on 7/28/18.
//  Copyright © 2018 Jayven Nhan. All rights reserved.
//

import ARKit

class CubeNode: SCNNode {
    
    let index: Int
    let length: CGFloat
    let initialPosition: (x: Float, y: Float)
    let leadingX: CGFloat
    let cubeSpacing: CGFloat = 0.05
    var leftNode: CubeNode?
    var rightNode: CubeNode?
    
    var airPosition: (x: Float, y: Float) {
        let x = initialPosition.x
        let y = Float((length / 2) + 0.2)
        return (x, y)
    }
    
    init(length: CGFloat, index: Int, leadingX: CGFloat = 0) {
        self.length = length
        self.index = index
        self.leadingX = leadingX
        let xInitial = Float(leadingX) + (Float(cubeSpacing + length) * Float(index))
        let yInitial = Float((length / 2))
        self.initialPosition = (x: xInitial, y: yInitial)
        super.init()
        setGeometry()
        setInitialPosition()
        opacity = 0
        name = "box\(index)"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setGeometry() {
        let cube = SCNBox(width: length, height: length, length: length, chamferRadius: length/10)
        cube.firstMaterial?.isDoubleSided = true
        geometry = cube
    }
    
    func setInitialPosition() {
        position.x = initialPosition.x
        position.y = initialPosition.y
    }
}

// - Singly Linked List
extension CubeNode {
//    func cubeNodes
}
