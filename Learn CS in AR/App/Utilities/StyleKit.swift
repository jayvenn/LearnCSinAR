//
//  StyleKit.swift
//  Learn CS in AR
//
//  Created by Jayven Nhan on 4/26/18.
//  Copyright © 2018 Jayven Nhan. All rights reserved.
//

import UIKit

class StyleKit: NSObject {
    
    //MARK: - Canvas Drawings
    
    /// Page 1
    
    class func drawAugmentedRealityCube(frame targetFrame: CGRect = CGRect(x: 0, y: 0, width: 28, height: 26), resizing: ResizingBehavior = .aspectFit) {
        /// General Declarations
        let context = UIGraphicsGetCurrentContext()!
        
        /// Resize to Target Frame
        context.saveGState()
        let resizedFrame = resizing.apply(rect: CGRect(x: 0, y: 0, width: 28, height: 26), target: targetFrame)
        context.translateBy(x: resizedFrame.minX, y: resizedFrame.minY)
        context.scaleBy(x: resizedFrame.width / 28, y: resizedFrame.height / 26)
        
        /// Group
        do {
            context.saveGState()
            context.translateBy(x: 1, y: 0)
            
            /// Shape
            let shape = UIBezierPath()
            shape.move(to: CGPoint(x: 0.41, y: 0))
            shape.addCurve(to: CGPoint(x: 0, y: 0.42), controlPoint1: CGPoint(x: 0.18, y: 0), controlPoint2: CGPoint(x: 0, y: 0.19))
            shape.addLine(to: CGPoint(x: 0, y: 2.09))
            shape.addCurve(to: CGPoint(x: 0.41, y: 2.51), controlPoint1: CGPoint(x: 0, y: 2.33), controlPoint2: CGPoint(x: 0.18, y: 2.51))
            shape.addCurve(to: CGPoint(x: 0.82, y: 2.09), controlPoint1: CGPoint(x: 0.64, y: 2.51), controlPoint2: CGPoint(x: 0.82, y: 2.33))
            shape.addLine(to: CGPoint(x: 0.82, y: 0.42))
            shape.addCurve(to: CGPoint(x: 0.41, y: 0), controlPoint1: CGPoint(x: 0.82, y: 0.19), controlPoint2: CGPoint(x: 0.64, y: 0))
            shape.close()
            shape.move(to: CGPoint(x: 0.41, y: 0))
            context.saveGState()
            context.translateBy(x: 12.59, y: 5.96)
            UIColor.black.setFill()
            shape.fill()
            context.restoreGState()
            
            /// Shape
            let shape2 = UIBezierPath()
            shape2.move(to: CGPoint(x: 22.99, y: 17.82))
            shape2.addLine(to: CGPoint(x: 22.99, y: 12.62))
            shape2.addCurve(to: CGPoint(x: 22.58, y: 12.21), controlPoint1: CGPoint(x: 22.99, y: 12.39), controlPoint2: CGPoint(x: 22.8, y: 12.21))
            shape2.addCurve(to: CGPoint(x: 22.17, y: 12.62), controlPoint1: CGPoint(x: 22.35, y: 12.21), controlPoint2: CGPoint(x: 22.17, y: 12.39))
            shape2.addLine(to: CGPoint(x: 22.17, y: 17.82))
            shape2.addCurve(to: CGPoint(x: 21.42, y: 18.24), controlPoint1: CGPoint(x: 21.88, y: 17.89), controlPoint2: CGPoint(x: 21.63, y: 18.04))
            shape2.addLine(to: CGPoint(x: 20.24, y: 17.65))
            shape2.addCurve(to: CGPoint(x: 19.69, y: 17.84), controlPoint1: CGPoint(x: 20.04, y: 17.54), controlPoint2: CGPoint(x: 19.79, y: 17.63))
            shape2.addCurve(to: CGPoint(x: 19.88, y: 18.4), controlPoint1: CGPoint(x: 19.59, y: 18.04), controlPoint2: CGPoint(x: 19.67, y: 18.3))
            shape2.addLine(to: CGPoint(x: 20.98, y: 18.95))
            shape2.addCurve(to: CGPoint(x: 20.91, y: 19.47), controlPoint1: CGPoint(x: 20.93, y: 19.11), controlPoint2: CGPoint(x: 20.91, y: 19.29))
            shape2.addCurve(to: CGPoint(x: 20.92, y: 19.71), controlPoint1: CGPoint(x: 20.91, y: 19.55), controlPoint2: CGPoint(x: 20.91, y: 19.63))
            shape2.addLine(to: CGPoint(x: 13.44, y: 22.99))
            shape2.addCurve(to: CGPoint(x: 12.54, y: 22.4), controlPoint1: CGPoint(x: 13.21, y: 22.71), controlPoint2: CGPoint(x: 12.9, y: 22.49))
            shape2.addLine(to: CGPoint(x: 12.54, y: 14.72))
            shape2.addCurve(to: CGPoint(x: 12.68, y: 14.75), controlPoint1: CGPoint(x: 12.59, y: 14.74), controlPoint2: CGPoint(x: 12.63, y: 14.75))
            shape2.addCurve(to: CGPoint(x: 13.05, y: 14.51), controlPoint1: CGPoint(x: 12.83, y: 14.75), controlPoint2: CGPoint(x: 12.98, y: 14.66))
            shape2.addCurve(to: CGPoint(x: 12.86, y: 13.95), controlPoint1: CGPoint(x: 13.15, y: 14.3), controlPoint2: CGPoint(x: 13.06, y: 14.05))
            shape2.addLine(to: CGPoint(x: 12.54, y: 13.79))
            shape2.addLine(to: CGPoint(x: 12.54, y: 12.68))
            shape2.addCurve(to: CGPoint(x: 13.8, y: 11.03), controlPoint1: CGPoint(x: 13.26, y: 12.49), controlPoint2: CGPoint(x: 13.8, y: 11.82))
            shape2.addCurve(to: CGPoint(x: 13.78, y: 10.75), controlPoint1: CGPoint(x: 13.8, y: 10.93), controlPoint2: CGPoint(x: 13.79, y: 10.84))
            shape2.addLine(to: CGPoint(x: 21.26, y: 7.41))
            shape2.addCurve(to: CGPoint(x: 22.17, y: 8.01), controlPoint1: CGPoint(x: 21.48, y: 7.7), controlPoint2: CGPoint(x: 21.8, y: 7.92))
            shape2.addLine(to: CGPoint(x: 22.17, y: 9.61))
            shape2.addCurve(to: CGPoint(x: 22.58, y: 10.03), controlPoint1: CGPoint(x: 22.17, y: 9.84), controlPoint2: CGPoint(x: 22.35, y: 10.03))
            shape2.addCurve(to: CGPoint(x: 22.99, y: 9.61), controlPoint1: CGPoint(x: 22.8, y: 10.03), controlPoint2: CGPoint(x: 22.99, y: 9.84))
            shape2.addLine(to: CGPoint(x: 22.99, y: 8.01))
            shape2.addCurve(to: CGPoint(x: 24.25, y: 6.37), controlPoint1: CGPoint(x: 23.71, y: 7.83), controlPoint2: CGPoint(x: 24.25, y: 7.16))
            shape2.addCurve(to: CGPoint(x: 22.58, y: 4.66), controlPoint1: CGPoint(x: 24.25, y: 5.43), controlPoint2: CGPoint(x: 23.5, y: 4.66))
            shape2.addCurve(to: CGPoint(x: 21.26, y: 5.32), controlPoint1: CGPoint(x: 22.04, y: 4.66), controlPoint2: CGPoint(x: 21.57, y: 4.92))
            shape2.addLine(to: CGPoint(x: 13.78, y: 1.98))
            shape2.addCurve(to: CGPoint(x: 13.8, y: 1.7), controlPoint1: CGPoint(x: 13.79, y: 1.89), controlPoint2: CGPoint(x: 13.8, y: 1.8))
            shape2.addCurve(to: CGPoint(x: 12.13, y: 0), controlPoint1: CGPoint(x: 13.8, y: 0.76), controlPoint2: CGPoint(x: 13.05, y: 0))
            shape2.addCurve(to: CGPoint(x: 10.46, y: 1.7), controlPoint1: CGPoint(x: 11.21, y: 0), controlPoint2: CGPoint(x: 10.46, y: 0.76))
            shape2.addCurve(to: CGPoint(x: 10.48, y: 1.98), controlPoint1: CGPoint(x: 10.46, y: 1.8), controlPoint2: CGPoint(x: 10.47, y: 1.89))
            shape2.addLine(to: CGPoint(x: 2.99, y: 5.32))
            shape2.addCurve(to: CGPoint(x: 1.67, y: 4.66), controlPoint1: CGPoint(x: 2.68, y: 4.92), controlPoint2: CGPoint(x: 2.21, y: 4.66))
            shape2.addCurve(to: CGPoint(x: 0, y: 6.37), controlPoint1: CGPoint(x: 0.75, y: 4.66), controlPoint2: CGPoint(x: 0, y: 5.43))
            shape2.addCurve(to: CGPoint(x: 1.27, y: 8.02), controlPoint1: CGPoint(x: 0, y: 7.16), controlPoint2: CGPoint(x: 0.54, y: 7.83))
            shape2.addLine(to: CGPoint(x: 1.27, y: 17.82))
            shape2.addCurve(to: CGPoint(x: 0, y: 19.47), controlPoint1: CGPoint(x: 0.54, y: 18), controlPoint2: CGPoint(x: 0, y: 18.67))
            shape2.addCurve(to: CGPoint(x: 1.67, y: 21.17), controlPoint1: CGPoint(x: 0, y: 20.41), controlPoint2: CGPoint(x: 0.75, y: 21.17))
            shape2.addCurve(to: CGPoint(x: 3.01, y: 20.48), controlPoint1: CGPoint(x: 2.22, y: 21.17), controlPoint2: CGPoint(x: 2.71, y: 20.9))
            shape2.addLine(to: CGPoint(x: 4.96, y: 21.33))
            shape2.addCurve(to: CGPoint(x: 5.13, y: 21.37), controlPoint1: CGPoint(x: 5.02, y: 21.36), controlPoint2: CGPoint(x: 5.07, y: 21.37))
            shape2.addCurve(to: CGPoint(x: 5.5, y: 21.12), controlPoint1: CGPoint(x: 5.29, y: 21.37), controlPoint2: CGPoint(x: 5.44, y: 21.27))
            shape2.addCurve(to: CGPoint(x: 5.29, y: 20.56), controlPoint1: CGPoint(x: 5.59, y: 20.9), controlPoint2: CGPoint(x: 5.5, y: 20.66))
            shape2.addLine(to: CGPoint(x: 3.33, y: 19.7))
            shape2.addCurve(to: CGPoint(x: 3.34, y: 19.47), controlPoint1: CGPoint(x: 3.34, y: 19.63), controlPoint2: CGPoint(x: 3.34, y: 19.55))
            shape2.addCurve(to: CGPoint(x: 3.26, y: 18.96), controlPoint1: CGPoint(x: 3.34, y: 19.29), controlPoint2: CGPoint(x: 3.31, y: 19.12))
            shape2.addLine(to: CGPoint(x: 4.38, y: 18.4))
            shape2.addCurve(to: CGPoint(x: 4.57, y: 17.84), controlPoint1: CGPoint(x: 4.58, y: 18.3), controlPoint2: CGPoint(x: 4.67, y: 18.04))
            shape2.addCurve(to: CGPoint(x: 4.02, y: 17.65), controlPoint1: CGPoint(x: 4.47, y: 17.63), controlPoint2: CGPoint(x: 4.22, y: 17.54))
            shape2.addLine(to: CGPoint(x: 2.83, y: 18.24))
            shape2.addCurve(to: CGPoint(x: 2.09, y: 17.82), controlPoint1: CGPoint(x: 2.62, y: 18.04), controlPoint2: CGPoint(x: 2.37, y: 17.9))
            shape2.addLine(to: CGPoint(x: 2.09, y: 8.01))
            shape2.addCurve(to: CGPoint(x: 2.99, y: 7.41), controlPoint1: CGPoint(x: 2.45, y: 7.92), controlPoint2: CGPoint(x: 2.77, y: 7.7))
            shape2.addLine(to: CGPoint(x: 10.48, y: 10.75))
            shape2.addCurve(to: CGPoint(x: 10.46, y: 11.03), controlPoint1: CGPoint(x: 10.47, y: 10.84), controlPoint2: CGPoint(x: 10.46, y: 10.93))
            shape2.addCurve(to: CGPoint(x: 11.72, y: 12.68), controlPoint1: CGPoint(x: 10.46, y: 11.82), controlPoint2: CGPoint(x: 10.99, y: 12.49))
            shape2.addLine(to: CGPoint(x: 11.72, y: 13.79))
            shape2.addLine(to: CGPoint(x: 11.4, y: 13.95))
            shape2.addCurve(to: CGPoint(x: 11.21, y: 14.51), controlPoint1: CGPoint(x: 11.19, y: 14.05), controlPoint2: CGPoint(x: 11.11, y: 14.3))
            shape2.addCurve(to: CGPoint(x: 11.58, y: 14.75), controlPoint1: CGPoint(x: 11.28, y: 14.66), controlPoint2: CGPoint(x: 11.43, y: 14.75))
            shape2.addCurve(to: CGPoint(x: 11.72, y: 14.72), controlPoint1: CGPoint(x: 11.63, y: 14.75), controlPoint2: CGPoint(x: 11.67, y: 14.74))
            shape2.addLine(to: CGPoint(x: 11.72, y: 22.4))
            shape2.addCurve(to: CGPoint(x: 10.82, y: 22.99), controlPoint1: CGPoint(x: 11.36, y: 22.49), controlPoint2: CGPoint(x: 11.05, y: 22.71))
            shape2.addLine(to: CGPoint(x: 7.96, y: 21.74))
            shape2.addCurve(to: CGPoint(x: 7.42, y: 21.95), controlPoint1: CGPoint(x: 7.75, y: 21.64), controlPoint2: CGPoint(x: 7.51, y: 21.74))
            shape2.addCurve(to: CGPoint(x: 7.63, y: 22.51), controlPoint1: CGPoint(x: 7.33, y: 22.17), controlPoint2: CGPoint(x: 7.42, y: 22.41))
            shape2.addLine(to: CGPoint(x: 10.48, y: 23.76))
            shape2.addCurve(to: CGPoint(x: 10.46, y: 24.05), controlPoint1: CGPoint(x: 10.47, y: 23.85), controlPoint2: CGPoint(x: 10.46, y: 23.95))
            shape2.addCurve(to: CGPoint(x: 12.13, y: 25.75), controlPoint1: CGPoint(x: 10.46, y: 24.99), controlPoint2: CGPoint(x: 11.21, y: 25.75))
            shape2.addCurve(to: CGPoint(x: 13.8, y: 24.05), controlPoint1: CGPoint(x: 13.05, y: 25.75), controlPoint2: CGPoint(x: 13.8, y: 24.99))
            shape2.addCurve(to: CGPoint(x: 13.77, y: 23.76), controlPoint1: CGPoint(x: 13.8, y: 23.95), controlPoint2: CGPoint(x: 13.79, y: 23.85))
            shape2.addLine(to: CGPoint(x: 21.24, y: 20.48))
            shape2.addCurve(to: CGPoint(x: 22.58, y: 21.17), controlPoint1: CGPoint(x: 21.54, y: 20.9), controlPoint2: CGPoint(x: 22.03, y: 21.17))
            shape2.addCurve(to: CGPoint(x: 24.25, y: 19.47), controlPoint1: CGPoint(x: 23.5, y: 21.17), controlPoint2: CGPoint(x: 24.25, y: 20.41))
            shape2.addCurve(to: CGPoint(x: 22.99, y: 17.82), controlPoint1: CGPoint(x: 24.25, y: 18.67), controlPoint2: CGPoint(x: 23.71, y: 18.01))
            shape2.close()
            shape2.move(to: CGPoint(x: 22.58, y: 5.5))
            shape2.addCurve(to: CGPoint(x: 23.43, y: 6.37), controlPoint1: CGPoint(x: 23.04, y: 5.5), controlPoint2: CGPoint(x: 23.43, y: 5.89))
            shape2.addCurve(to: CGPoint(x: 22.58, y: 7.23), controlPoint1: CGPoint(x: 23.43, y: 6.84), controlPoint2: CGPoint(x: 23.04, y: 7.23))
            shape2.addCurve(to: CGPoint(x: 21.73, y: 6.37), controlPoint1: CGPoint(x: 22.11, y: 7.23), controlPoint2: CGPoint(x: 21.73, y: 6.84))
            shape2.addCurve(to: CGPoint(x: 22.58, y: 5.5), controlPoint1: CGPoint(x: 21.73, y: 5.89), controlPoint2: CGPoint(x: 22.11, y: 5.5))
            shape2.close()
            shape2.move(to: CGPoint(x: 2.52, y: 19.47))
            shape2.addCurve(to: CGPoint(x: 1.67, y: 20.33), controlPoint1: CGPoint(x: 2.52, y: 19.94), controlPoint2: CGPoint(x: 2.14, y: 20.33))
            shape2.addCurve(to: CGPoint(x: 0.82, y: 19.47), controlPoint1: CGPoint(x: 1.2, y: 20.33), controlPoint2: CGPoint(x: 0.82, y: 19.94))
            shape2.addCurve(to: CGPoint(x: 1.67, y: 18.6), controlPoint1: CGPoint(x: 0.82, y: 18.99), controlPoint2: CGPoint(x: 1.2, y: 18.6))
            shape2.addCurve(to: CGPoint(x: 2.52, y: 19.47), controlPoint1: CGPoint(x: 2.14, y: 18.6), controlPoint2: CGPoint(x: 2.52, y: 18.99))
            shape2.close()
            shape2.move(to: CGPoint(x: 2.46, y: 6.69))
            shape2.addCurve(to: CGPoint(x: 2.45, y: 6.71), controlPoint1: CGPoint(x: 2.45, y: 6.7), controlPoint2: CGPoint(x: 2.45, y: 6.7))
            shape2.addCurve(to: CGPoint(x: 2.45, y: 6.72), controlPoint1: CGPoint(x: 2.45, y: 6.71), controlPoint2: CGPoint(x: 2.45, y: 6.71))
            shape2.addCurve(to: CGPoint(x: 1.67, y: 7.23), controlPoint1: CGPoint(x: 2.31, y: 7.02), controlPoint2: CGPoint(x: 2.02, y: 7.23))
            shape2.addCurve(to: CGPoint(x: 0.82, y: 6.37), controlPoint1: CGPoint(x: 1.2, y: 7.23), controlPoint2: CGPoint(x: 0.82, y: 6.84))
            shape2.addCurve(to: CGPoint(x: 1.67, y: 5.5), controlPoint1: CGPoint(x: 0.82, y: 5.89), controlPoint2: CGPoint(x: 1.2, y: 5.5))
            shape2.addCurve(to: CGPoint(x: 2.52, y: 6.37), controlPoint1: CGPoint(x: 2.14, y: 5.5), controlPoint2: CGPoint(x: 2.52, y: 5.89))
            shape2.addCurve(to: CGPoint(x: 2.46, y: 6.69), controlPoint1: CGPoint(x: 2.52, y: 6.48), controlPoint2: CGPoint(x: 2.5, y: 6.59))
            shape2.close()
            shape2.move(to: CGPoint(x: 12.13, y: 0.84))
            shape2.addCurve(to: CGPoint(x: 12.98, y: 1.7), controlPoint1: CGPoint(x: 12.6, y: 0.84), controlPoint2: CGPoint(x: 12.98, y: 1.23))
            shape2.addCurve(to: CGPoint(x: 12.13, y: 2.57), controlPoint1: CGPoint(x: 12.98, y: 2.18), controlPoint2: CGPoint(x: 12.6, y: 2.57))
            shape2.addCurve(to: CGPoint(x: 11.28, y: 1.7), controlPoint1: CGPoint(x: 11.66, y: 2.57), controlPoint2: CGPoint(x: 11.28, y: 2.18))
            shape2.addCurve(to: CGPoint(x: 12.13, y: 0.84), controlPoint1: CGPoint(x: 11.28, y: 1.23), controlPoint2: CGPoint(x: 11.66, y: 0.84))
            shape2.close()
            shape2.move(to: CGPoint(x: 10.81, y: 9.98))
            shape2.addLine(to: CGPoint(x: 3.32, y: 6.64))
            shape2.addCurve(to: CGPoint(x: 3.34, y: 6.37), controlPoint1: CGPoint(x: 3.33, y: 6.55), controlPoint2: CGPoint(x: 3.34, y: 6.46))
            shape2.addCurve(to: CGPoint(x: 3.32, y: 6.09), controlPoint1: CGPoint(x: 3.34, y: 6.27), controlPoint2: CGPoint(x: 3.33, y: 6.18))
            shape2.addLine(to: CGPoint(x: 10.81, y: 2.75))
            shape2.addCurve(to: CGPoint(x: 11.72, y: 3.35), controlPoint1: CGPoint(x: 11.04, y: 3.04), controlPoint2: CGPoint(x: 11.35, y: 3.26))
            shape2.addLine(to: CGPoint(x: 11.72, y: 4.66))
            shape2.addCurve(to: CGPoint(x: 12.13, y: 5.08), controlPoint1: CGPoint(x: 11.72, y: 4.89), controlPoint2: CGPoint(x: 11.9, y: 5.08))
            shape2.addCurve(to: CGPoint(x: 12.54, y: 4.66), controlPoint1: CGPoint(x: 12.36, y: 5.08), controlPoint2: CGPoint(x: 12.54, y: 4.89))
            shape2.addLine(to: CGPoint(x: 12.54, y: 3.35))
            shape2.addCurve(to: CGPoint(x: 13.45, y: 2.75), controlPoint1: CGPoint(x: 12.9, y: 3.26), controlPoint2: CGPoint(x: 13.22, y: 3.04))
            shape2.addLine(to: CGPoint(x: 20.93, y: 6.09))
            shape2.addCurve(to: CGPoint(x: 20.91, y: 6.37), controlPoint1: CGPoint(x: 20.91, y: 6.18), controlPoint2: CGPoint(x: 20.91, y: 6.27))
            shape2.addCurve(to: CGPoint(x: 20.93, y: 6.64), controlPoint1: CGPoint(x: 20.91, y: 6.46), controlPoint2: CGPoint(x: 20.91, y: 6.55))
            shape2.addLine(to: CGPoint(x: 13.45, y: 9.98))
            shape2.addCurve(to: CGPoint(x: 12.36, y: 9.34), controlPoint1: CGPoint(x: 13.19, y: 9.64), controlPoint2: CGPoint(x: 12.8, y: 9.41))
            shape2.addCurve(to: CGPoint(x: 12.13, y: 9.27), controlPoint1: CGPoint(x: 12.3, y: 9.3), controlPoint2: CGPoint(x: 12.22, y: 9.27))
            shape2.addCurve(to: CGPoint(x: 11.89, y: 9.34), controlPoint1: CGPoint(x: 12.04, y: 9.27), controlPoint2: CGPoint(x: 11.96, y: 9.3))
            shape2.addCurve(to: CGPoint(x: 10.81, y: 9.98), controlPoint1: CGPoint(x: 11.46, y: 9.41), controlPoint2: CGPoint(x: 11.07, y: 9.64))
            shape2.close()
            shape2.move(to: CGPoint(x: 11.28, y: 11.03))
            shape2.addCurve(to: CGPoint(x: 12.13, y: 10.16), controlPoint1: CGPoint(x: 11.28, y: 10.55), controlPoint2: CGPoint(x: 11.66, y: 10.16))
            shape2.addCurve(to: CGPoint(x: 12.98, y: 11.03), controlPoint1: CGPoint(x: 12.6, y: 10.16), controlPoint2: CGPoint(x: 12.98, y: 10.55))
            shape2.addCurve(to: CGPoint(x: 12.13, y: 11.89), controlPoint1: CGPoint(x: 12.98, y: 11.51), controlPoint2: CGPoint(x: 12.6, y: 11.89))
            shape2.addCurve(to: CGPoint(x: 11.28, y: 11.03), controlPoint1: CGPoint(x: 11.66, y: 11.89), controlPoint2: CGPoint(x: 11.28, y: 11.51))
            shape2.close()
            shape2.move(to: CGPoint(x: 12.13, y: 24.91))
            shape2.addCurve(to: CGPoint(x: 11.28, y: 24.05), controlPoint1: CGPoint(x: 11.66, y: 24.91), controlPoint2: CGPoint(x: 11.28, y: 24.53))
            shape2.addCurve(to: CGPoint(x: 12.13, y: 23.19), controlPoint1: CGPoint(x: 11.28, y: 23.57), controlPoint2: CGPoint(x: 11.66, y: 23.19))
            shape2.addCurve(to: CGPoint(x: 12.98, y: 24.05), controlPoint1: CGPoint(x: 12.6, y: 23.19), controlPoint2: CGPoint(x: 12.98, y: 23.57))
            shape2.addCurve(to: CGPoint(x: 12.13, y: 24.91), controlPoint1: CGPoint(x: 12.98, y: 24.53), controlPoint2: CGPoint(x: 12.6, y: 24.91))
            shape2.close()
            shape2.move(to: CGPoint(x: 22.58, y: 20.33))
            shape2.addCurve(to: CGPoint(x: 21.81, y: 19.83), controlPoint1: CGPoint(x: 22.23, y: 20.33), controlPoint2: CGPoint(x: 21.94, y: 20.12))
            shape2.addCurve(to: CGPoint(x: 21.79, y: 19.78), controlPoint1: CGPoint(x: 21.8, y: 19.81), controlPoint2: CGPoint(x: 21.8, y: 19.8))
            shape2.addCurve(to: CGPoint(x: 21.78, y: 19.76), controlPoint1: CGPoint(x: 21.79, y: 19.78), controlPoint2: CGPoint(x: 21.78, y: 19.77))
            shape2.addCurve(to: CGPoint(x: 21.73, y: 19.47), controlPoint1: CGPoint(x: 21.75, y: 19.67), controlPoint2: CGPoint(x: 21.73, y: 19.57))
            shape2.addCurve(to: CGPoint(x: 21.84, y: 19.05), controlPoint1: CGPoint(x: 21.73, y: 19.31), controlPoint2: CGPoint(x: 21.77, y: 19.17))
            shape2.addCurve(to: CGPoint(x: 21.91, y: 18.94), controlPoint1: CGPoint(x: 21.86, y: 19.02), controlPoint2: CGPoint(x: 21.89, y: 18.98))
            shape2.addCurve(to: CGPoint(x: 21.91, y: 18.94), controlPoint1: CGPoint(x: 21.91, y: 18.94), controlPoint2: CGPoint(x: 21.91, y: 18.94))
            shape2.addCurve(to: CGPoint(x: 22.58, y: 18.6), controlPoint1: CGPoint(x: 22.06, y: 18.73), controlPoint2: CGPoint(x: 22.31, y: 18.6))
            shape2.addLine(to: CGPoint(x: 22.58, y: 18.6))
            shape2.addCurve(to: CGPoint(x: 23.43, y: 19.47), controlPoint1: CGPoint(x: 23.04, y: 18.6), controlPoint2: CGPoint(x: 23.43, y: 18.99))
            shape2.addCurve(to: CGPoint(x: 22.58, y: 20.33), controlPoint1: CGPoint(x: 23.43, y: 19.94), controlPoint2: CGPoint(x: 23.04, y: 20.33))
            shape2.close()
            shape2.move(to: CGPoint(x: 22.58, y: 20.33))
            context.saveGState()
            context.translateBy(x: 0.88, y: 0.05)
            UIColor.black.setFill()
            shape2.fill()
            context.restoreGState()
            
            /// Shape
            let shape3 = UIBezierPath()
            shape3.move(to: CGPoint(x: 2.26, y: 0.23))
            shape3.addCurve(to: CGPoint(x: 1.71, y: 0.04), controlPoint1: CGPoint(x: 2.16, y: 0.03), controlPoint2: CGPoint(x: 1.91, y: -0.06))
            shape3.addLine(to: CGPoint(x: 0.23, y: 0.78))
            shape3.addCurve(to: CGPoint(x: 0.04, y: 1.34), controlPoint1: CGPoint(x: 0.03, y: 0.88), controlPoint2: CGPoint(x: -0.06, y: 1.13))
            shape3.addCurve(to: CGPoint(x: 0.41, y: 1.58), controlPoint1: CGPoint(x: 0.11, y: 1.49), controlPoint2: CGPoint(x: 0.26, y: 1.58))
            shape3.addCurve(to: CGPoint(x: 0.59, y: 1.53), controlPoint1: CGPoint(x: 0.47, y: 1.58), controlPoint2: CGPoint(x: 0.53, y: 1.56))
            shape3.addLine(to: CGPoint(x: 2.07, y: 0.79))
            shape3.addCurve(to: CGPoint(x: 2.26, y: 0.23), controlPoint1: CGPoint(x: 2.27, y: 0.69), controlPoint2: CGPoint(x: 2.36, y: 0.44))
            shape3.close()
            shape3.move(to: CGPoint(x: 2.26, y: 0.23))
            context.saveGState()
            context.translateBy(x: 9.09, y: 14.69)
            UIColor.black.setFill()
            shape3.fill()
            context.restoreGState()
            
            /// Shape
            let shape4 = UIBezierPath()
            shape4.move(to: CGPoint(x: 2.26, y: 0.23))
            shape4.addCurve(to: CGPoint(x: 1.71, y: 0.04), controlPoint1: CGPoint(x: 2.16, y: 0.03), controlPoint2: CGPoint(x: 1.91, y: -0.06))
            shape4.addLine(to: CGPoint(x: 0.23, y: 0.78))
            shape4.addCurve(to: CGPoint(x: 0.04, y: 1.34), controlPoint1: CGPoint(x: 0.03, y: 0.88), controlPoint2: CGPoint(x: -0.06, y: 1.14))
            shape4.addCurve(to: CGPoint(x: 0.41, y: 1.58), controlPoint1: CGPoint(x: 0.11, y: 1.49), controlPoint2: CGPoint(x: 0.26, y: 1.58))
            shape4.addCurve(to: CGPoint(x: 0.59, y: 1.53), controlPoint1: CGPoint(x: 0.47, y: 1.58), controlPoint2: CGPoint(x: 0.53, y: 1.56))
            shape4.addLine(to: CGPoint(x: 2.07, y: 0.79))
            shape4.addCurve(to: CGPoint(x: 2.26, y: 0.23), controlPoint1: CGPoint(x: 2.27, y: 0.69), controlPoint2: CGPoint(x: 2.36, y: 0.44))
            shape4.close()
            shape4.move(to: CGPoint(x: 2.26, y: 0.23))
            context.saveGState()
            context.translateBy(x: 6.14, y: 16.17)
            UIColor.black.setFill()
            shape4.fill()
            context.restoreGState()
            
            /// Shape
            let shape5 = UIBezierPath()
            shape5.move(to: CGPoint(x: 2.07, y: 0.78))
            shape5.addLine(to: CGPoint(x: 0.59, y: 0.04))
            shape5.addCurve(to: CGPoint(x: 0.04, y: 0.23), controlPoint1: CGPoint(x: 0.39, y: -0.06), controlPoint2: CGPoint(x: 0.14, y: 0.03))
            shape5.addCurve(to: CGPoint(x: 0.23, y: 0.79), controlPoint1: CGPoint(x: -0.06, y: 0.44), controlPoint2: CGPoint(x: 0.03, y: 0.69))
            shape5.addLine(to: CGPoint(x: 1.71, y: 1.53))
            shape5.addCurve(to: CGPoint(x: 1.89, y: 1.58), controlPoint1: CGPoint(x: 1.76, y: 1.56), controlPoint2: CGPoint(x: 1.83, y: 1.58))
            shape5.addCurve(to: CGPoint(x: 2.26, y: 1.34), controlPoint1: CGPoint(x: 2.04, y: 1.58), controlPoint2: CGPoint(x: 2.19, y: 1.49))
            shape5.addCurve(to: CGPoint(x: 2.07, y: 0.78), controlPoint1: CGPoint(x: 2.36, y: 1.14), controlPoint2: CGPoint(x: 2.27, y: 0.88))
            shape5.close()
            shape5.move(to: CGPoint(x: 2.07, y: 0.78))
            context.saveGState()
            context.translateBy(x: 14.62, y: 14.69)
            UIColor.black.setFill()
            shape5.fill()
            context.restoreGState()
            
            /// Shape
            let shape6 = UIBezierPath()
            shape6.move(to: CGPoint(x: 2.07, y: 0.78))
            shape6.addLine(to: CGPoint(x: 0.59, y: 0.04))
            shape6.addCurve(to: CGPoint(x: 0.04, y: 0.23), controlPoint1: CGPoint(x: 0.39, y: -0.06), controlPoint2: CGPoint(x: 0.14, y: 0.03))
            shape6.addCurve(to: CGPoint(x: 0.23, y: 0.79), controlPoint1: CGPoint(x: -0.06, y: 0.44), controlPoint2: CGPoint(x: 0.03, y: 0.69))
            shape6.addLine(to: CGPoint(x: 1.71, y: 1.53))
            shape6.addCurve(to: CGPoint(x: 1.89, y: 1.58), controlPoint1: CGPoint(x: 1.76, y: 1.56), controlPoint2: CGPoint(x: 1.83, y: 1.58))
            shape6.addCurve(to: CGPoint(x: 2.26, y: 1.34), controlPoint1: CGPoint(x: 2.04, y: 1.58), controlPoint2: CGPoint(x: 2.19, y: 1.49))
            shape6.addCurve(to: CGPoint(x: 2.07, y: 0.78), controlPoint1: CGPoint(x: 2.36, y: 1.13), controlPoint2: CGPoint(x: 2.27, y: 0.88))
            shape6.close()
            shape6.move(to: CGPoint(x: 2.07, y: 0.78))
            context.saveGState()
            context.translateBy(x: 17.57, y: 16.17)
            UIColor.black.setFill()
            shape6.fill()
            context.restoreGState()
            
            context.restoreGState()
        }
        
