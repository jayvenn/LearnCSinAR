//
//  SubtitleTextView.swift
//  Learn CS in AR
//
//  Created by Jayven Nhan on 5/9/18.
//  Copyright © 2018 Jayven Nhan. All rights reserved.
//

import UIKit
import SnapKit

enum BigOComplexity: String {
    case constant = "constant"
    case logarithmic = "O(logn)"
    case linear = "O(n)"
}

// MARK: SubtitleTextView
final class SubtitleTextView: UITextView {
    
    let titleColor = UIColor.black
    let subtitleColor = UIColor.black
    let bodyColor = UIColor.darkGray
    
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
                                   NSAttributedStringKey.font: Font(object: .textViewBody).instance]
        let titleAttributedText = NSMutableAttributedString(string: "\n", attributes: titleTextAttributes)
        
        let typeBodyTextAttributes = [NSAttributedStringKey.foregroundColor: bodyColor,
                                      NSAttributedStringKey.font: Font(object: .textViewBody).instance]
        let typeBodyAttributedText = NSMutableAttributedString(string: getTypeBodyText() + "\n\n",
                                                               attributes: typeBodyTextAttributes)
        titleAttributedText.append(typeBodyAttributedText)
        
        let fromExampleBodyTextAttributes = [NSAttributedStringKey.foregroundColor: bodyColor,
                                             NSAttributedStringKey.font: Font(object: .textViewBody).instance]
        let fromExampleBodyAttributedText = NSMutableAttributedString(string: getFromExampleBodyText() + "\n\n",
                                                                      attributes: fromExampleBodyTextAttributes)
        titleAttributedText.append(fromExampleBodyAttributedText)
        
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
            return "A stack uses last-in-first-out (LIFO) ordering."
        case .queue:
            return "A queue uses the first-in-first-out (FIFO) ordering."
//            "Imagine lining up to get the latest Star Wars movie ticket, the first person in line to get the ticket is also the first person out."
        case .singlyLinkedList:
            return "A \(lesson.name.rawValue.lowercased()) uses a sequence of elements where each element has a reference to the next element."
        case .doublyLinkedList:
            return "A \(lesson.name.rawValue.lowercased()) uses a sequnce of elements where each element references the next element with the next element referencing back to the first element."
        }
    }
    
    func getFromExampleBodyText() -> String {
        switch lesson.name {
        case .stack:
            return "If the box that moves into the container first wants to move out of the container, it will have to wait until every other boxes have moved out of the container before it can do the same. Conversely, the box that moves into the container last can move out of the container first."
        case .queue:
            return "The box that moves into the container first is the box that can move out of the container first. Conversely, the box that moves into the container last is the box that can move out of the container last."
        case .singlyLinkedList:
            return "The first box has a reference to the second box. The second box has a reference to the third box. The third box’s next box reference is nothing or nil."
        case .doublyLinkedList:
            return "The first cube references the second cube. The second cube references the first cubes. The same referencing procedure occurs between the second and third cubes."
        }
    }
    
    func getPutSimplyBodyText() -> String {
        switch lesson.name {
        case .stack:
            return "Go in first, get out last.\nGo in last, get out first."
        case .queue:
            return "Go in first, get out first.\nGo in last, get out last."
        case .singlyLinkedList:
            return "First points second.\nSecond points third.\nAnd so on until there is no longer the next box to point to…"
        case .doublyLinkedList:
            return "First points second. Second points first. Second points third. Third points second. And on and on."
        }
    }
}

// MARK: SubtitleTextView - Operations
extension SubtitleTextView {
    func setOperationText() {
        let titleTextAttributes = [NSAttributedStringKey.foregroundColor: titleColor,
                                   NSAttributedStringKey.font: Font(object: .textViewBody).instance]
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
            let bodyAttributedText = NSMutableAttributedString(string: self.getDescriptionOf(operation) + "\n\n",
                                                                   attributes: bodyTextAttributes)
            titleAttributedText.append(bodyAttributedText)
        }
        
