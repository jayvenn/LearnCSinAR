//
//  DirectionTubeNode.swift
//  Learn CS in AR
//
//  Created by Jayven Nhan on 7/31/18.
//  Copyright © 2018 Jayven Nhan. All rights reserved.
//

import UIKit
import SceneKit

final class DirectionTubeNode: SCNNode {
    
    let cubeSpacing: CGFloat
    let cubeLength: CGFloat
    let index: Int
    let isDoubly: Bool
    
    var height: CGFloat {
        return cubeSpacing
    }
    
    lazy var radius = cubeSpacing / 4
    
    lazy var cylinder: SCNCylinder = {
        let cylinder = SCNCylinder(radius: radius, height: cubeSpacing)
        cylinder.firstMaterial?.diffuse.contents = UIColor.white.withAlphaComponent(0) // 0.7
        return cylinder
    }()
    
    lazy var directionBallNode: DirectionBallNode = {
        let node = DirectionBallNode(radius: radius / 1.5, cylinderHeight: cylinder.height, isDoubly: isDoubly)
        return node
    }()
    
    init(cubeLength: CGFloat, cubeSpacing: CGFloat, index: Int, isDoubly: Bool = false) {
        self.index = index
        self.cubeLength = cubeLength
        self.cubeSpacing = cubeSpacing
        self.isDoubly = isDoubly
        super.init()
        opacity = 0
        setGeometry()
        setOrientation()
        addDirectionBall()
        accessibilityLabel = "Direction tube"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// - Animations
extension DirectionTubeNode {
    func animate(completion: @escaping () -> ()) {
        runFadeInAction {
            self.directionBallNode.animate {
                self.runFadeOutAction {
                    self.removeFromParentNode()
                    print("Complete Direction Tube Node Animation, Index: \(self.index)")
                    completion()
                }
            }
        }
    }
}

// - Overheads
extension DirectionTubeNode {
    func setGeometry() {
        geometry = cylinder
    }
    
    func setOrientation() {
        position.x = Float(-(cubeLength/2) - (cubeSpacing / 2))
        eulerAngles.z = Float(-90 * degreesToRadians)
    }
    
    func addDirectionBall() {
        addChildNode(directionBallNode)
    }
}

// - Direction ball
extension DirectionTubeNode {

}
