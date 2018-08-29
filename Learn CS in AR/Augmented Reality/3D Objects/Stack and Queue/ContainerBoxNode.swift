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

final class ContainerBoxNode: BaseNode {
    
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
    
    lazy var openLeftDoorAction: SCNAction = {
        let horizontalDistance: CGFloat = 0.05
        let action = SCNAction.sequence([
            SCNAction.moveBy(x: -horizontalDistance, y: 0, z: 0, duration: animationDuration),
            SCNAction.moveBy(x: 0, y: squareLength, z: 0, duration: animationDuration),
            SCNAction.moveBy(x: horizontalDistance, y: 0, z: 0, duration: animationDuration)
            ])
        // BUG: Completion handler doesn't run with timing mode set to .easeInEaseOut
//        action.timingMode = .easeInEaseOut
        return action
    }()
    
    lazy var openRightDoorAction: SCNAction = {
        let horizontalDistance: CGFloat = 0.05
        let action = SCNAction.sequence([
            SCNAction.moveBy(x: horizontalDistance, y: 0, z: 0, duration: animationDuration),
            SCNAction.moveBy(x: 0, y: squareLength, z: 0, duration: animationDuration),
            SCNAction.moveBy(x: -horizontalDistance, y: 0, z: 0, duration: animationDuration)
            ])
//        action.timingMode = .easeInEaseOut
        return action
    }()
    
    var moveInsideContainerActionArray = [SCNAction]()
    var reversedMoveInsideContainerActionArray = [SCNAction]()
    var isAnimating = false
    
    var leftSideDoorOpen = false
    var rightDoorOpen = false
    
    var cubeNodes = [CubeNode]()
    
    weak var delegate: ContainerBoxNodeDelegate?
    
    // Rectangle
    lazy var rectanglePlane: SCNPlane = {
        let plane = SCNPlane(width: squareLength, height: trackerNodeLength)
        plane.firstMaterial?.isDoubleSided = true
        return plane
    }()
    
    override init(cubeLength: CGFloat, cubeSpacing: CGFloat, trackerNodeLength: CGFloat, lesson: Lesson) {
        super.init(cubeLength: cubeLength, cubeSpacing: cubeSpacing, trackerNodeLength: trackerNodeLength, lesson: lesson)
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
    
    // - Push cube nodes
    
    func pushCubeNodes() {
        guard !isAnimating else { return }
        isAnimating = true
        
        openSideDoors {}
        // BUG: Completion handler doesn't run with timing mode set to .easeInEaseOut
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + animationDuration * 3) {
            self.moveIn()
        }
    }
    
    func pushCubeNode() {
        guard !isAnimating else { return } // Refactore: Repeated code
        
        let index = moveInsideContainerActionArray.count
        guard index != cubeNodes.count else { return }
        
        let cubeNode = cubeNodes[index]
        let action = getMoveInsideContainerAction(withNode: cubeNode, index: index)
        
        openSideDoors {
            cubeNode.runAction(action)
        }
    }
    
    // - Pop cube nodes
    /**
     
     1, 0
     0, 0
     
     2, 0
     1, 1
     
     
     3, 0
     2, 1
     1, 2
     
     **/
    
    func popCubeNode() {
        moveInsideContainerActionArray.count -
        let index = lesson.name == .stack ? moveInsideContainerActionArray.count - 1 : cubeNodes.count - moveInsideContainerActionArray.count
        print("Move Inside Action Count:", moveInsideContainerActionArray.count)
        print("INDEX:", index)
        guard index >= 0 else {
            self.moveInsideContainerActionArray = []
            return
        }
        
        let cubeNode = cubeNodes[index]
        let action = getMoveOutsideContainerAction(withNode: cubeNode, index: index)
        cubeNode.runAction(action) {
            
        }
    }
    
