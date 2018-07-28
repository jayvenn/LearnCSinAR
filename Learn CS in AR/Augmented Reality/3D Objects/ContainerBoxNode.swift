//
//  ContainerNode.swift
//  Learn CS in AR
//
//  Created by Jayven Nhan on 5/6/18.
//  Copyright © 2018 Jayven Nhan. All rights reserved.
//

import UIKit
import ARKit

enum stackContainerBoxNodeName: String {
    case leftSquare = "leftSquare"
    case rightSquare = "rightSquare"
    case topRectangle = "topRectangle"
    case bottomRectangle = "bottomRectangle"
    case leftRectangle = "leftRectangle"
    case rightRectangle = "rightRectangle"
}

protocol ContainerBoxNodeDelegate: class {
    func didFinishOrdering()
}

class ContainerBoxNode: BaseNode {
    
    let fadeInAction: SCNAction = {
        return SCNAction.sequence([SCNAction.fadeIn(duration: 0.3)])
    }()
    
    // Square
    lazy var squareLength: CGFloat = cubeLength + 0.05
    lazy var squarePlane: SCNPlane = {
        let plane = SCNPlane(width: squareLength, height: squareLength)
        plane.firstMaterial?.isDoubleSided = true
        return plane
    }()
    
    lazy var rightSquareNode = SCNNode(geometry: squarePlane)
    lazy var leftSquareNode = SCNNode(geometry: squarePlane)
    
    var halfTrackerNodeLength: Float {
        return Float(trackerNodeLength / 2)
    }
    
    lazy var openDoorAction: SCNAction = {
        let horizontalDistance: CGFloat = 0.05
        let action = SCNAction.sequence([
            SCNAction.moveBy(x: -horizontalDistance, y: 0, z: 0, duration: animationDuration),
            SCNAction.moveBy(x: 0, y: squareLength, z: 0, duration: animationDuration),
            SCNAction.moveBy(x: horizontalDistance, y: 0, z: 0, duration: animationDuration)
            ])
        action.timingMode = .easeInEaseOut
        return action
    }()
    
    var moveInsideContainerActionArray = [SCNAction]()
    var reversedMoveInsideContainerActionArray = [SCNAction]()
    
    weak var delegate: ContainerBoxNodeDelegate?
    
    // Rectangle
    lazy var rectanglePlane: SCNPlane = {
        let plane = SCNPlane(width: squareLength, height: trackerNodeLength)
        plane.firstMaterial?.isDoubleSided = true
        return plane
    }()
    
    override init(cubeLength: CGFloat, cubeSpacing: CGFloat, trackerNodeLength: CGFloat) {
        super.init(cubeLength: cubeLength, cubeSpacing: cubeSpacing, trackerNodeLength: trackerNodeLength)
        opacity = 0
        generateNode()
    }
    