        attributedText = titleAttributedText
    }
    
    func getDescriptionOf(_ operation: Operation) -> String {
        switch operation {
        case .push:
            return "Add a box by sliding a box from the container's back to the container's front."
        case .pop:
            return "Remove the box closest to the container's back."
        case .peek:
            return "Look at the box closest to the container's back."
        case .isEmpty:
            return "Check whether the container contains any box."
        case .enqueue:
            return "Add a box by sliding a box from the container's back to the container's front, like a Stack's push(📦)."
        case .dequeue:
            return "Remove the box closest to the container's front."
        case .append:
            return "Add a box to the end of the collection."
        case .remove:
            return "Remove a box at a particular index."
        case .nodeAtIndex:
            return "Return the box at a particular index."
        case .removeAll:
            return "Remove everything from the collection."
        case .insertAfter:
            return "Insert a box after another box."
        case .removeLast:
            return "Remove the last box from the collection."
        case .removeAfter:
            return "Remove the box after the indicated box."
        }
    }
    
}

// MARK: SubtitleTextView - Big O
extension SubtitleTextView {
    func setBigOText() {
        let titleTextAttributes = [NSAttributedStringKey.foregroundColor: titleColor,
                                   NSAttributedStringKey.font: Font(object: .textViewBody).instance]
        let titleAttributedText = NSMutableAttributedString(string: "\n", attributes: titleTextAttributes)
        
        for operation in lesson.operations {
            // Subtitle
            let subtitleTextAttributes = [NSAttributedStringKey.foregroundColor: subtitleColor,
                                          NSAttributedStringKey.font: Font(object: .textViewSubtitle).instance]
            let subtitleAttributedText = NSMutableAttributedString(string: getBigOSubtitleFor(operation) + "\n",
                                                                   attributes: subtitleTextAttributes)
            titleAttributedText.append(subtitleAttributedText)
            
            let bodyTextAttributes = [NSAttributedStringKey.foregroundColor: bodyColor,
                                      NSAttributedStringKey.font: Font(object: .textViewSubtitle).instance]
            let bodyAttributedText = NSMutableAttributedString(string: self.getBigODescriptionOf(operation) + "\n\n",
                                                               attributes: bodyTextAttributes)
            titleAttributedText.append(bodyAttributedText)
        }
        
        attributedText = titleAttributedText
    }
    
    
    func getBigOSubtitleFor(_ operation: Operation) -> String {
        var text = operation.rawValue
        text += " == "
        switch operation {
        case .nodeAtIndex:
            text += BigOComplexity.linear.rawValue
        default:
            text += BigOComplexity.constant.rawValue
        }
        return text
    }
    
    func getBigODescriptionOf(_ operation: Operation) -> String {
        var text = ""
        switch operation {
        case .push:
            text += "elements.append(element)"
        case .pop:
            text += "return elements.popLast()"
        case .peek:
            text += "return elements.last"
        case .isEmpty:
            switch lesson.name {
            case .singlyLinkedList:
                text += "return headNode == nil"
            default:
                text += "elements.isEmpty"
            }
        case .enqueue:
            text += "elements.append(element)"
        case .dequeue:
            text += "elements.removeFirst()"
        case .append:
            text += """
            guard !isEmpty else {
            \(String.tab)push(value)
            \(String.tab)return
            }
            tail.next = newNode
            tail = tail.next
            """
        case .remove:
            break
        case .nodeAtIndex:
            text += """
            var currentNode = headNode\n
            var currentIndex = 0\n
            while currentNode != nil, currentIndex < index {\n
            \(String.tab)currentNode = currentNode!.next\n
            \(String.tab)currentIndex += 1\n
            }
            return currentNode
            """
        case .removeAll:
            text += "headNode = nil"
        case .insertAfter:
            text += ""
        case .removeLast:
            text += ""
        case .removeAfter:
            text += ""
        }
        
        return text
    }
    
}
