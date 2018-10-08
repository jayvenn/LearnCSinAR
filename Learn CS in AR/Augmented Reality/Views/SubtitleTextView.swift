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
    
    case constant = "Constant - O(1)"
    case linear = "Linear - O(n)"
    case logarithmic = "Logarithmic - O(logn)"
    
//    case constant = "O(1)"
//    case logarithmic = "O(logn)"
//    case linear = "O(n)"
}

let elementName = NSLocalizedString("cube", comment: "cube")
let elementNamePlural = NSLocalizedString("cubes", comment: "cubes")
let elementSymbol = NSLocalizedString("cube", comment: "cube")

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
        scrollIndicatorInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: -side)
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
        
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: titleColor,
                                   NSAttributedString.Key.font: textViewTitleFont]
        let titleAttributedText = NSMutableAttributedString(string: initialSpacerText, attributes: titleTextAttributes)
        
        let typeBodyTextAttributes = [NSAttributedString.Key.foregroundColor: bodyColor,
                                      NSAttributedString.Key.font: textViewBodyFont]
        let typeBodyAttributedText = NSMutableAttributedString(string: getTypeBodyText() + "\n\n",
                                                               attributes: typeBodyTextAttributes)
        titleAttributedText.append(typeBodyAttributedText)
        
        let fromExampleBodyTextAttributes = [NSAttributedString.Key.foregroundColor: bodyColor,
                                             NSAttributedString.Key.font: textViewBodyFont]
        let fromExampleBodyAttributedText = NSMutableAttributedString(string: getFromExampleBodyText() + "\n\n",
                                                                      attributes: fromExampleBodyTextAttributes)
        titleAttributedText.append(fromExampleBodyAttributedText)
        
        let putSimplyBodyTextAttributes = [NSAttributedString.Key.foregroundColor: bodyColor,
                                           NSAttributedString.Key.font: textViewBodyFont]
        let putSimplyBodyAttributedText = NSMutableAttributedString(string: getPutSimplyBodyText() + "\n\n",
                                                                    attributes: putSimplyBodyTextAttributes)
        titleAttributedText.append(putSimplyBodyAttributedText)
        
        attributedText = titleAttributedText
        let accessibilityValue = getTypeBodyText() + "\n" + getFromExampleBodyText() + "\n" + getPutSimplyBodyText()
        self.accessibilityValue = accessibilityValue
    }
    
    func getTypeBodyText() -> String {
        switch lesson.name {
        case .stack:
            let string = "A stack data structure uses the last-in-first-out (LIFO) ordering."
            let localizedString = NSLocalizedString(string, comment: string)
            return localizedString
        case .queue:
            let string = "A queue data structure uses the first-in-first-out (FIFO) ordering."
            let localizedString = NSLocalizedString(string, comment: string)
            return localizedString
        case .singlyLinkedList:
            let lessonName = lesson.name.rawValue.lowercased()
            let string = "A %@ data structure uses an ordering sequence where each %@ references the next %@ if the next %@ exists."
            let localizedString = NSLocalizedString(string, comment: string)
            let localizedStringWithFormat =  String.localizedStringWithFormat(localizedString, lessonName, elementName, elementName, elementName)
            return localizedStringWithFormat.capitalizingFirstLetter()
        case .doublyLinkedList:
            let lessonName = lesson.name.rawValue.lowercased()
            let string = "A %@ data structure uses an ordering sequence where each %@ references the next %@ if the next %@ exists. In addition, the next %@ that is being referenced will also reference back to the %@ that references it."
            let localizedString = NSLocalizedString(string, comment: string)
            let localizedStringWithFormat =  String.localizedStringWithFormat(localizedString, lessonName, elementName, elementName, elementName, elementName, elementName)
            return localizedStringWithFormat.capitalizingFirstLetter()
        case .binaryTree:
            let lessonName = lesson.name.rawValue.lowercased()
            let string = "A %@ data structure uses an ordering sequence where each %@ can have a maximum of two children."
            let localizedString = NSLocalizedString(string, comment: string)
            let localizedStringWithFormat = String.localizedStringWithFormat(localizedString, lessonName, elementName)
            return localizedStringWithFormat.capitalizingFirstLetter()
        }
    }
    
    func getFromExampleBodyText() -> String {
        switch lesson.name {
        case .stack:
            let string = "If the %@ that moves into the container first wants to move out of the container, it will have to wait until every other %@ have moved out of the container before it can do the same. Conversely, the %@ that moves into the container last can move out of the container first."
            let localizedString = NSLocalizedString(string, comment: string)
            let localizedStringWithFormat =  String.localizedStringWithFormat(localizedString, elementName, elementName, elementName)
            return localizedStringWithFormat.capitalizingFirstLetter()
        case .queue:
            let string = "The %@ that moves into the container first is the %@ that can move out of the container first. Conversely, the %@ that moves into the container last is the %@ that can move out of the container last."
            let localizedString = NSLocalizedString(string, comment: string)
            let localizedStringWithFormat =  String.localizedStringWithFormat(localizedString, elementName, elementName, elementName, elementName)
            return localizedStringWithFormat.capitalizingFirstLetter()
        case .singlyLinkedList:
            let string = "The first %@ has a reference to the second %@. The second %@ has a reference to the third %@. The third %@’s next %@ reference is nothing or nil."
            let localizedString = NSLocalizedString(string, comment: string)
            let localizedStringWithFormat =  String.localizedStringWithFormat(localizedString, elementName, elementName, elementName, elementName, elementName, elementName)
            return localizedStringWithFormat.capitalizingFirstLetter()
        case .doublyLinkedList:
            let string = "The first %@ references the second %@. The second %@ references the first %@. The same referencing procedure occurs between the second and third %@."
            let localizedString = NSLocalizedString(string, comment: string)
            let localizedStringWithFormat =  String.localizedStringWithFormat(localizedString, elementName, elementName, elementName, elementName, elementName)
            return localizedStringWithFormat.capitalizingFirstLetter()
        case .binaryTree:
            let string = "When a child %@ is added onto a root %@, the child %@ will reside either on the left or right of the root %@. The child %@ position will depend on the %@'s size in comparison to the other child %@. The smaller %@ will reside on the left. The bigger %@ will reside on the right. If there the added %@ is the only child, it will be reside on the left. When a %@ is added, a reference is created."
            let localizedString = NSLocalizedString(string, comment: string)
            let localizedStringWithFormat =  String.localizedStringWithFormat(localizedString, elementName, elementName, elementName, elementName, elementName, elementName, elementName, elementName, elementName, elementName, elementName)
            return localizedStringWithFormat.capitalizingFirstLetter()
        }
    }
    
    func getPutSimplyBodyText() -> String {
        switch lesson.name {
        case .stack:
            let string = "Go in first, get out last.\nGo in last, get out first."
            let localizedString = NSLocalizedString(string, comment: string)
            return localizedString
        case .queue:
            let string = "Go in first, get out first.\nGo in last, get out last."
            let localizedString = NSLocalizedString(string, comment: string)
            return localizedString
        case .singlyLinkedList:
            let string = "First references second. \nSecond references third. \nThis pattern continues until you reach the last %@."
            let localizedString = NSLocalizedString(string, comment: string)
            let localizedStringWithFormat =  String.localizedStringWithFormat(localizedString, elementName)
            return localizedStringWithFormat
        case .doublyLinkedList:
            let string = "First references second. \nSecond references first. \nSecond references third. \nThird references second. \nThis pattern continues until you reach the last %@."
            let localizedString = NSLocalizedString(string, comment: string)
            let localizedStringWithFormat =  String.localizedStringWithFormat(localizedString, elementName)
            return localizedStringWithFormat
        case .binaryTree:
            let string = "A %@ can have a maximum of two children. All children are bound to have a maximum of two children. Children in the same hierarchy are called siblings. The %@ which a %@ references from is called a parent node."
            let localizedString = NSLocalizedString(string, comment: string)
            let localizedStringWithFormat =  String.localizedStringWithFormat(localizedString, elementName, elementName, elementName)
            return localizedStringWithFormat
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
        
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: titleColor,
                                   NSAttributedString.Key.font: textViewTitleFont]
        let titleAttributedText = NSMutableAttributedString(string: initialSpacerText, attributes: titleTextAttributes)
        
        var accessibilityValue = ""
        for operation in lesson.operations {
            // Subtitle
            let subtitleStr = "\(operation.rawValue)" + "\n"
            let subtitleTextAttributes = [NSAttributedString.Key.foregroundColor: subtitleColor,
                                          NSAttributedString.Key.font: textViewBodyFont]
            let subtitleAttributedText = NSMutableAttributedString(string: subtitleStr,
                                                                   attributes: subtitleTextAttributes)
            titleAttributedText.append(subtitleAttributedText)
            accessibilityValue.append(subtitleStr)
            
            let bodyTextStr = self.getDescriptionOf(operation) + "\n\n"
            let bodyTextAttributes = [NSAttributedString.Key.foregroundColor: bodyColor,
                                          NSAttributedString.Key.font: textViewBodyFont]
            let bodyAttributedText = NSMutableAttributedString(string: self.getDescriptionOf(operation) + "\n\n",
                                                                   attributes: bodyTextAttributes)
            titleAttributedText.append(bodyAttributedText)
            accessibilityValue.append(bodyTextStr)
        }
        
        attributedText = titleAttributedText
        self.accessibilityValue = accessibilityValue
    }
    
    func getDescriptionOf(_ operation: Operation) -> String {
        switch operation {
        case .push, .enqueue:
            return "Add a \(elementName) into the container."
        case .append:
            return "Add a \(elementName) to the end of the container."
        case .pop, .dequeue:
            return "Remove a cube \(elementName) from the container."
        case .peek:
            return "Show the latest added \(elementName) in the container."
        case .isEmpty:
            return "Check whether the container contains any \(elementName)."
        case .remove:
            return "Remove a particular \(elementName) from the container."
        case .nodeAtIndex:
            return "Show a particular \(elementName) in the container."
        case .removeAll:
            return "Remove all \(elementNamePlural) from container."
        case .insertAfter:
            return "Insert a \(elementName) after another \(elementName)."
        case .removeLast:
            return "Remove the last \(elementName) from the container."
        case .removeAfter:
            return "Remove a particular \(elementName) after another \(elementName)."
        case .find:
            return "Find a particular \(elementName) on a tree and check if it exists."
        case .addChild:
            return "Add a child \(elementName) onto a tree."
        case .removeChild:
            return "Remove a particular child \(elementName) from a tree."
        default:
            return ""
        }
    }
    
