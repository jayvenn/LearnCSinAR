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

let initialSpringVelocity: CGFloat = 1 // 1
let springWithDaming: CGFloat = 0.9 // 0.7

// MARK: ARLessonViewController
final class ARLessonViewController: DefaultARViewController {
    
    lazy var stackView = ARStackView(viewController: self)
    
    lazy var containerBoxNode = ContainerBoxNode(cubeLength: cubeLength, cubeSpacing: cubeSpacing, trackerNodeLength: trackerNodeLength, lesson: lesson)
    lazy var subtitleView: SubtitleView = {
        let view = SubtitleView(lesson: lesson)
        view.accessibilityLabel = "Lesson info"
        view.delegate = self
        return view
    }()
    
    lazy var linkedListNode = LinkedListNode(cubeLength: cubeLength, cubeSpacing: cubeSpacing, trackerNodeLength: trackerNodeLength, lesson: lesson)
    
    lazy var binaryTreeNode = BinaryTreeNode(cubeLength: cubeLength, cubeSpacing: cubeSpacing, trackerNodeLength: trackerNodeLength, lesson: lesson)
    
    // MARK: ARLessonViewController - Properties
    let lesson: Lesson
    
    var subtitleViewTopConstraint: Constraint?
    var subtitleViewBottomConstraint: Constraint?
    
    var subtitleViewMaximized = false
    
    lazy var subtitleViewHeight: CGFloat = view.frame.height/3
//    lazy var subtitleViewTopOffset: CGFloat = view.frame.height - subtitleViewHeight - 40
    lazy var subtitleViewTopOffset: CGFloat = view.frame.height - subtitleViewHeight + 120
    
    let synthesizer = SpeechSynthesizer.shared
    
    init(lesson: Lesson) {
        self.lesson = lesson
        super.init(nibName: nil, bundle: nil)
        accessibilityLabel = "\(lesson.name) lesson"
    }
    
    deinit {
        print("ARLessonViewController did deinit")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: ARLessonViewController - Override methods
    override func finishedIntroductionAnimation() {
        super.finishedIntroductionAnimation()
        beginLesson()
    }
    
    private func speak() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
            guard let text = self.subtitleView.textView.accessibilityValue else { return }
            self.synthesizer.speak(text)
        }
    }
    
    // MARK: ARLessonViewController - Button methods
    @objc func orderingButtonDidTouchUpInside(_ sender: ARButton) {
        speak()
        runOrdering()
        subtitleView.setOrdering()
        fadeOutBottomStackViewAndFadeInSubTitleView()
    }
    
    @objc func operationButtonDidTouchUpInside(_ sender: ARButton) {
        subtitleView.setOperation()
        fadeOutBottomStackViewAndFadeInSubTitleView()
    }
    
    @objc func bigOButtonDidTouchUpInside(_ sender: ARButton) {
        subtitleView.setBigO()
        fadeOutBottomStackViewAndFadeInSubTitleView()
    }
    
    @objc func resetButtonDidTouchUpInside(_ sender: AlternateARButton) {
        fadeOutBottomStackView(completion: {
            DispatchQueue.main.async {
                self.resetTrackingConfiguration()
            }
        })
    }
    
    func fadeOutBottomStackViewAndFadeInSubTitleView() {
        fadeOutBottomStackView {
            self.fadeInSubtitleView(completion: {})
        }
    }
    
    override func configureView() {
        super.configureView()
        // TODO: Update subtitle view with accessible fonts
        
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
        subtitleView.textView.setContentOffset(.zero, animated: false)
    }
}

// MARK: ARLessonViewController - Animation
extension ARLessonViewController {
    @objc func maximizeSubtitleView() {
        self.subtitleViewTopConstraint?.update(offset: 0)
        self.subtitleViewBottomConstraint?.update(offset: self.subtitleViewTopOffset)
        animateMaximizedSubtitleView()
        subtitleViewMaximized = true
    }
    
    func animateMaximizedSubtitleView() {
        UIView.animate(withDuration: animationDuration, delay: 0, usingSpringWithDamping: springWithDaming, initialSpringVelocity: initialSpringVelocity, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: { _ in
            self.subtitleViewBottomConstraint?.update(offset: 0)
        })
    }
    
    @objc func minimizeSubtitleView() {
        if !subtitleViewMaximized {
            SpeechSynthesizer.shared.stopSpeaking()
            refreshSubtitleView()
            fadeOutSubtitleView {
                self.fadeInBottomStackView(completion: { })
            }
            return
        }
        animateMinimizeSubtitleView()
        subtitleViewMaximized = false
    }
    
