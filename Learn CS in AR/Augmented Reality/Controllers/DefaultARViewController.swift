//
//  DefaultARViewController.swift
//  Learn CS in AR
//
//  Created by Jayven Nhan on 4/26/18.
//  Copyright © 2018 Jayven Nhan. All rights reserved.
//

import UIKit
import ARKit
import SnapKit

class DefaultARViewController: BaseMenuViewController {
    
    let sceneView = ARSCNView(frame: .zero)
    
    let trackerNode = SCNNode.tracker
    
    lazy var omniLightNode: SCNNode = {
        let light = SCNLight()
        light.type = .omni
        let node = SCNNode()
        node.light = light
        return node
    }()
    
    lazy var spotLightNode: SCNNode = {
        let light = SCNLight()
        light.type = .spot
        light.castsShadow = true
        let color = UIColor.black.withAlphaComponent(0.2)
        light.shadowColor = color
        light.shadowMode = .deferred
        let node = SCNNode()
        node.light = light
        return node
    }()
    
    lazy var ambientLightNode: SCNNode = {
        let light = SCNLight()
        light.type = .ambient
        let color = UIColor.white
        light.color = color
        let node = SCNNode()
        node.light = light
        return node
    }()
    
    lazy var planeNode: SCNNode = {
        let plane = SCNPlane(width: 2, height: 2)
        let material = SCNMaterial()
        material.writesToDepthBuffer = true
        material.colorBufferWriteMask = []
        material.lightingModel = .constant
        plane.firstMaterial = material
        let node = SCNNode(geometry: plane)
        node.eulerAngles.x = Float(-90 * degreesToRadians)
        node.accessibilityLabel = "Tracker"
        return node
    }()
    
    lazy var yBillboardConstraint: SCNBillboardConstraint = {
        let yBillboardConstraint = SCNBillboardConstraint()
        yBillboardConstraint.freeAxes = .Y
        return yBillboardConstraint
    }()
    
    lazy var mainNode: SCNNode = {
        let node = SCNNode()
        node.addChildNode(planeNode)
        return node
    }()
    
    lazy var instructionLabel: UILabel = {
        let label = UILabel()
        label.text = "Move around \nto find a surface".uppercased()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .lightGray
        label.alpha = 0
        label.adjustsFontSizeToFitWidth = true
        label.sizeToFit()
        label.numberOfLines = 2
        label.minimumScaleFactor = 0.5
        label.backgroundColor = .white
        label.backgroundColor = .transparentTextBackgroundWhite
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        label.accessibilityLabel = "Instruction"
        return label
    }()
    
    lazy var beginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Begin Lesson".uppercased(), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        button.titleLabel?.minimumScaleFactor = 0.5
        button.addTarget(self, action: #selector(DefaultARViewController.beginButtonDidTouchUpInside), for: .touchUpInside)
        button.setTitleColor(.white, for: .normal)
        button.alpha = 0
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.backgroundColor = .plantButtonBackground
        button.accessibilityLabel = "Begin lesson"
        button.accessibilityHint = "Begin lesson"
        return button
    }()
    
    lazy var cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("X", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.sizeToFit()
        button.alpha = 0
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .regular)
        button.addTarget(self, action: #selector(DefaultARViewController.cancelButtonDidTouchUpInside(_:)), for: .touchUpInside)
        button.accessibilityLabel = "Cancel"
        button.accessibilityHint = "Cancel"
        return button
    }()
    
    var instructionLabelHeightConstraint: ConstraintMakerEditable?
    var gamePosition = SCNVector3(0,0,0)
    var gameEulerAngles = SCNVector3(0,0,0)
    var gameStarted = false
    var foundSurface = false
    var boxes = [CubeNode]()
    var lightNodes = [SCNNode]()
    var trackingReady = false
    var firstLoad = true
    
    var cubeLength: CGFloat = 0
    let cubeSpacing: CGFloat = 0.05
    var trackerNodeLength: CGFloat = 0
    
