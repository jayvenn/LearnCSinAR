//
//  LinkedListNode.swift
//  Learn CS in AR
//
//  Created by Jayven Nhan on 5/17/18.
//  Copyright © 2018 Jayven Nhan. All rights reserved.
//

import UIKit
import ARKit

final class LinkedListNode: BaseNode {
    
    var directionTubeNodes = [DirectionTubeNode]()
    
    let fadeOutAndRemoveAction: SCNAction = {
        return SCNAction.sequence([
            SCNAction.fadeOut(duration: animationDuration),
            SCNAction.removeFromParentNode()
            ])
    }()
    
    override init(cubeLength: CGFloat, cubeSpacing: CGFloat, trackerNodeLength: CGFloat, lesson: Lesson) {
        super.init(cubeLength: cubeLength, cubeSpacing: cubeSpacing, trackerNodeLength: trackerNodeLength, lesson: lesson)
        opacity = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func generateSinglyLinkingNodes(basedOn nodes: [CubeNode], isDoubly: Bool = false) {
        guard directionTubeNodes.isEmpty else { return }
        
        var index = 0
        while index < nodes.count - 1 {
            let node = nodes[index + 1]
            let directionTubeNode = DirectionTubeNode(cubeLength: cubeLength, cubeSpacing: cubeSpacing, index: index)
            if isDoubly {
                directionTubeNode.position.y = Float(cubeSpacing / 4) + Float(cubeSpacing / 4) / 2
            }
            
            node.addChildNode(directionTubeNode)
            directionTubeNodes.append(directionTubeNode)
            
            directionTubeNode.animate {
                self.directionTubeNodes = []
            }
            
            if isDoubly {
                let directionTubeNode = DirectionTubeNode(cubeLength: cubeLength, cubeSpacing: cubeSpacing, index: index, isDoubly: isDoubly)
                directionTubeNode.position.y = Float(-cubeSpacing / 4) - Float(cubeSpacing / 4 / 2)
                node.addChildNode(directionTubeNode)
                self.directionTubeNodes.append(directionTubeNode)
                directionTubeNode.animate {
                    
                }
            }
            
            index += 1
        }
    }
    
    func moveCubesToAirPosition(_ nodes: [CubeNode]) {
        for node in nodes {
            let position = node.airPosition
            let vector = SCNVector3(position.x, position.y, 0)
            let action = SCNAction.move(to: vector, duration: animationDuration)
            node.runAction(action)
        }
    }
    
    func generateDirectionalBallNodeAction(startPosY: Float, endPosY: Float) -> SCNAction {
        let moveForwardVector = SCNVector3(0,endPosY,0)
        let moveBackwardVector = SCNVector3(0,startPosY,0)
        
        let fadeInAction = SCNAction.fadeIn(duration: 0)
        let fadeOutAction = SCNAction.fadeOut(duration: 0)
        
        let moveForwardAction = SCNAction.move(to: moveForwardVector, duration: animationDuration)
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
        
        
        return repeatAction
    }
    
//    func removeTubesAndBalls() {
//        let fadeOutAction = SCNAction.fadeOut(duration: animationDuration)
//        var index = 0
//        let endIndex = tubeNodes.count - 1
//        while index < endIndex {
//            let node = tubeNodes[index]
//            if index == endIndex - 1 {
//                node.runAction(fadeOutAction) {
//                    self.tubeNodes.forEach { $0.removeFromParentNode() }
//                    self.directionBallNodes.forEach { $0.removeFromParentNode() }
//                }
//            } else {
//                node.runAction(fadeOutAction)
//            }
//            index += 1
//        }
//    }
}
