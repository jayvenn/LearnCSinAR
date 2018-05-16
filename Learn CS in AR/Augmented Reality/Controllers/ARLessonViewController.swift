//
//  ARViewController.swift
//  Learn CS in AR
//
//  Created by Jayven Nhan on 4/26/18.
//  Copyright © 2018 Jayven Nhan. All rights reserved.
//

import UIKit
import ARKit
import SnapKit

enum Operation: String {
    case push =  "push(📦)"
    case pop = "pop()"
    case peek = "peek()"
    case isEmpty = "isEmpty()"
}

// MARK: ARLessonViewController
class ARLessonViewController: DefaultARViewController {
    
    lazy var stackView = ARStackView(viewController: self)
    lazy var containerBoxNode = ContainerBoxNode(cubeLength: cubeLength, cubeSpacing: cubeSpacing, trackerNodeLength: trackerNodeLength)
    lazy var subtitleView = SubtitleView(lesson: lesson)
    // MARK: ARLessonViewController - Properties
    let lesson: Lesson
    
    init(lesson: Lesson) {
        self.lesson = lesson
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: ARLessonViewController - Override methods
    override func finishedIntroductionAnimation() {
        super.finishedIntroductionAnimation()
        beginLesson()
    }
    
    // MARK: ARLessonViewController - Button methods
    @objc func operationButtonDidTouchUpInside(_ sender: ARButton) {
        
    }
    
    @objc func orderingButtonDidTouchUpInside(_ sender: ARButton) {
        fadeOutBottomStackView {
            self.runOrdering()
        }
    }
    
    @objc func bigOButtonDidTouchUpInside(_ sender: ARButton) {
        
    }
    
    @objc func resetButtonDidTouchUpInside(_ sender: AlternateARButton) {
        fadeOutBottomStackView(completion: {
            DispatchQueue.main.async {
                self.resetTrackingConfiguration()
            }
        })
    }
    
}

// MARK: ARLessonViewController - Life cycles
extension ARLessonViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLayout()
    }
}

// MARK: ARLessonViewController - Set Ups
extension ARLessonViewController {
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        subtitleView.setContentOffset(.zero, animated: false)
    }
}

// MARK: ARLessonViewController - Lesson
extension ARLessonViewController {
    func beginLesson() {
        switch lesson.name {
        case .stack:
            runStackLesson()
        case .queue:
            break
        }
    }
    
    func setUpLayout() {
        setUpStackView()
        setUpTextView()
    }
    
    func setUpStackView() {
        view.addSubviews(views: [
            stackView
            ])
        stackView.snp.makeConstraints { (make) in
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(16)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-16)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(0)
        }
    }
    
    func setUpTextView() {
        view.addSubview(subtitleView)
        subtitleView.snp.makeConstraints { (make) in
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            make.bottom.equalTo(view.snp.bottom)
            make.height.equalTo(view.frame.height/3)
        }
    }
}

// MARK: ARLessonViewController - Stack Lesson
extension ARLessonViewController {
    func runStackLesson() {
        containerBoxNode = ContainerBoxNode(cubeLength: cubeLength, cubeSpacing: cubeSpacing, trackerNodeLength: trackerNodeLength)
        containerBoxNode.delegate = self
        containerBoxNode.position = SCNVector3(0, 0.6, 0)
        containerBoxNode.runFadeInAction(completion: {
            self.fadeInBottomStackView() { }
        })
        mainNode.addChildNode(containerBoxNode)
    }
    
    // Stack - Ordering
    func runOrdering() {
        fadeInSubtitleTextView(completion: {})
        switch lesson.name {
        case .stack:
            containerBoxNode.push(boxes: boxes)
        case .queue:
            break
        }
    }
    
    // Stack - Operation
    func runStackOperation(_ operation: Operation, boxes: [SCNNode]) {
        switch operation {
        case .push:
            break
        case .pop:
            break
        case .peek:
            break
        case .isEmpty:
            break
        }
    }
    
    // Stack - Operation
    func runStackBigO() {
        
    }
    
}

// MARK: ARLessonViewController - Animation
extension ARLessonViewController {
    // Bottom Stack View
    func fadeInBottomStackView(completion: @escaping () -> ()) {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseIn], animations: {
                self.stackView.alpha = 1
            }, completion: { _ in completion() })
        }
    }
    
    func fadeOutBottomStackView(completion: @escaping () -> ()) {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseOut], animations: {
                self.stackView.alpha = 0
            }, completion: { _ in completion() })
        }
    }
    
    // Subtitle Stack View
    func fadeInSubtitleTextView(completion: @escaping () -> ()) {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseIn], animations: {
                self.subtitleView.alpha = 1
            }, completion: { _ in completion() })
        }
    }
    
    func fadeOutSubtitleTextView(completion: @escaping () -> ()) {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseOut], animations: {
                self.subtitleView.alpha = 0
            }, completion: { _ in completion() })
        }
    }
}

// MARK: ARLessonViewController - ContainerBoxNodeDelegate
extension ARLessonViewController: ContainerBoxNodeDelegate {
    func didFinishOrdering() {
        fadeOutSubtitleTextView {
            self.fadeInBottomStackView(completion: {})
        }
    }
}

// MARK: ARLessonViewController - Subtitle
extension ARLessonViewController {
    
}