        context.restoreGState()
    }
    
    class func drawTime(frame targetFrame: CGRect = CGRect(x: 0, y: 0, width: 12, height: 12), resizing: ResizingBehavior = .aspectFit) {
        /// General Declarations
        let context = UIGraphicsGetCurrentContext()!
        
        /// Resize to Target Frame
        context.saveGState()
        let resizedFrame = resizing.apply(rect: CGRect(x: 0, y: 0, width: 12, height: 12), target: targetFrame)
        context.translateBy(x: resizedFrame.minX, y: resizedFrame.minY)
        context.scaleBy(x: resizedFrame.width / 12, y: resizedFrame.height / 12)
        
        /// time
        do {
            context.saveGState()
            
            /// Shape
            let shape = UIBezierPath()
            shape.move(to: CGPoint(x: 6, y: 0))
            shape.addCurve(to: CGPoint(x: 0, y: 6), controlPoint1: CGPoint(x: 2.69, y: 0), controlPoint2: CGPoint(x: 0, y: 2.69))
            shape.addCurve(to: CGPoint(x: 6, y: 12), controlPoint1: CGPoint(x: 0, y: 9.31), controlPoint2: CGPoint(x: 2.69, y: 12))
            shape.addCurve(to: CGPoint(x: 12, y: 6), controlPoint1: CGPoint(x: 9.31, y: 12), controlPoint2: CGPoint(x: 12, y: 9.31))
            shape.addCurve(to: CGPoint(x: 6, y: 0), controlPoint1: CGPoint(x: 12, y: 2.69), controlPoint2: CGPoint(x: 9.31, y: 0))
            shape.close()
            shape.move(to: CGPoint(x: 6, y: 11.6))
            shape.addCurve(to: CGPoint(x: 0.4, y: 6), controlPoint1: CGPoint(x: 2.91, y: 11.6), controlPoint2: CGPoint(x: 0.4, y: 9.09))
            shape.addCurve(to: CGPoint(x: 6, y: 0.4), controlPoint1: CGPoint(x: 0.4, y: 2.91), controlPoint2: CGPoint(x: 2.91, y: 0.4))
            shape.addCurve(to: CGPoint(x: 11.6, y: 6), controlPoint1: CGPoint(x: 9.09, y: 0.4), controlPoint2: CGPoint(x: 11.6, y: 2.91))
            shape.addCurve(to: CGPoint(x: 6, y: 11.6), controlPoint1: CGPoint(x: 11.6, y: 9.09), controlPoint2: CGPoint(x: 9.09, y: 11.6))
            shape.close()
            shape.move(to: CGPoint(x: 6, y: 11.6))
            context.saveGState()
            UIColor.black.setFill()
            shape.fill()
            context.restoreGState()
            
            /// Shape
            let shape2 = UIBezierPath()
            shape2.move(to: CGPoint(x: 3.4, y: 0))
            shape2.addCurve(to: CGPoint(x: 3.2, y: 0.2), controlPoint1: CGPoint(x: 3.29, y: 0), controlPoint2: CGPoint(x: 3.2, y: 0.09))
            shape2.addLine(to: CGPoint(x: 3.2, y: 4.8))
            shape2.addLine(to: CGPoint(x: 0.2, y: 4.8))
            shape2.addCurve(to: CGPoint(x: 0, y: 5), controlPoint1: CGPoint(x: 0.09, y: 4.8), controlPoint2: CGPoint(x: 0, y: 4.89))
            shape2.addCurve(to: CGPoint(x: 0.2, y: 5.2), controlPoint1: CGPoint(x: 0, y: 5.11), controlPoint2: CGPoint(x: 0.09, y: 5.2))
            shape2.addLine(to: CGPoint(x: 3.4, y: 5.2))
            shape2.addCurve(to: CGPoint(x: 3.6, y: 5), controlPoint1: CGPoint(x: 3.51, y: 5.2), controlPoint2: CGPoint(x: 3.6, y: 5.11))
            shape2.addLine(to: CGPoint(x: 3.6, y: 0.2))
            shape2.addCurve(to: CGPoint(x: 3.4, y: 0), controlPoint1: CGPoint(x: 3.6, y: 0.09), controlPoint2: CGPoint(x: 3.51, y: 0))
            shape2.close()
            shape2.move(to: CGPoint(x: 3.4, y: 0))
            context.saveGState()
            context.translateBy(x: 2.6, y: 1.2)
            UIColor.black.setFill()
            shape2.fill()
            context.restoreGState()
            
            context.restoreGState()
        }
        
