//
//  SubtitleTextView.swift
//  Learn CS in AR
//
//  Created by Jayven Nhan on 5/9/18.
//  Copyright © 2018 Jayven Nhan. All rights reserved.
//

import UIKit
import SnapKit
import AVFoundation

enum BigOComplexity: String {
//    case constant = "O(1) - constant"
//    case logarithmic = "O(logn) - logarithmic"
//    case linear = "O(n) - linear"
    
    case constant = "O(1)"
    case logarithmic = "O(logn)"
    case linear = "O(n)"
}

let elementName = "cube"
let elementNamePlural = "cubes"
let elementSymbol = "cube"

// MARK: SubtitleTextView
final class SubtitleTextView: UITextView {
    
    let titleColor = UIColor.black
    let subtitleColor = UIColor.black
    let bodyColor = UIColor.darkGray
    
    var lesson: Lesson
    
    let initialSpacerText = "\n\n"
    
    init(lesson: Lesson) {
        self.lesson = lesson
        super.init(frame: .zero, textContainer: nil)
        setInitialProperties()
        setOffsets()
        accessibilityLabel = "description"
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
        let fonts = getTextViewFonts()
        let textViewTitleFont: UIFont = fonts.textViewBodyFont
        let textViewBodyFont: UIFont = fonts.textViewBodyFont
        
        let titleTextAttributes = [NSAttributedStringKey.foregroundColor: titleColor,
                                   NSAttributedStringKey.font: textViewTitleFont]
        let titleAttributedText = NSMutableAttributedString(string: initialSpacerText, attributes: titleTextAttributes)
        
        let typeBodyTextAttributes = [NSAttributedStringKey.foregroundColor: bodyColor,
                                      NSAttributedStringKey.font: textViewBodyFont]
        let typeBodyAttributedText = NSMutableAttributedString(string: getTypeBodyText() + "\n\n",
                                                               attributes: typeBodyTextAttributes)
        titleAttributedText.append(typeBodyAttributedText)
        
        let fromExampleBodyTextAttributes = [NSAttributedStringKey.foregroundColor: bodyColor,
                                             NSAttributedStringKey.font: textViewBodyFont]
        let fromExampleBodyAttributedText = NSMutableAttributedString(string: getFromExampleBodyText() + "\n\n",
                                                                      attributes: fromExampleBodyTextAttributes)
        titleAttributedText.append(fromExampleBodyAttributedText)
        
        let putSimplyBodyTextAttributes = [NSAttributedStringKey.foregroundColor: bodyColor,
                                           NSAttributedStringKey.font: textViewBodyFont]
        let putSimplyBodyAttributedText = NSMutableAttributedString(string: getPutSimplyBodyText() + "\n\n",
                                                                    attributes: putSimplyBodyTextAttributes)
        titleAttributedText.append(putSimplyBodyAttributedText)
        
        attributedText = titleAttributedText
        let accessibilityValue = getTypeBodyText() + "\n" + getFromExampleBodyText() + "\n" + getPutSimplyBodyText()
        self.accessibilityValue = accessibilityValue
        
//        speak(accessibilityValue)
    }
    
    func getTypeBodyText() -> String {
        switch lesson.name {
        case .stack:
            return "A stack data structure uses the last-in-first-out (LIFO) ordering."
        case .queue:
            return "A queue data structure uses the first-in-first-out (FIFO) ordering."
//            "Imagine lining up to get the latest Star Wars movie ticket, the first person in line to get the ticket is also the first person out."
        case .singlyLinkedList:
            return "A \(lesson.name.rawValue.lowercased()) data structure uses an ordering sequence where each element references the next element if the next element exists."
        case .doublyLinkedList:
            return "A \(lesson.name.rawValue.lowercased()) data structure uses an ordering sequence where each element references the next element if the next element exists. In addition, the next element that is being referenced will also references back to the element that references it."
        case .binaryTree:
            return "A \(lesson.name.rawValue.lowercased()) data structure uses an ordering sequence where whenever a new element is added to a tree, if there is a root node, then the new element will be in the left or right hand side of the root node depending on if it is smallest or largest number of the root node respectiively."
        }
    }
    