    func animateMinimizeSubtitleView() {
        self.subtitleViewTopConstraint?.update(offset: self.subtitleViewTopOffset)
        self.subtitleViewBottomConstraint?.update(offset: self.subtitleViewTopOffset)
        UIView.animate(withDuration: animationDuration, delay: 0, usingSpringWithDamping: springWithDaming, initialSpringVelocity: initialSpringVelocity, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: { _ in
            self.subtitleViewBottomConstraint?.update(offset: 0)
        })
    }
}

// MARK: ARLessonViewController - Lesson
extension ARLessonViewController {
    
    func beginLesson() {
        mainNode.addChildNode(containerBoxNode)
        switch lesson.name {
        case .stack:
            runStackLesson()
        case .queue:
            runQueueLesson()
        case .singlyLinkedList:
            runSinglyLinkedListLesson()
        case .doublyLinkedList:
            fadeInBottomStackView { }
        case .binaryTree:
            fadeInBottomStackView { }
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
        stackView.snp.makeConstraints {
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(16)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-16)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(0)
        }
    }
    
    func setUpTextView() {
        view.addSubview(subtitleView)
        subtitleView.snp.makeConstraints {
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
//            $0.height.equalTo(view.frame.height)
            subtitleViewBottomConstraint = $0.bottom.equalTo(view.snp.bottom).constraint
            subtitleViewTopConstraint = $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(subtitleViewTopOffset).constraint
        }
        view.setNeedsLayout()
    }
}

// MARK: ARLessonViewController - Lesson Ordering, Operation, Big O
extension ARLessonViewController {
    // Ordering
    func runOrdering() {
        fadeInSubtitleView(completion: {})
        switch lesson.name {
        case .stack:
            containerBoxNode.push(boxes: boxes)
        case .queue:
            containerBoxNode.push(boxes: boxes)
        case .singlyLinkedList:
            DispatchQueue.main.async {
                self.linkedListNode.generateSinglyLinkingNodes(basedOn: self.boxes)
            }
        case .doublyLinkedList:
            DispatchQueue.main.async {
                self.linkedListNode.generateSinglyLinkingNodes(basedOn: self.boxes, isDoubly: true)
            }
        case .binaryTree:
            DispatchQueue.main.async {
                self.binaryTreeNode.animate(with: self.boxes)
            }
        }
    }
    
    // Operation
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
        default:
            break
        }
    }
}

// MARK: ARLessonViewController - Stack Lesson
extension ARLessonViewController {
    func runStackLesson() {
        containerBoxNode = ContainerBoxNode(cubeLength: cubeLength, cubeSpacing: cubeSpacing, trackerNodeLength: trackerNodeLength, lesson: lesson)
        containerBoxNode.delegate = self
        containerBoxNode.position = SCNVector3(0, 0.6, 0)
        containerBoxNode.runFadeInAction(completion: {
            self.containerBoxNode.runAssembleSquareAction(completion: {
                self.fadeInBottomStackView() { }
            })
        })
        mainNode.addChildNode(containerBoxNode)
    }
}

// MARK: ARLessonViewController - Queue Lesson
extension ARLessonViewController {
    func runQueueLesson() {
        runStackLesson()
    }
}

// MARK: ARLessonViewController - Singly-Linked List Lesson
extension ARLessonViewController {
    func runSinglyLinkedListLesson() {
        fadeInBottomStackView() { }
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
    func fadeInSubtitleView(completion: @escaping () -> ()) {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseIn], animations: {
                self.subtitleView.alpha = 1
            }, completion: { _ in completion() })
        }
    }
    
    func fadeOutSubtitleView(completion: @escaping () -> ()) {
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
        
    }
}

// MARK: ARLessonViewController - Subtitle
extension ARLessonViewController: SubtitleViewDelegate {
    func subtitleDidTranslate(y: CGFloat) {
        self.subtitleViewBottomConstraint?.update(offset: -y)
        UIView.animate(withDuration: 0, delay: 0, usingSpringWithDamping: 0, initialSpringVelocity: 0, options: [], animations: {
            self.view.layoutIfNeeded()
        }, completion: { _ in
            
        })
    }
    
    func refreshSubtitleView() {
        if subtitleViewMaximized {
            animateMaximizedSubtitleView()
        } else {
            animateMinimizeSubtitleView()
        }
    }
    
    
    func closeButtonDidTouchUpInside() {
        DispatchQueue.main.async {
            SpeechSynthesizer.shared.stopSpeaking()
            self.minimizeSubtitleView()
            self.fadeOutSubtitleView {
                self.fadeInBottomStackView(completion: {})
            }
        }
    }
    
    func sliderButtonDidTouchUpInside() {
        DispatchQueue.main.async {
            if !self.subtitleViewMaximized {
                self.maximizeSubtitleView()
            } else {
                self.minimizeSubtitleView()
            }
        }
        
    }
    
}

// MARK: ARLessonViewController - Subtitle
extension ARLessonViewController {
    
}