//    func getDescriptionOf(_ operation: Operation) -> String {
//        switch operation {
//        case .push:
//            return "Add a \(elementName) by sliding a \(elementName) from the container's back to the container's front."
//        case .pop:
//            return "Remove the \(elementName) closest to the container's back."
//        case .peek:
//            return "Look at the \(elementName) closest to the container's back."
//        case .isEmpty:
//            return "Check whether the container contains any \(elementName)."
//        case .enqueue:
//            return "Add a \(elementName) by sliding a \(elementName) from the container's back to the container's front, like a Stack's push(\(elementSymbol))."
//        case .dequeue:
//            return "Remove the \(elementName) closest to the container's front."
//        case .append:
//            return "Add a \(elementName) to the end of the collection."
//        case .remove:
//            return "Remove a \(elementName) at a particular index."
//        case .nodeAtIndex:
//            return "Return the \(elementName) at a particular index."
//        case .removeAll:
//            return "Remove everything from the collection."
//        case .insertAfter:
//            return "Insert a \(elementName) after another \(elementName)."
//        case .removeLast:
//            return "Remove the last \(elementName) from the collection."
//        case .removeAfter:
//            return "Remove the \(elementName) after the indicated \(elementName)."
//        }
//    }
    
}

// MARK: SubtitleTextView - Big O
extension SubtitleTextView {
    func setBigOText() {
        let fonts = getTextViewFonts()
        let textViewTitleFont: UIFont = fonts.textViewBodyFont
        let textViewBodyFont: UIFont = fonts.textViewBodyFont
        
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: titleColor,
                                   NSAttributedString.Key.font: textViewTitleFont]
        let titleAttributedText = NSMutableAttributedString(string: initialSpacerText, attributes: titleTextAttributes)
        
