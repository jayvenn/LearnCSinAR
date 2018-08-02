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
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func animate(with cubeNodes: [CubeNode]) {
        var cubeNodes = cubeNodes
        let middleNodeIndex = cubeNodes.count / 2
        let rootCubeNode = cubeNodes.remove(at: middleNodeIndex)
        self.rootCubeNode = rootCubeNode
        moveUp(cubeNode: rootCubeNode, completion: {
            var index = 0
            while index < cubeNodes.count {
                print("Index:", index)
                let cubeNode = cubeNodes[index]
                
                if index % 2 != 0, let leftNode = rootCubeNode.leftNode {
                    self.move(cubeNode: leftNode, relativeTo: rootCubeNode, nodeDirection: .left)
                    self.addDirectionTubeNodeBetween(currentNode: leftNode, and: rootCubeNode, index: index, nodeDrection: .left)
                } else if rootCubeNode.leftNode == nil {
                    rootCubeNode.leftNode = cubeNode
                    self.move(cubeNode: cubeNode, relativeTo: rootCubeNode, nodeDirection: .left)
                } else {
                    
//                    self.addDirectionTubeNodeBetween(currentNode: cubeNode, and: rootCubeNode, index: index, nodeDrection: .left)
                }
                
                if index % 2 == 0, let rightNode = rootCubeNode.rightNode {
                    self.move(cubeNode: rightNode, relativeTo: rootCubeNode, nodeDirection: .right)
//                    self.addDirectionTubeNodeBetween(currentNode: rightNode, and: rootCubeNode, index: index, nodeDrection: .right)
                } else if rootCubeNode.rightNode == nil {
                    rootCubeNode.rightNode = cubeNode
                    self.move(cubeNode: cubeNode, relativeTo: rootCubeNode, nodeDirection: .right)
                    self.addDirectionTubeNodeBetween(currentNode: cubeNode, and: rootCubeNode, index: index, nodeDrection: .right)
                } else {
                    
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
    
    func addDirectionTubeNodeBetween(currentNode: CubeNode, and rootNode: CubeNode, index: Int, nodeDrection: NodeDirection) {
        print("DIRECTION:", nodeDrection == .left ? "Left" : "Right")
        let multipler: CGFloat = nodeDrection == .left ? 1 : -1
        let directionTubeNode = DirectionTubeNode(cubeLength: cubeLength, cubeSpacing: cubeSpacing, index: index)
        directionTubeNode.opacity = 1
        let zRotation = CGFloat(45 * 3 * degreesToRadians * -multipler)
        directionTubeNode.eulerAngles.z = Float(zRotation)
//        let action = SCNAction.rotateTo(x: 0, y: 0, z: zRotation, duration: 1)
//        directionTubeNode.runAction(action)
        
        let x = ((currentNode.position.x - rootNode.position.x * Float(multipler)) / 2)
        let y = (currentNode.position.y - rootNode.position.y) / 2
//        let z = (currentNode.position.z - rootNode.position.z) / 2
        let position = SCNVector3(x,y,0)
        directionTubeNode.position = position
        
//        directionTubeNode.animate {
//
//        }
        rootNode.addChildNode(directionTubeNode)
    }
    
}
