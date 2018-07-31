//
//  Extensions.swift
//  Learn CS in AR
//
//  Created by Jayven Nhan on 4/26/18.
//  Copyright © 2018 Jayven Nhan. All rights reserved.
//

import Foundation
import ARKit

// UIColor Extension
extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
    }
    
    open class var darkBlue: UIColor {
        return UIColor.rgb(red: 29, green: 36, blue: 46)
    }
    
    open class var seperatorGray: UIColor {
        return UIColor.lightGray
    }
    
    struct TabBarItem {
        static let selected = UIColor.black
        static let unselected = UIColor.rgb(red: 106, green: 113, blue: 123)
    }
}

// UIView Extension
extension UIView {
    func addSubviews(views: [UIView]) {
        views.forEach { addSubview($0) }
    }
    
    // UIView Extension - Animation
    func fadeAndAway() {
        self.alpha = 0
        UIView.animate(withDuration: 1, animations: {
            self.alpha = 1
        }) { (complete) in
            UIView.animate(withDuration: 0.3, delay: 2, options: .curveEaseOut, animations: {
                self.alpha = 0
            }, completion: nil)
        }
    }
    
    func fadeIn() {
        self.alpha = 0
        UIView.animate(withDuration: 1, animations: {
            self.alpha = 1
        }, completion: nil)
    }
    
    func fadeOut() {
        self.alpha = 1
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseOut], animations: {
            self.alpha = 0
        }, completion: nil)
    }
    
    func fadeOutAndRemove(view: UIView) {
        UIView.animate(withDuration: 1, animations: {
            view.alpha = 0
        }) { (_) in
            view.removeFromSuperview()
        }
    }
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}

// String Extension
extension String  {
    func replaceWhiteSpaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
    
    func replacePunctuationCharacters() -> String {
        return components(separatedBy: .punctuationCharacters).joined()
    }
}


// float4x4 Extension
extension float4x4 {
    var translation: float3 {
        let translation = self.columns.3
        return float3(translation.x, translation.y, translation.z)
    }
}

// SCNScene Extension
extension SCNScene {
    func childNodesNode() -> SCNNode {
        let node = SCNNode()
        let sceneChildNodes = self.rootNode.childNodes
        for childNode in sceneChildNodes {
            node.addChildNode(childNode)
        }
        return node
    }
}

// UIColor Extension
extension UIColor {
    
    open class var transparentWhite: UIColor {
        return UIColor.white.withAlphaComponent(0.20)
    }
    
    open class var transparentTextBackgroundWhite: UIColor {
        return UIColor.white.withAlphaComponent(0.80)
    }
    
    open class var transparentTextBackgroundBlack: UIColor {
        return UIColor.black.withAlphaComponent(0.80)
    }
    
    open class var plantButtonBackground: UIColor {
        return UIColor.rgb(red: 46, green: 204, blue: 112)
    }
    
    open class var resetButtonBackground: UIColor {
        return UIColor.rgb(red: 250, green: 190, blue: 88)
    }
}

// SCNVector3 Extension
extension SCNVector3 {
    var defaultEulerAngles: SCNVector3 {
        return SCNVector3(0, eulerYAngle, 0)
    }
}

// SCNNode Extension
extension SCNNode {
    open class var tracker: SCNNode {
        guard let scene = SCNScene(named: "tracker.scn"),
            let node = scene.rootNode.childNode(withName: "tracker", recursively: true)
            else { return SCNNode() }
        node.scale = SCNVector3(scaleFactor, scaleFactor, scaleFactor)
        return node
    }
    
    func runFadeInAction(completion: @escaping () -> ()) {
        let fadeInAction = SCNAction.sequence([SCNAction.fadeIn(duration: animationDuration)])
        runAction(fadeInAction) {
            completion()
        }
    }
    
    func runFadeOutAction(completion: @escaping () -> ()) {
        let fadeOutAction = SCNAction.sequence([SCNAction.fadeOut(duration: animationDuration)])
        runAction(fadeOutAction) {
            completion()
        }
    }
}

// SCNAction Extension
extension SCNAction {
    
}

// ViewController Extension
extension UIViewController {
    func vector(from translation: float3) -> SCNVector3 {
        let x = translation.x
        let y = translation.y
        let z = translation.z
        return SCNVector3(x, y, z)
    }
    
    func add(nodes: [SCNNode], toSceneView sceneView: ARSCNView) {
        let rootNode = sceneView.scene.rootNode
        for node in nodes {
            rootNode.addChildNode(node)
        }
    }
    
    func cameraVectors(sceneView: ARSCNView) -> (SCNVector3, SCNVector3)? { // (direction, position)
        guard let frame = sceneView.session.currentFrame else { return nil }
        let transform = SCNMatrix4(frame.camera.transform)
        let directionFactor: Float = -5
        let direction = SCNVector3(directionFactor * transform.m31, directionFactor * transform.m32, directionFactor * transform.m33)
        let position = SCNVector3(transform.m41, transform.m42, transform.m43)
        return (direction, position)
    }
    
    func cameraDirection(sceneView: ARSCNView) -> SCNVector4 { // (direction, position)
        guard let frame = sceneView.session.currentFrame else { return SCNVector4(0,0,0,0) }
        let transform = SCNMatrix4(frame.camera.transform)
        let directionFactor: Float = -5
        let direction = SCNVector4(directionFactor * transform.m31, directionFactor * transform.m32, directionFactor * transform.m33, transform.m34)
        return direction
    }
    
    func floatBetween(_ first: Float,  and second: Float) -> Float { // random float between upper and lower bound (inclusive)
        return (Float(arc4random()) / Float(UInt32.max)) * (first - second) + second
    }
}

extension UIView {
    func fadeTransition(_ duration:CFTimeInterval) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name:
            kCAMediaTimingFunctionEaseInEaseOut)
        animation.type = kCATransitionFade
        animation.duration = duration
        layer.add(animation, forKey: kCATransitionFade)
    }
}

extension String {
    public static var tab: String {
        let numberOfSpaces = 4
        var index = 0
        var string = ""
        while index < numberOfSpaces {
            string += " "
            index += 1
        }
        return string
    }
}