        var accessibilityValue = ""
        for operation in lesson.operations {
            // Subtitle
            let subtitleStr = getBigOSubtitleFor(operation) + "\n"
            let subtitleTextAttributes = [NSAttributedString.Key.foregroundColor: subtitleColor,
                                          NSAttributedString.Key.font: textViewBodyFont]
            let subtitleAttributedText = NSMutableAttributedString(string: subtitleStr,
                                                                   attributes: subtitleTextAttributes)
            titleAttributedText.append(subtitleAttributedText)
            accessibilityValue.append(subtitleStr)
            
            let bodyTextStr = getBigODescriptionOf(operation) + "\n\n"
            let bodyTextAttributes = [NSAttributedString.Key.foregroundColor: bodyColor,
                                      NSAttributedString.Key.font: textViewBodyFont]
            let bodyAttributedText = NSMutableAttributedString(string: bodyTextStr,
                                                               attributes: bodyTextAttributes)
            titleAttributedText.append(bodyAttributedText)
            accessibilityValue.append(bodyTextStr)
        }
        
        attributedText = titleAttributedText
        self.accessibilityValue = accessibilityValue
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
        case .addChild, .removeChild, .find:
            text = BigOComplexity.logarithmic.rawValue
        default:
            text = BigOComplexity.constant.rawValue
        }
        return text
    }
    
}