        context.restoreGState()
    }
    
    class func drawRightArrow(frame targetFrame: CGRect = CGRect(x: 0, y: 0, width: 11, height: 20), resizing: ResizingBehavior = .aspectFit) {
        /// General Declarations
        let context = UIGraphicsGetCurrentContext()!
        
        /// Resize to Target Frame
        context.saveGState()
        let resizedFrame = resizing.apply(rect: CGRect(x: 0, y: 0, width: 11, height: 20), target: targetFrame)
        context.translateBy(x: resizedFrame.minX, y: resizedFrame.minY)
        context.scaleBy(x: resizedFrame.width / 11, y: resizedFrame.height / 20)
        
        /// right-arrow
        do {
            context.saveGState()
            
            /// Shape
            let shape = UIBezierPath()
            shape.move(to: CGPoint(x: 1.2, y: 19.62))
            shape.addCurve(to: CGPoint(x: 0.7, y: 19.83), controlPoint1: CGPoint(x: 1.06, y: 19.76), controlPoint2: CGPoint(x: 0.89, y: 19.83))
            shape.addCurve(to: CGPoint(x: 0.21, y: 19.62), controlPoint1: CGPoint(x: 0.51, y: 19.83), controlPoint2: CGPoint(x: 0.34, y: 19.76))
            shape.addCurve(to: CGPoint(x: 0.21, y: 18.63), controlPoint1: CGPoint(x: -0.07, y: 19.35), controlPoint2: CGPoint(x: -0.07, y: 18.91))
            shape.addLine(to: CGPoint(x: 8.92, y: 9.91))
            shape.addLine(to: CGPoint(x: 0.21, y: 1.2))
            shape.addCurve(to: CGPoint(x: 0.21, y: 0.21), controlPoint1: CGPoint(x: -0.07, y: 0.92), controlPoint2: CGPoint(x: -0.07, y: 0.48))
            shape.addCurve(to: CGPoint(x: 1.2, y: 0.21), controlPoint1: CGPoint(x: 0.48, y: -0.07), controlPoint2: CGPoint(x: 0.92, y: -0.07))
            shape.addLine(to: CGPoint(x: 10.41, y: 9.42))
            shape.addCurve(to: CGPoint(x: 10.41, y: 10.41), controlPoint1: CGPoint(x: 10.68, y: 9.69), controlPoint2: CGPoint(x: 10.68, y: 10.14))
            shape.addLine(to: CGPoint(x: 1.2, y: 19.62))
            shape.close()
            shape.move(to: CGPoint(x: 1.2, y: 19.62))
            context.saveGState()
            context.translateBy(x: 0.07, y: 0.09)
            UIColor(white: 0.827, alpha: 1).setFill()
            shape.fill()
            context.restoreGState()
            
            context.restoreGState()
        }
        
