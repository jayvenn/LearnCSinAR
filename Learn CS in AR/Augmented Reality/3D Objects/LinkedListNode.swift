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
    override init(cubeLength: CGFloat, cubeSpacing: CGFloat, trackerNodeLength: CGFloat) {
        super.init(cubeLength: cubeLength, cubeSpacing: cubeSpacing, trackerNodeLength: trackerNodeLength)
        opacity = 0
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func generateNode(basedOn nodes: [SCNNode]) {
        let tube = SCNTube(innerRadius: cubeSpacing / 2, outerRadius: cubeSpacing, height: cubeSpacing)
        tube.firstMaterial?.diffuse.contents = UIColor.white.withAlphaComponent(0.7)
        
        var index = 0
        while index < nodes.count - 1 {
            let node = nodes[index + 1]
            let tubeNode = SCNNode(geometry: tube)
            tubeNode.position.x = Float(-(cubeLength/2) - cubeSpacing)
            tubeNode.eulerAngles.x = Float(-90 * degreesToRadians)
            node.addChildNode(tubeNode)
            index += 1
        }
    }
}
