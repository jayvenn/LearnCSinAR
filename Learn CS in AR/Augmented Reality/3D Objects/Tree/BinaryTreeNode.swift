//
//  BinaryTreeNode.swift
//  Learn CS in AR
//
//  Created by Jayven Nhan on 8/1/18.
//  Copyright © 2018 Jayven Nhan. All rights reserved.
//

import UIKit
import SceneKit

final class BinaryTreeNode: BaseNode {
    enum NodeDirection {
        case left
        case right
    }
    
    var cubeNodes = [CubeNode]()
    var directionTubeNodes = [DirectionTubeNode]()
    var rootCubeNode: CubeNode?
    
    override init(cubeLength: CGFloat, cubeSpacing: CGFloat, trackerNodeLength: CGFloat, lesson: Lesson) {
        super.init(cubeLength: cubeLength, cubeSpacing: cubeSpacing, trackerNodeLength: trackerNodeLength, lesson: lesson)
        accessibilityLabel = "Binary tree"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func animate(with cubeNodes: [CubeNode]) {
        var cubeNodes = cubeNodes
        let middleNodeIndex = cubeNodes.count / 2
        let rootCubeNode = cubeNodes.remove(at: middleNodeIndex)
        guard rootCubeNode.leftNode == nil, rootCubeNode.rightNode == nil else { return }
        self.rootCubeNode = rootCubeNode
        moveUp(cubeNode: rootCubeNode, completion: {
            var index = 0
            while index < cubeNodes.count {
                print("Index:", index)
                let cubeNode = cubeNodes[index]
                
                if rootCubeNode.leftNode == nil, index % 2 == 0 {
                    self.move(cubeNode: cubeNode, relativeTo: rootCubeNode, nodeDirection: .left)
                    self.addDirectionTubeNodeBetween(currentNode: cubeNode, and: rootCubeNode, index: index, nodeDrection: .left, completion: {
                        
                    })
                    rootCubeNode.leftNode = cubeNode
                }
                
                if rootCubeNode.rightNode == nil, index % 2 != 0 {
                    self.move(cubeNode: cubeNode, relativeTo: rootCubeNode, nodeDirection: .right)
                    self.addDirectionTubeNodeBetween(currentNode: cubeNode, and: rootCubeNode, index: index, nodeDrection: .right, completion: {
                        let vector = SCNVector3(rootCubeNode.airPosition.x, rootCubeNode.airPosition.y, 0)
                        let action = SCNAction.move(to: vector, duration: animationDuration * 2)
                        action.timingMode = SCNActionTimingMode.easeInEaseOut
                        rootCubeNode.runAction(action) {
                            rootCubeNode.leftNode = nil
                            rootCubeNode.rightNode = nil
                        }
                    })
                    rootCubeNode.rightNode = cubeNode
                }
                
                index += 1
            }
        })
    }
    
    func moveUp(cubeNode: CubeNode, completion: @escaping () -> ()) {
        let y = cubeNode.position.y + Float(cubeNode.length + cubeSpacing)
        let vector = SCNVector3(0,y,0)
        let action = SCNAction.move(to: vector, duration: animationDuration)
        cubeNode.runAction(action) {
            completion()
        }
    }
    
//    func moveLeft(cubeNode: CubeNode, relativeTo rootNode: CubeNode) {
//        let x = rootNode.position.x - Float(rootNode.length + rootNode.length/2)
//        let y = rootNode.position.y - Float(rootNode.length + rootNode.cubeSpacing)
//        let vector = SCNVector3(x,y,0)
//        let action = SCNAction.move(to: vector, duration: animationDuration)
//        cubeNode.runAction(action)
//    }
    
    func move(cubeNode: CubeNode, relativeTo rootNode: CubeNode, nodeDirection: NodeDirection) {
        let nodeAndAHalf = Float(rootNode.length + rootNode.length/2)
        let addX = nodeDirection == .right ? nodeAndAHalf : -nodeAndAHalf
        let x = rootNode.position.x + addX
        let y = rootNode.position.y - Float(rootNode.length + rootNode.cubeSpacing)
        let vector = SCNVector3(x,y,0)
        let action = SCNAction.move(to: vector, duration: animationDuration)
        cubeNode.runAction(action)
    }
    
    func addDirectionTubeNodeBetween(currentNode: CubeNode, and rootNode: CubeNode, index: Int, nodeDrection: NodeDirection, completion: @escaping () -> ()) {
        print("DIRECTION:", nodeDrection == .left ? "Left" : "Right")
        let multipler: CGFloat = nodeDrection == .left ? 1 : -1
//        let directionTubeNode = DirectionTubeNode(cubeLength: cubeLength, cubeSpacing: cubeSpacing, index: index, isDoubly: false)
        let directionTubeNode = DirectionTubeNode(cubeLength: cubeLength, cubeSpacing: cubeSpacing, index: index, isDoubly: false, isDiagonal: true)
        let zRotation = CGFloat(45 * 3 * degreesToRadians * multipler)
        directionTubeNode.eulerAngles.z = Float(zRotation)
        
        let x = ((currentNode.position.x - rootNode.position.x * Float(multipler)) / 2)
        let y = (currentNode.position.y - rootNode.position.y) / 2
        
        let position = SCNVector3(x,y,0)
        directionTubeNode.position = position
        
        directionTubeNode.animate {
            completion()
        }
        rootNode.addChildNode(directionTubeNode)
    }
    
}