    func getFromExampleBodyText() -> String {
        switch lesson.name {
        case .stack:
            return "If the \(elementName) that moves into the container first wants to move out of the container, it will have to wait until every other \(elementNamePlural) have moved out of the container before it can do the same. Conversely, the \(elementName) that moves into the container last can move out of the container first."
        case .queue:
            return "The \(elementName) that moves into the container first is the \(elementName) that can move out of the container first. Conversely, the \(elementName) that moves into the container last is the \(elementName) that can move out of the container last."
        case .singlyLinkedList:
            return "The first \(elementName) has a reference to the second \(elementName). The second \(elementName) has a reference to the third \(elementName). The third \(elementName)’s next \(elementName) reference is nothing or nil."
        case .doublyLinkedList:
            return "The first cube references the second cube. The second cube references the first cubes. The same referencing procedure occurs between the second and third cubes."
        case .binaryTree:
            return "The first cube references a cube to the left and a cube to the right. The cube in the left is smaller than the cube to its right. The two cubes beneath the root node are called siblings."
        }
    }
    
    func getPutSimplyBodyText() -> String {
        switch lesson.name {
        case .stack:
            return "Go in first, get out last.\nGo in last, get out first."
        case .queue:
            return "Go in first, get out first.\nGo in last, get out last."
        case .singlyLinkedList:
            return "First references second. \nSecond references third. \nThis pattern continues until you reach the last \(elementName)."
//            return "First references second. \nSecond references third. \nAnd so on until there is no longer the next \(elementName) to reference to…"
        case .doublyLinkedList:
            return "First references second. \nSecond references first. \nSecond references third. \nThird references second. \nThis pattern continues until you reach the last \(elementName)."
//            return "First references second. \nSecond references first. \nSecond references third. \nThird references second. \nAnd on and on."
        case .binaryTree:
            return "Root stays single. Can have a maximum of two children. All children are bound to have a maximum of two children. Children on the same hiearchy are called siblings. The node which a node references from is called a parent node."
        }
    }
    
    func getTextViewFonts() -> (textViewTitleFont: UIFont, textViewBodyFont: UIFont) {
        let preferredContentSizeCategory = traitCollection.preferredContentSizeCategory
        let textViewTitleFont: UIFont
        let textViewBodyFont: UIFont
        if preferredContentSizeCategory > .accessibilityMedium {
            textViewTitleFont = UIFont.preferredFont(forTextStyle: .headline, compatibleWith: UITraitCollection(displayScale: 36))
            textViewBodyFont = UIFont.preferredFont(forTextStyle: .body)
        } else {
            textViewTitleFont = Font(object: .textViewBody).instance
            textViewBodyFont = Font(object: .textViewBody).instance
        }
        return (textViewTitleFont, textViewBodyFont)
    }
}

// MARK: SubtitleTextView - Operations
extension SubtitleTextView {
    func setOperationText() {
        let fonts = getTextViewFonts()
        let textViewTitleFont: UIFont = fonts.textViewBodyFont
        let textViewBodyFont: UIFont = fonts.textViewBodyFont
        
        let titleTextAttributes = [NSAttributedStringKey.foregroundColor: titleColor,
                                   NSAttributedStringKey.font: textViewTitleFont]
        let titleAttributedText = NSMutableAttributedString(string: initialSpacerText, attributes: titleTextAttributes)
        
        var accessibilityValue = ""
        for operation in lesson.operations {
            // Subtitle
            let subtitleStr = "\(operation.rawValue)" + "\n"
            let subtitleTextAttributes = [NSAttributedStringKey.foregroundColor: subtitleColor,
                                          NSAttributedStringKey.font: textViewBodyFont]
            let subtitleAttributedText = NSMutableAttributedString(string: subtitleStr,
                                                                   attributes: subtitleTextAttributes)
            titleAttributedText.append(subtitleAttributedText)
            accessibilityValue.append(subtitleStr)
            
            let bodyTextStr = self.getDescriptionOf(operation) + "\n\n"
            let bodyTextAttributes = [NSAttributedStringKey.foregroundColor: bodyColor,
                                          NSAttributedStringKey.font: textViewBodyFont]
            let bodyAttributedText = NSMutableAttributedString(string: self.getDescriptionOf(operation) + "\n\n",
                                                                   attributes: bodyTextAttributes)
            titleAttributedText.append(bodyAttributedText)
            accessibilityValue.append(bodyTextStr)
        }
        
        attributedText = titleAttributedText
        self.accessibilityValue = accessibilityValue
//        speak(accessibilityValue)
    }
    
