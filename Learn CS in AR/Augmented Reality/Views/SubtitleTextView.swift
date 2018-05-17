//
//  SubtitleTextView.swift
//  Learn CS in AR
//
//  Created by Jayven Nhan on 5/9/18.
//  Copyright © 2018 Jayven Nhan. All rights reserved.
//

import UIKit
import SnapKit

// MARK: SubtitleTextView
class SubtitleTextView: UITextView {
    
    let titleColor = UIColor.black
    let subtitleColor = UIColor.darkGray
    let bodyColor = UIColor.black
    
    var lesson: Lesson
    
    init(lesson: Lesson) {
        self.lesson = lesson
        super.init(frame: .zero, textContainer: nil)
        setInitialProperties()
        setOffsets()
    }
    
    func setInitialProperties() {
        isEditable = false
        textContainerInset = UIEdgeInsets.zero
        textContainer.lineFragmentPadding = 0
    }
    
    func setOffsets() {
        let side: CGFloat = 16
        scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 0, -side)
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        super.canPerformAction(action, withSender: sender)
        return false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: SubtitleTextView - Ordering
extension SubtitleTextView {
    func setOrderingText() {
        let titleTextAttributes = [NSAttributedStringKey.foregroundColor: titleColor,
                                   NSAttributedStringKey.font: Font(object: .textViewSubtitle).instance]
        let titleAttributedText = NSMutableAttributedString(string: "\n", attributes: titleTextAttributes)
        
        // TYPE
        let typeSubtitleTextAttributes = [NSAttributedStringKey.foregroundColor: subtitleColor,
                                          NSAttributedStringKey.font: Font(object: .textViewSubtitle).instance]
        let typeSubtitleAttributedText = NSMutableAttributedString(string: "Ordering Type" + "\n",
                                                                   attributes: typeSubtitleTextAttributes)
        titleAttributedText.append(typeSubtitleAttributedText)
        
        let typeBodyTextAttributes = [NSAttributedStringKey.foregroundColor: bodyColor,
                                      NSAttributedStringKey.font: Font(object: .textViewBody).instance]
        let typeBodyAttributedText = NSMutableAttributedString(string: getTypeBodyText() + "\n\n",
                                                               attributes: typeBodyTextAttributes)
        titleAttributedText.append(typeBodyAttributedText)
        
        // FROM EXAMPLE
        let fromExampleSubtitleTextAttributes = [NSAttributedStringKey.foregroundColor: subtitleColor,
                                                 NSAttributedStringKey.font: Font(object: .textViewSubtitle).instance]
        let fromExampleSubtitleAttributedText = NSMutableAttributedString(string: "From Example" + "\n",
                                                                          attributes: fromExampleSubtitleTextAttributes)
        titleAttributedText.append(fromExampleSubtitleAttributedText)
        
        let fromExampleBodyTextAttributes = [NSAttributedStringKey.foregroundColor: bodyColor,
                                             NSAttributedStringKey.font: Font(object: .textViewBody).instance]
        let fromExampleBodyAttributedText = NSMutableAttributedString(string: getFromExampleBodyText() + "\n\n",
                                                                      attributes: fromExampleBodyTextAttributes)
        titleAttributedText.append(fromExampleBodyAttributedText)
        
        // PUT SIMPLY
        let putSimplySubtitleTextAttributes = [NSAttributedStringKey.foregroundColor: subtitleColor,
                                               NSAttributedStringKey.font: Font(object: .textViewSubtitle).instance]
        let putSimplySubtitleAttributedText = NSMutableAttributedString(string: "Put Simply" + "\n",
                                                                        attributes: putSimplySubtitleTextAttributes)
        titleAttributedText.append(putSimplySubtitleAttributedText)
        
        let putSimplyBodyTextAttributes = [NSAttributedStringKey.foregroundColor: bodyColor,
                                           NSAttributedStringKey.font: Font(object: .textViewBody).instance]
        let putSimplyBodyAttributedText = NSMutableAttributedString(string: getPutSimplyBodyText() + "\n\n",
                                                                    attributes: putSimplyBodyTextAttributes)
        titleAttributedText.append(putSimplyBodyAttributedText)
        
        attributedText = titleAttributedText
    }
    
    func getTypeBodyText() -> String {
        switch lesson.name {
        case .stack:
            return "A stack uses the last-in-first-out ordering (also referred to as LIFO)."
        case .queue:
            return ""
        }
    }
    
    func getFromExampleBodyText() -> String {
        switch lesson.name {
        case .stack:
            return "This means that the box that moves into the container first is the box that moves out of the container last. Conversely, the box that moves into the container last is the box that moves out of the container first."
        case .queue:
            return ""
        }
    }
    
    func getPutSimplyBodyText() -> String {
        switch lesson.name {
        case .stack:
            return "Go in first, get out last.\nGo in last, get out first."
        case .queue:
            return ""
        }
    }
}

// MARK: SubtitleTextView - Operations
extension SubtitleTextView {
    func setOperationText() {
        let titleTextAttributes = [NSAttributedStringKey.foregroundColor: titleColor,
                                   NSAttributedStringKey.font: Font(object: .textViewTitle).instance]
        let titleAttributedText = NSMutableAttributedString(string: "\n", attributes: titleTextAttributes)
        
        for operation in lesson.operations {
            // Subtitle
            let subtitleTextAttributes = [NSAttributedStringKey.foregroundColor: subtitleColor,
                                          NSAttributedStringKey.font: Font(object: .textViewSubtitle).instance]
            let subtitleAttributedText = NSMutableAttributedString(string: "\(operation.rawValue)" + "\n",
                                                                   attributes: subtitleTextAttributes)
            titleAttributedText.append(subtitleAttributedText)
            
            let bodyTextAttributes = [NSAttributedStringKey.foregroundColor: bodyColor,
                                          NSAttributedStringKey.font: Font(object: .textViewSubtitle).instance]
            let bodyAttributedText = NSMutableAttributedString(string: self.getDescriptionOf(operation) + "\n",
                                                                   attributes: bodyTextAttributes)
            titleAttributedText.append(bodyAttributedText)
        }
        
        attributedText = titleAttributedText
    }
    
    func getDescriptionOf(_ operation: Operation) -> String {
        switch operation {
        case .push:
            return "Add a box by sliding the box from the container's opening until it either end of the container."
        case .pop:
            return "Remove the last box you added to the container."
        case .peek:
            return "Look at the box closest to the container's opening."
        case .isEmpty:
            return "Check whether the container contains any box."
        }
    }
    
}
