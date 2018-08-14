//
//  DirectionBallNode.swift
//  Learn CS in AR
//
//  Created by Jayven Nhan on 7/31/18.
//  Copyright © 2018 Jayven Nhan. All rights reserved.
//

import UIKit
import SceneKit

final class DirectionBallNode: SCNNode {

    let radius: CGFloat
    let cylinderHeight: CGFloat
    let isDoubly: Bool
    
    lazy var sphere: SCNSphere = {
        let sphere = SCNSphere(radius: radius)
        sphere.firstMaterial?.diffuse.contents = UIColor.white.withAlphaComponent(1)
        return sphere
    }()
    
    lazy var startPosY = Float(-cylinderHeight/2 - radius)
    lazy var endPosY = -1 * startPosY
    
    init(radius: CGFloat, cylinderHeight: CGFloat, isDoubly: Bool = false) {
        self.radius = radius
        self.cylinderHeight = cylinderHeight
        self.isDoubly = isDoubly
        super.init()
        setGeometry()
        setPosition()
        accessibilityLabel = "Direction ball"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// - Overheads
extension DirectionBallNode {
    func setGeometry() {
        geometry = sphere
        opacity = 1
    }
    
    func setPosition() {
        position.y = !isDoubly ? startPosY : endPosY
    }
}

// - Animation
extension DirectionBallNode {
    func animate(completion: @escaping () -> ()) {
        let action = generateDirectionalBallNodeAction()
        runAction(action) {
            print("Completed Direction Ball Node Animation")
            completion()
        }
    }
}

// - SCNAction
extension DirectionBallNode {
    func generateDirectionalBallNodeAction() -> SCNAction {
        let moveForwardVector = SCNVector3(0,!isDoubly ? endPosY : startPosY,0)
        let moveBackwardVector = SCNVector3(0,!isDoubly ? startPosY : endPosY,0)
        
        let fadeInAction = SCNAction.fadeIn(duration: 0)
        let fadeOutAction = SCNAction.fadeOut(duration: 0)
        
        let moveForwardAction = SCNAction.move(to: moveForwardVector, duration: animationDuration * 2)
        moveForwardAction.timingMode = .easeInEaseOut
        
        let moveBackwardAction = SCNAction.move(to: moveBackwardVector, duration: 0)
        let waitAction = SCNAction.wait(duration: animationDuration)
        let actionSequence = SCNAction.sequence(
            [fadeInAction,
             moveForwardAction,
             waitAction,
             fadeOutAction,
             moveBackwardAction,
             waitAction]
        )
        
        let repeatAction = SCNAction.repeat(actionSequence, count: 3)
        let action = SCNAction.sequence([repeatAction,
                                         SCNAction.removeFromParentNode()])
        
        return action
    }
}
