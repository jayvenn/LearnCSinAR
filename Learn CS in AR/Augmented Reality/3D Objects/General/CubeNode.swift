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
        let y = initialPosition.y + Float((length / 2) + 0.2)
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
        accessibilityLabel = "Cube"
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

// - Queue
extension CubeNode {
    func getPopQueueAction() -> SCNAction {
        var position = self.position
        position.x += (Float(cubeSpacing + length) * Float(index + 1))
        var secondPosition = position
        secondPosition.y = airPosition.y
        var finalPosition = secondPosition
        finalPosition.x = airPosition.x
        
        let action = SCNAction.sequence([SCNAction.move(to: position, duration: animationDuration),
                                     SCNAction.wait(duration: animationDuration),
                                     SCNAction.move(to: secondPosition, duration: animationDuration),
                                     SCNAction.move(to: finalPosition, duration: animationDuration)
            ])
        return action
    }
}

// - Singly Linked List
extension CubeNode {
//    func cubeNodes
}