    func getDescriptionOf(_ operation: Operation) -> String {
        switch operation {
        case .push:
            return "Add a \(elementName) by sliding a cube from the container's back to the container's front."
        case .pop:
            return "Remove the \(elementName) closest to the container's back."
        case .peek:
            return "Look at the \(elementName) closest to the container's back."
        case .isEmpty:
            return "Check whether the container contains any \(elementName)."
        case .enqueue:
            return "Add a \(elementName) by sliding a \(elementName) from the container's back to the container's front, like a Stack's push(\(elementSymbol))."
        case .dequeue:
            return "Remove the \(elementName) closest to the container's front."
        case .append:
            return "Add a \(elementName) to the end of the collection."
        case .remove:
            return "Remove a \(elementName) at a particular index."
        case .nodeAtIndex:
            return "Return the \(elementName) at a particular index."
        case .removeAll:
            return "Remove everything from the collection."
        case .insertAfter:
            return "Insert a \(elementName) after another \(elementName)."
        case .removeLast:
            return "Remove the last \(elementName) from the collection."
        case .removeAfter:
            return "Remove the \(elementName) after the indicated \(elementName)."
        }
    }
    
}

// MARK: SubtitleTextView - Big O
extension SubtitleTextView {
    func setBigOText() {
        let fonts = getTextViewFonts()
        let textViewTitleFont: UIFont = fonts.textViewBodyFont
        let textViewBodyFont: UIFont = fonts.textViewBodyFont
        
        let titleTextAttributes = [NSAttributedStringKey.foregroundColor: titleColor,
                                   NSAttributedStringKey.font: textViewTitleFont]
        let titleAttributedText = NSMutableAttributedString(string: initialSpacerText, attributes: titleTextAttributes)
        
        var accessibilityValue = ""
        for operation in lesson.operations {
            // Subtitle
            let subtitleStr = getBigOSubtitleFor(operation) + "\n"
            let subtitleTextAttributes = [NSAttributedStringKey.foregroundColor: subtitleColor,
                                          NSAttributedStringKey.font: textViewBodyFont]
            let subtitleAttributedText = NSMutableAttributedString(string: subtitleStr,
                                                                   attributes: subtitleTextAttributes)
            titleAttributedText.append(subtitleAttributedText)
            accessibilityValue.append(subtitleStr)
            
            let bodyTextStr = getBigODescriptionOf(operation) + "\n\n"
            let bodyTextAttributes = [NSAttributedStringKey.foregroundColor: bodyColor,
                                      NSAttributedStringKey.font: textViewBodyFont]
            let bodyAttributedText = NSMutableAttributedString(string: bodyTextStr,
                                                               attributes: bodyTextAttributes)
            titleAttributedText.append(bodyAttributedText)
            accessibilityValue.append(bodyTextStr)
        }
        
        attributedText = titleAttributedText
        self.accessibilityValue = accessibilityValue
//        speak(accessibilityValue)
    }
    
    
    func getBigOSubtitleFor(_ operation: Operation) -> String {
        let text = operation.rawValue
        return text
    }
    
    func getBigODescriptionOf(_ operation: Operation) -> String {
        let text: String
        switch operation {
        case .nodeAtIndex:
            text = BigOComplexity.linear.rawValue
        default:
            text = BigOComplexity.constant.rawValue
        }
        return text
        
//        var text = ""
//        switch operation {
//        case .push:
//            text += "elements.append(element)"
//        case .pop:
//            text += "return elements.popLast()"
//        case .peek:
//            text += "return elements.last"
//        case .isEmpty:
//            switch lesson.name {
//            case .singlyLinkedList:
//                text += "return headNode == nil"
//            default:
//                text += "elements.isEmpty"
//            }
//        case .enqueue:
//            text += "elements.append(element)"
//        case .dequeue:
//            text += "elements.removeFirst()"
//        case .append:
//            text += """
//            guard !isEmpty else {
//            \(String.tab)push(value)
//            \(String.tab)return
//            }
//            tail.next = newNode
//            tail = tail.next
//            """
//        case .remove:
//            break
//        case .nodeAtIndex:
//            text += """
//            var currentNode = headNode\n
//            var currentIndex = 0\n
//            while currentNode != nil, currentIndex < index {\n
//            \(String.tab)currentNode = currentNode!.next\n
//            \(String.tab)currentIndex += 1\n
//            }
//            return currentNode
//            """
//        case .removeAll:
//            text += "headNode = nil"
//        case .insertAfter:
//            text += ""
//        case .removeLast:
//            text += ""
//        case .removeAfter:
//            text += ""
//        }
//
//        return text
    }
    
}