    // MARK: IBAction methods
    @objc func beginButtonDidTouchUpInside(_ sender: UIButton) {
        gameStarted = true
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = []
        
        sceneView.session.run(configuration, options: [])
        gamePosition = mainNode.position
        gameEulerAngles = mainNode.eulerAngles
        
        beginButton.fadeOut()
        instructionLabel.fadeOut()
        
        mainNode.constraints = []
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0) {
            let startYScale = self.trackerNode.scale.y
            let endYScale: Float = 0
            let action: SCNAction = SCNAction.customAction(duration: 1, action: { (node, elapsedTime) in
                var scale = node.scale
                scale.y = startYScale - ((startYScale + endYScale) * Float((elapsedTime / 1.0)))
                if elapsedTime == 1 {
                    scale.y = 0.000161627
                }
                node.scale = scale
            })
            action.timingMode = .easeIn
            self.trackerNode.runAction(action, completionHandler: {
                self.generateBoxes(completionHandler: { (completed, cubeLength)  in
                    self.move(boxes: self.boxes, completion: {
                    })
                })
            })
        }
    }
    
    func finishedIntroductionAnimation() {
        
    }
    
    @objc func cancelButtonDidTouchUpInside(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: DefaultARViewController - Life cycles
extension DefaultARViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSceneView()
        setUpLayouts()
        setUpUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        resetTrackingConfiguration()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        sceneView.session.pause()
    }
}

// MARK: DefaultARViewController - Set Up and Layouts
extension DefaultARViewController {
    
    func setUpSceneView() {
        sceneView.autoenablesDefaultLighting = true
        sceneView.automaticallyUpdatesLighting = true
        
        sceneView.session = ARSession()
        sceneView.delegate = self
        view.addSubview(sceneView)
        sceneView.snp.makeConstraints { (make) in
            make.size.equalTo(view)
        }
    }
    
    func setUpLayouts() {
        setUpInstructionLabelLayouts()
        setUpPlantButtonLayouts()
    }
    
    func setUpUI() {
        title = "Select a Lesson"
    }
    
    func setUpInstructionLabelLayouts() {
        view.addSubview(instructionLabel)
        view.addSubview(cancelButton)
        
        instructionLabel.snp.makeConstraints {
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(8)
            $0.trailing.equalTo(cancelButton.snp.leading).offset(-8)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.height.equalTo(66)
        }
        
        cancelButton.snp.makeConstraints {
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-8)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.height.equalTo(66)
            $0.width.equalTo(44)
        }
    }
    
    func setUpPlantButtonLayouts() {
        view.addSubview(beginButton)
        beginButton.snp.makeConstraints {
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(8)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-8)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-8)
            $0.height.equalTo(44)
        }
    }
    
    func resetTrackingConfiguration() {
        fadeInTopObjects()
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        resetObjects()
        
        var deadline = DispatchTime.now() + 1
        if firstLoad {
            firstLoad = false
            deadline = DispatchTime.now()
        }
        
        DispatchQueue.main.asyncAfter(deadline: deadline) {
            let options: ARSession.RunOptions = [.resetTracking, .removeExistingAnchors]
//            self.sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin, .showSkeletons]
            self.sceneView.session.run(configuration, options: options)
        }
        addLight()
    }
    
    func resetObjects() {
        gameStarted = false
        foundSurface = false
        trackingReady = false
        
        trackerNode.opacity = 0
        trackerNode.scale.y = scaleFactor
        
        boxes = []
        
        for node in mainNode.childNodes {
            guard node != planeNode else { continue }
            node.childNodes.forEach { $0.removeFromParentNode() }
            node.removeFromParentNode()
        }
        mainNode.removeFromParentNode()
        spotLightNode.removeFromParentNode()
        mainNode.constraints = [yBillboardConstraint]
        
        mainNode.addChildNode(trackerNode)
        add(nodes: [mainNode], toSceneView: sceneView)
    }

    func fadeInTopObjects() {
        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseIn], animations: {
            self.instructionLabel.alpha = 1
            self.cancelButton.alpha = 1
        })
    }
    
    func fadeInBeginButton() {
        UIView.animate(withDuration: 0.5, delay: 0.5, options: [.curveEaseIn], animations: {
            self.beginButton.alpha = 1
        })
    }
    
}

// MARK: DefaultARViewController - Scene Rendering
extension DefaultARViewController {
    