    func generateNode() {
        generateLeftSquareNode()
        generateRightSquareNode()
        generateRectangleNodes()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: ContainerBoxNode - Action
extension ContainerBoxNode {
    func runFadeInAction(completion: @escaping () -> ()) {
        runAction(fadeInAction) {
            self.runAssembleSquareAction(completion: {
                completion()
            })
        }
    }
    
    func runAssembleSquareAction(completion: @escaping () -> ()) {
        let duration = TimeInterval(1)
        let leftSquareAction = SCNAction.moveBy(x: CGFloat(cubeLength), y: 0, z: 0, duration: duration)
        let rightSquareAction = SCNAction.moveBy(x: CGFloat(-cubeLength), y: 0, z: 0, duration: duration)
        leftSquareNode.runAction(leftSquareAction)
        rightSquareNode.runAction(rightSquareAction) {
            completion()
        }
    }
}

// MARK: ContainerBoxNode - Generate node
extension ContainerBoxNode {
    func generateRightSquareNode() {
        rightSquareNode.eulerAngles = SCNVector3(0,90 * degreesToRadians,0)
        rightSquareNode.position.x = halfTrackerNodeLength + Float(cubeLength)
        rightSquareNode.name = stackContainerBoxNodeName.rightSquare.rawValue
        addChildNode(rightSquareNode)
    }
    
    func generateLeftSquareNode() {
        leftSquareNode.eulerAngles = SCNVector3(0,90 * degreesToRadians,0)
        leftSquareNode.position.x = -halfTrackerNodeLength - Float(cubeLength)
        leftSquareNode.name = stackContainerBoxNodeName.leftSquare.rawValue
        addChildNode(leftSquareNode)
    }
    
    func generateRectangleNodes() {
        var rectangularNodes = [SCNNode]()
        // Rectangle Plane
        // SMART: Loop to create a rectangular prism
        let degrees = Float(90 * degreesToRadians)
        // Top Rectangle Plane Node
        let topRectangePlaneNode = SCNNode(geometry: rectanglePlane)
        // Position
        topRectangePlaneNode.position.y = Float(squarePlane.height / 2)
        // Euler Angles
        topRectangePlaneNode.eulerAngles.x = degrees
        topRectangePlaneNode.eulerAngles.y = degrees
        topRectangePlaneNode.opacity = 0.2
        topRectangePlaneNode.name = stackContainerBoxNodeName.topRectangle.rawValue
        rectangularNodes.append(topRectangePlaneNode)
        
        // Bottom Rectangle Plane Node
        let bottomRectangePlaneNode = SCNNode(geometry: rectanglePlane)
        // Position
        bottomRectangePlaneNode.position.y = -Float(squarePlane.height / 2)
        // Euler Angles
        bottomRectangePlaneNode.eulerAngles.x = degrees
        bottomRectangePlaneNode.eulerAngles.y = degrees
        bottomRectangePlaneNode.opacity = 0.2
        bottomRectangePlaneNode.name = stackContainerBoxNodeName.bottomRectangle.rawValue
        rectangularNodes.append(bottomRectangePlaneNode)
        
        // Left Rectangle Plane Node
        let leftRectangePlaneNode = SCNNode(geometry: rectanglePlane)
        // Position
        leftRectangePlaneNode.position.z = Float(squarePlane.height / 2)
        // Euler Angles
        leftRectangePlaneNode.eulerAngles.z = degrees
        leftRectangePlaneNode.opacity = 0.2
        leftRectangePlaneNode.name = stackContainerBoxNodeName.leftRectangle.rawValue
        rectangularNodes.append(leftRectangePlaneNode)
        
        // Right Rectangle Plane Node
        let rightRectangePlaneNode = SCNNode(geometry: rectanglePlane)
        // Position
        rightRectangePlaneNode.position.z = -Float(squarePlane.height / 2)
        // Euler Angles
        rightRectangePlaneNode.eulerAngles.z = degrees
        rightRectangePlaneNode.opacity = 0.2
        rightRectangePlaneNode.name = stackContainerBoxNodeName.rightRectangle.rawValue
        rectangularNodes.append(rightRectangePlaneNode)
        
        for rectangularNode in rectangularNodes {
            addChildNode(rectangularNode)
        }
    }
    
    func push(boxes: [SCNNode]) {
        openDoorMoveUp(node: leftSquareNode)
        // BUG: Completion handler doesn't run with timing mode set to .easeInEaseOut
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + animationDuration * 3) {
            self.moveIn(boxes)
        }
    }
    
    func openDoorMoveUp(node: SCNNode) {
        node.runAction(openDoorAction)
    }
    
    func moveIn(_ nodes: [SCNNode], index: Int = 0) {
        guard index != nodes.count else {
            return
        }
        let node = nodes[index]
        let action = getMoveInsideContainerAction(withNode: node, index: index, nodes: nodes)
        moveInsideContainerActionArray.append(action)
        node.runAction(action) {
            guard index + 1 == nodes.count else { return }
            self.moveOut(nodes, index: index)
        }
        delay(animationDuration * 2) {
            self.moveIn(nodes, index: index + 1)
        }
    }
    
    func moveOut(_ nodes: [SCNNode], index: Int = 0) {
        guard index >= 0 else {
            self.moveInsideContainerActionArray = []
            return
        }
        let node = nodes[index]
        let action = reversedMoveInsideContainerActionArray[index]
        node.runAction(action) {
            guard index - 1 == 0 else { return }
            self.closeDoorMoveDown(node: self.leftSquareNode, completion: {
                self.delegate?.didFinishOrdering()
            })
        }
        
        delay(animationDuration * 2) {
            self.moveOut(nodes, index: index - 1)
        }
    }
    
    func closeDoorMoveDown(node: SCNNode, completion: @escaping () -> ()) {
        node.runAction(openDoorAction.reversed()) {
            completion()
        }
    }
    
    func getMoveInsideContainerAction(withNode node: SCNNode, index: Int, nodes: [SCNNode]) -> SCNAction {
        let originalPosition = node.position
        var position = node.position
        position.x -= (Float(cubeSpacing + cubeLength) * Float(index + 1))
        var secondPosition = position
        secondPosition.y = self.position.y
        var finalPosition = secondPosition
        finalPosition.x += (Float(self.cubeSpacing + self.cubeLength) * Float(nodes.count - index))
        
        let action = SCNAction.sequence([SCNAction.move(to: position, duration: animationDuration),
                                         SCNAction.wait(duration: animationDuration),
                                         SCNAction.move(to: secondPosition, duration: animationDuration),
                                         SCNAction.move(to: finalPosition, duration: animationDuration)
                                         ])
        
        let reversedAction = SCNAction.sequence([
            SCNAction.move(to: finalPosition, duration: animationDuration),
            SCNAction.move(to: secondPosition, duration: animationDuration),
            SCNAction.wait(duration: animationDuration),
            SCNAction.move(to: position, duration: animationDuration),
            SCNAction.move(to: originalPosition, duration: animationDuration)
            ])
        reversedMoveInsideContainerActionArray.append(reversedAction)
        
        return action
    }
    
    func delay(_ delay:Double, closure:@escaping ()->()) {
        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
    }
    
}
