//
//  LinkedListNode.swift
//  Learn CS in AR
//
//  Created by Jayven Nhan on 5/17/18.
//  Copyright © 2018 Jayven Nhan. All rights reserved.
//

import UIKit
import ARKit

class LinkedListNode: BaseNode {
    
    var tubeNodes = [SCNNode]()
    var directionBallNodes = [SCNNode]()
    
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
    
    func generateSinglyLinkingNodes(basedOn nodes: [CubeNode]) {
        guard tubeNodes.isEmpty, directionBallNodes.isEmpty else { return }
        
        let radius = cubeSpacing / 4
        let cylinder = SCNCylinder(radius: radius, height: cubeSpacing)
        cylinder.firstMaterial?.diffuse.contents = UIColor.white.withAlphaComponent(0.7)
        
        var index = 0
        while index < nodes.count - 1 {
            let node = nodes[index + 1]
            
            let tubeNode = SCNNode(geometry: cylinder)
            tubeNode.opacity = 0
            tubeNode.position.x = Float(-(cubeLength/2) - (cubeSpacing / 2))
            tubeNode.eulerAngles.z = Float(-90 * degreesToRadians)
            
            let fadeInAction = SCNAction.fadeIn(duration: animationDuration)
            
            let directionBallNode = generateDirectionBallNode(radius: radius / 2)
            let startPosY = Float(-1 * ((cylinder.height / 2) + (radius / 2)))
            let endPosY = -1 * startPosY
            directionBallNode.position.y = startPosY
            let directionalBallNodeAction = generateDirectionalBallNodeAction(startPosY: startPosY, endPosY: endPosY)
            
            node.addChildNode(tubeNode)
            tubeNode.addChildNode(directionBallNode)
            
            tubeNodes.append(tubeNode)
            directionBallNodes.append(directionBallNode)
            
            tubeNode.runAction(fadeInAction) {
                directionBallNode.runAction(directionalBallNodeAction) {
                    for (index, tubeNode) in self.tubeNodes.enumerated() {
                        tubeNode.runAction (self.fadeOutAndRemoveAction) {
                            guard index != self.tubeNodes.endIndex - 1 else { return self.tubeNodes = [] }
                        }
                    }
                    self.directionBallNodes.forEach { $0.removeFromParentNode() }
                    self.directionBallNodes = []
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
    
    func generateDirectionBallNode(radius: CGFloat) -> SCNNode {
        let directionBall = SCNSphere(radius: radius)
        directionBall.firstMaterial?.diffuse.contents = UIColor.white.withAlphaComponent(1)
        let directionBallNode = SCNNode(geometry: directionBall)
        directionBallNode.opacity = 1
        return directionBallNode
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
    
    func removeTubesAndBalls() {
        let fadeOutAction = SCNAction.fadeOut(duration: animationDuration)
        var index = 0
        let endIndex = tubeNodes.count - 1
        while index < endIndex {
            let node = tubeNodes[index]
            if index == endIndex - 1 {
                node.runAction(fadeOutAction) {
                    self.tubeNodes.forEach { $0.removeFromParentNode() }
                    self.directionBallNodes.forEach { $0.removeFromParentNode() }
                }
            } else {
                node.runAction(fadeOutAction)
            }
            index += 1
        }
    }
}