    func popCubeNodes() {
        let index = moveInsideContainerActionArray.count - 1
        guard index >= 0 else {
            self.moveInsideContainerActionArray = []
            return
        }
        let node: CubeNode
        let action: SCNAction
        switch lesson.name {
        case .stack:
            moveInsideContainerActionArray.removeFirst()
            node = cubeNodes[index]
            action = reversedMoveInsideContainerActionArray[index]
        case .queue:
            moveInsideContainerActionArray.removeLast()
            node = cubeNodes[cubeNodes.count - 1 - index]
            action = getMoveOutsideContainerAction(withNode: node, index: index)
        default:
            fatalError()
        }
        
        node.runAction(action) {
            guard index - 1 == 0 else { return }
            switch self.lesson.name {
            case .stack:
                self.closeLeftDoor()
            case .queue:
                self.closeLeftDoorMoveDown(node: self.leftSquareNode, completion: {
                    self.delegate?.didFinishOrdering()
                })
                
                self.closeRightDoorMoveDown(node: self.rightSquareNode, completion: {
                    // Repeat action
                    self.pushCubeNodes()
                })
            default:
                break
            }
            self.isAnimating = false
            self.reversedMoveInsideContainerActionArray = []
        }
        
        delay(animationDuration * 2) {
            self.popCubeNodes()
        }
    }
    
    // - Doors
    
    func openSideDoors(completion: @escaping () -> ()) {
        guard !leftSideDoorOpen else { return completion() }
        switch lesson.name {
        case .stack:
            openLeftDoor {
                completion()
            }
        case .queue:
            openLeftDoor {
                completion()
            }
            openRightDoor { }
        default:
            break
        }
    }
    
    func openLeftDoor(completion: @escaping () -> ()) {
        leftSquareNode.runAction(openLeftDoorAction) {
            self.leftSideDoorOpen = true
            completion()
        }
    }
    
    func openRightDoor(completion: @escaping () -> ()) {
        rightSquareNode.runAction(openRightDoorAction) {
            self.rightDoorOpen = true
            completion()
        }
    }
    
    func moveIn(index: Int = 0) {
        guard index != cubeNodes.count else { return }
        let node = cubeNodes[index]
        
        let action = getMoveInsideContainerAction(withNode: node, index: index)
        node.runAction(action) {
            guard index + 1 == self.cubeNodes.count else { return }
            self.popCubeNodes()
        }
        
        delay(animationDuration * 2) {
            self.moveIn(index: index + 1)
        }
    }
    
    func closeLeftDoorMoveDown(node: SCNNode, completion: @escaping () -> ()) {
        node.runAction(openLeftDoorAction.reversed()) {
            completion()
        }
    }
    
    func closeLeftDoor() {
        leftSquareNode.runAction(openLeftDoorAction.reversed()) {
            self.delegate?.didFinishOrdering()
        }
    }
    
    func closeRightDoorMoveDown(node: SCNNode, completion: @escaping () -> ()) {
        node.runAction(openRightDoorAction.reversed()) {
            completion()
        }
    }
    
    func getMoveInsideContainerAction(withNode node: CubeNode, index: Int) -> SCNAction {
        let originalPosition = node.position
        var position = node.position
        position.x -= (Float(cubeSpacing + cubeLength) * Float(index + 1))
        var secondPosition = position
        secondPosition.y = self.position.y
        var finalPosition = secondPosition
        finalPosition.x += (Float(self.cubeSpacing + self.cubeLength) * Float(cubeNodes.count - index))
        
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
        moveInsideContainerActionArray.append(action)
        return action
    }
    
    func getMoveOutsideContainerAction(withNode node: CubeNode, index: Int) -> SCNAction {
        let action: SCNAction
        switch lesson.name {
        case .stack:
            action = reversedMoveInsideContainerActionArray[index]
            moveInsideContainerActionArray.removeFirst()
            reversedMoveInsideContainerActionArray.removeFirst()
        case .queue:
            action = node.getPopQueueAction()
//            var position = node.position
//            position.x += (Float(cubeSpacing + cubeLength) * Float(cubeNodes.count - index))
////            position.x += (Float(cubeSpacing + cubeLength) * Float(index + 1))
//            var secondPosition = position
//            secondPosition.y = node.airPosition.y
//            var finalPosition = secondPosition
//            finalPosition.x = node.airPosition.x
//
//            action = SCNAction.sequence([SCNAction.move(to: position, duration: animationDuration),
//                                             SCNAction.wait(duration: animationDuration),
//                                             SCNAction.move(to: secondPosition, duration: animationDuration),
//                                             SCNAction.move(to: finalPosition, duration: animationDuration)
//                ])
            moveInsideContainerActionArray.removeLast()
            reversedMoveInsideContainerActionArray.removeLast()
        default:
            fatalError()
        }
        return action
    }
    
    
    func delay(_ delay:Double, closure:@escaping ()->()) {
        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
    }
    
}