    func renderer(_ renderer: SCNSceneRenderer, didRenderScene scene: SCNScene, atTime time: TimeInterval) {
        DispatchQueue.main.async {
            self.handleSceneRendering()
        }
    }
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        
    }
    
    func handleSceneRendering() {
        guard trackingReady,
            !gameStarted,
            let hitTestResult = sceneView.hitTest(CGPoint(x: view.frame.midX, y: view.frame.midY),
                                                  types: [.existingPlane, .estimatedHorizontalPlane]).first
            else { return }
        
        
        if !foundSurface {
            foundSurface = true
            fadeInBeginButton()
            trackerNode.opacity = 1
        }
        
        mainNode.position = vector(from: hitTestResult.worldTransform.translation)
    }
    
    func fadeOutAndRemove(node: SCNNode) {
        let action: SCNAction = .sequence([
            .fadeOpacity(to: 0, duration: 0.3),
            .wait(duration: 0.2),
            .removeFromParentNode()
            ])
        action.timingMode = .easeOut
        node.runAction(action)
    }
}

// MARK: DefaultARViewController - ARSCNViewDelegate
extension DefaultARViewController: ARSCNViewDelegate {
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        
    }
    
    func update(_ node: inout SCNNode, withGeometry geometry: SCNGeometry, type: SCNPhysicsBodyType) {
        
    }
    
    func session(_ session: ARSession, cameraDidChangeTrackingState camera: ARCamera) {
        switch camera.trackingState {
        case .notAvailable:
            trackingReady = false
        case let .limited(reason):
            print("Tracking limited reason: \(reason)")
            trackingReady = false
        case .normal:
            trackingReady = true
        }
    }
}

// MARK: DefaultARViewController - ARSessionDelegate
extension DefaultARViewController: ARSessionDelegate {
    
}

// MARK: DefaultARViewController - Introduction animation
extension DefaultARViewController {
    
    func generateBoxes(completionHandler: @escaping (Bool, _ cubeLength: CGFloat) -> Void) {
        let numberOfCubes: CGFloat = 3
        trackerNodeLength = CGFloat(40 * trackerNode.scale.x)
        
        let totalSpacing = (numberOfCubes - 1.0) * cubeSpacing
        cubeLength = (trackerNodeLength - totalSpacing) / numberOfCubes
        
        let leadingX = -(trackerNodeLength / 2) + (cubeLength / 2)
//        let yInitial = Float((cubeLength / 2))
//        let yFinal = Float((cubeLength / 2) + 0.2)
        let yEulerAngle = trackerNode.eulerAngles.y
        
        for index in 0..<Int(numberOfCubes) {
            let cubeNode = CubeNode(length: cubeLength, index: index, leadingX: leadingX)
            cubeNode.eulerAngles.y = yEulerAngle
            mainNode.addChildNode(cubeNode)
            boxes.append(cubeNode)
        }
        
        completionHandler(true, cubeLength)
    }
    
    
    func move(boxes: [CubeNode], index: Int = 0, completion: @escaping ()->()) {
        guard boxes.count != index else {
            completion()
            return
        }
        let box = boxes[index]
        let moveToVector = SCNVector3(box.position.x,box.airPosition.y,box.position.z)
        let action = SCNAction.sequence([
            SCNAction.fadeOpacity(to: 1, duration: 0.25),
            SCNAction.move(to: moveToVector, duration: 0.4),
//            SCNAction.moveBy(x: 0, y: CGFloat(box.airPosition.y), z: 0, duration: 0.4),
            SCNAction.wait(duration: 0.5)
            ])
        box.runAction(action) {
            self.move(boxes: boxes, index: index + 1, completion: {
                print("Complete moving boxes")
                self.finishedIntroductionAnimation()
            })
        }
    }
}

// MARK: DefaultARViewController - Lighting
extension DefaultARViewController {
    func addLight() {
        spotLightNode.position.y = 2
        spotLightNode.position.x = 0.1
        spotLightNode.position.z = 0.5
//        spotLightNode.position = SCNVector3(1,5,1)
        spotLightNode.look(at: mainNode.position)
        
        mainNode.addChildNode(spotLightNode)
        lightNodes.append(spotLightNode)
        
//        omniLightNode.position.y = 2
//        mainNode.addChildNode(omniLightNode)
//        lightNodes.append(omniLightNode)

//        ambientLightNode.position.y = 20
//        mainNode.addChildNode(ambientLightNode)
//        lightNodes.append(ambientLightNode)
    }
    
    func updateLightNodesLightEstimation() {
        DispatchQueue.main.async {
            guard let lightEstimate
                = self.sceneView.session.currentFrame?.lightEstimate
                else { return }
            let ambientIntensity = lightEstimate.ambientIntensity
            for lightNode in self.lightNodes {
                guard let light = lightNode.light else { continue }
                light.intensity = ambientIntensity
            }
        }
    }
}

