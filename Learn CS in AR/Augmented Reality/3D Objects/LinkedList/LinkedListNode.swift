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
        accessibilityLabel = "Linked list"
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
    
    func pushNode() {
        let index = directionTubeNodes.count
        let cubeNode = CubeNode(length: cubeLength, index: index)
        
    }
    
    func getSinglyLinkedListActions(node: CubeNode) -> (action: SCNAction, reversedAction: SCNAction) {
        return (SCNAction(), SCNAction())
//        let originalPosition = node.position
//        var position = node.position
//        position.x -= (Float(cubeSpacing + cubeLength) * Float(index + 1))
//        var secondPosition = position
//        secondPosition.y = self.position.y
//        var finalPosition = secondPosition
//        finalPosition.x += (Float(self.cubeSpacing + self.cubeLength) * Float(cubeNodes.count - index))
//
//        let duration = animationDuration
//        let action = SCNAction.sequence([
//            SCNAction.move(to: position, duration: duration),
//            SCNAction.wait(duration: duration),
//            SCNAction.move(to: secondPosition, duration: duration),
//            SCNAction.move(to: finalPosition, duration: duration)
//            ])
//
//        let reversedAction: SCNAction
//        switch lesson.name {
//        case .stack:
//            reversedAction = SCNAction.sequence([
//                SCNAction.move(to: finalPosition, duration: duration),
//                SCNAction.move(to: secondPosition, duration: duration),
//                SCNAction.wait(duration: duration),
//                SCNAction.move(to: position, duration: duration),
//                SCNAction.move(to: originalPosition, duration: duration)
//                ])
//        case .queue:
//            reversedAction = node.getPopQueueAction()
//        default:
//            reversedAction = SCNAction()
//        }
//        return (action, reversedAction)
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
        // TODO: Use action?
        let action = SCNAction.sequence([repeatAction,
                                         SCNAction.removeFromParentNode()])
        
        
        return repeatAction
    }
}
