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
    
    private let fadeInAction: SCNAction = {
        return SCNAction.sequence([SCNAction.fadeIn(duration: fadeInAnimationDuration)])
    }()
    
    // Square
    private lazy var squareLength: CGFloat = cubeLength + 0.05
    private lazy var squarePlane: SCNPlane = {
        let plane = SCNPlane(width: squareLength, height: squareLength)
        plane.firstMaterial?.isDoubleSided = true
        return plane
    }()
    
    private var halfTrackerNodeLength: Float {
        return Float(trackerNodeLength / 2)
    }
    
    private lazy var rightSquareNode = SCNNode(geometry: squarePlane)
    private lazy var leftSquareNode = SCNNode(geometry: squarePlane)
    
    private lazy var openLeftDoorAction: SCNAction = {
        let horizontalDistance: CGFloat = 0.05
        let action = SCNAction.sequence([
            SCNAction.moveBy(x: -horizontalDistance, y: 0, z: 0, duration: animationDuration),
            SCNAction.moveBy(x: 0, y: squareLength, z: 0, duration: animationDuration),
            SCNAction.moveBy(x: horizontalDistance, y: 0, z: 0, duration: animationDuration)
            ])
        // BUG: Completion handler doesn't run with timing mode set to .easeInEaseOut
        action.timingMode = .easeInEaseOut
        return action
    }()
    
    private lazy var openRightDoorAction: SCNAction = {
        let horizontalDistance: CGFloat = 0.05
        let action = SCNAction.sequence([
            SCNAction.moveBy(x: horizontalDistance, y: 0, z: 0, duration: animationDuration),
            SCNAction.moveBy(x: 0, y: squareLength, z: 0, duration: animationDuration),
            SCNAction.moveBy(x: -horizontalDistance, y: 0, z: 0, duration: animationDuration)
            ])
        action.timingMode = .easeInEaseOut
        return action
    }()
    
    private var leftDoorOpen = false
    private var rightDoorOpen = false
    
    private var isAnimating = false
    
    var cubeNodes = [CubeNode]() {
        didSet {
            for (index, node) in cubeNodes.enumerated() {
                self.setActionFor(node: node, index: index)
            }
            print("CUBE NODES COUNT:", cubeNodes.count)
        }
    }
    
    private var index: Int = 0 {
        didSet {
            print("INDEX:", index)
        }
    }
    
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
    
    private func generateNode() {
        generateLeftSquareNode()
        generateRightSquareNode()
        generateRectangleNodes()
    }
    
    private func setIndex(increment: Bool, completion: @escaping () -> ()) {
        print("Cube Node Index:", index)
        let cubeNode: CubeNode
        switch increment {
        case true:
            guard index < cubeNodes.count else { return }
            cubeNode = cubeNodes[index]
            openSideDoors {
                cubeNode.runAction(cubeNode.action) {
                    completion()
                }
            }
            index += 1
        case false:
            guard index > 0 else { return }
            index -= 1
            let theIndex: Int
            let action: SCNAction
            if lesson.name == .stack {
                theIndex = index
            } else {
                theIndex = cubeNodes.count - 1 - index
            }
            
            cubeNode = cubeNodes[theIndex]
            if lesson.name == .stack {
                action = cubeNode.reversedAction
            } else {
                action = cubeNode.getPopQueueAction()
            }
            cubeNode.runAction(action) {
                if self.lesson.name == .stack {
                    guard theIndex == 0 else { return completion() }
                    self.closeSideDoors(index: theIndex) {
                        completion()
                    }
                } else {
                    guard theIndex == self.cubeNodes.count - 1 else { return completion() }
                    self.closeSideDoors(index: theIndex) {
                        completion()
                    }
                }
            }
        }
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
    func pushCubeNode(completion: @escaping () -> ()) {
        setIndex(increment: true) { completion() }
    }
    
    func pushCubeNodes() {
        guard index != cubeNodes.count else { return popCubeNodes() }
        pushCubeNode {
            self.pushCubeNodes()
        }
    }
    
    // - Pop cube nodes
    func popCubeNode(completion: @escaping () -> ()) {
        setIndex(increment: false) { completion() }
    }
    
    func popCubeNodes() {
        guard index >= 0 else { return }
        popCubeNode {
            self.popCubeNodes()
        }
    }
    
    // - Doors
    func openSideDoors(completion: @escaping () -> ()) {
        guard index == 0 else { return completion() }
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
    
    func closeSideDoors(index: Int, completion: @escaping () -> ()) {
        switch lesson.name {
        case .stack:
            closeLeftDoor {
                completion()
            }
        case .queue:
            closeLeftDoor {
                completion()
            }
            closeRightDoor { }
        default:
            break
        }
    }
    
    func openLeftDoor(completion: @escaping () -> ()) {
        leftSquareNode.runAction(openLeftDoorAction) {
            self.leftDoorOpen = true
            completion()
        }
    }
    
    func openRightDoor(completion: @escaping () -> ()) {
        rightSquareNode.runAction(openRightDoorAction) {
            self.rightDoorOpen = true
            completion()
        }
    }
    
    func closeLeftDoor(completion: @escaping () -> ()) {
        leftSquareNode.runAction(openLeftDoorAction.reversed()) {
            self.leftDoorOpen = false
            completion()
        }
    }
    
    func closeRightDoor(completion: @escaping () -> ()) {
        rightSquareNode.runAction(openRightDoorAction.reversed()) {
            self.rightDoorOpen = false
            completion()
        }
    }
    
    private func setActionFor(node: CubeNode, index: Int) {
        let originalPosition = node.position
        var position = node.position
        position.x -= (Float(cubeSpacing + cubeLength) * Float(index + 1))
        var secondPosition = position
        secondPosition.y = self.position.y
        var finalPosition = secondPosition
        finalPosition.x += (Float(self.cubeSpacing + self.cubeLength) * Float(cubeNodes.count - index))
        
        let duration = animationDuration
        let action = SCNAction.sequence([
            SCNAction.move(to: position, duration: duration),
            SCNAction.wait(duration: duration),
            SCNAction.move(to: secondPosition, duration: duration),
            SCNAction.move(to: finalPosition, duration: duration)
            ])
        
        let reversedAction: SCNAction
        
        if lesson.name == .stack {
            reversedAction = SCNAction.sequence([
                SCNAction.move(to: finalPosition, duration: duration),
                SCNAction.move(to: secondPosition, duration: duration),
                SCNAction.wait(duration: duration),
                SCNAction.move(to: position, duration: duration),
                SCNAction.move(to: originalPosition, duration: duration)
                ])
        } else {
            reversedAction = node.getPopQueueAction()
        }
        
        
        node.action = action
        node.reversedAction = reversedAction
    }
    
    func delay(_ delay:Double, closure:@escaping ()->()) {
        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
    }
    
}