        context.restoreGState()
    }
    
    
    //MARK: - Canvas Images
    
    /// Page 1
    
    class func imageOfAugmentedRealityCube() -> UIImage {
        struct LocalCache {
            static var image: UIImage!
        }
        if LocalCache.image != nil {
            return LocalCache.image
        }
        var image: UIImage
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 28, height: 26), false, 0)
        StyleKit.drawAugmentedRealityCube()
        image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        LocalCache.image = image
        return image
    }
    
    class func imageOfTime() -> UIImage {
        struct LocalCache {
            static var image: UIImage!
        }
        if LocalCache.image != nil {
            return LocalCache.image
        }
        var image: UIImage
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 12, height: 12), false, 0)
        StyleKit.drawTime()
        image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        LocalCache.image = image
        return image
    }
    
    class func imageOfRightArrow() -> UIImage {
        struct LocalCache {
            static var image: UIImage!
        }
        if LocalCache.image != nil {
            return LocalCache.image
        }
        var image: UIImage
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 11, height: 20), false, 0)
        StyleKit.drawRightArrow()
        image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        LocalCache.image = image
        return image
    }
    
    
    //MARK: - Resizing Behavior
    
    enum ResizingBehavior {
        case aspectFit /// The content is proportionally resized to fit into the target rectangle.
        case aspectFill /// The content is proportionally resized to completely fill the target rectangle.
        case stretch /// The content is stretched to match the entire target rectangle.
        case center /// The content is centered in the target rectangle, but it is NOT resized.
        
        func apply(rect: CGRect, target: CGRect) -> CGRect {
            if rect == target || target == CGRect.zero {
                return rect
            }
            
            var scales = CGSize.zero
            scales.width = abs(target.width / rect.width)
            scales.height = abs(target.height / rect.height)
            
            switch self {
            case .aspectFit:
                scales.width = min(scales.width, scales.height)
                scales.height = scales.width
            case .aspectFill:
                scales.width = max(scales.width, scales.height)
                scales.height = scales.width
            case .stretch:
                break
            case .center:
                scales.width = 1
                scales.height = 1
            }
            
            var result = rect.standardized
            result.size.width *= scales.width
            result.size.height *= scales.height
            result.origin.x = target.minX + (target.width - result.width) / 2
            result.origin.y = target.minY + (target.height - result.height) / 2
            return result
        }
    }
    
    
}
