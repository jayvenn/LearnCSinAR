//
//  Lesson.swift
//  Learn CS in AR
//
//  Created by Jayven Nhan on 4/26/18.
//  Copyright © 2018 Jayven Nhan. All rights reserved.
//

import UIKit

enum LessonName: String {
    case stack = "Stack"
    case queue = "Queue"
    case singlyLinkedList = "Singly-Linked List"
    case doublyLinkedList = "Doubly-Linked List"
    case binaryTree = "Binary Tree"
}

enum Operation: String {
    case push =  "push(📦)"
    case pop = "pop()"
    case peek = "peek()"
    case isEmpty = "isEmpty()"
    
    case enqueue = "enqueue(📦)"
    case dequeue = "dequeue()"
    
    case append = "append(📦)"
    case remove = "remove(📦)"
    case nodeAtIndex = "elementAt(index: Int)"
    case removeAll = "removeAll()"
    
    case insertAfter = "insertAfter(after:📦)"
    case removeLast = "removeLast()"
    case removeAfter = "remove(after:📦)"
}

struct Lesson {
    
    let name: LessonName
    
    lazy var operations: [Operation] = {
        var operations = [Operation]()
        switch name {
        case .stack:
            operations = [.push, .pop, .peek, .isEmpty]
        case .queue:
            operations = [.enqueue, .dequeue, .peek, .isEmpty]
        case .singlyLinkedList:
            operations = [.push, .append, .insertAfter, .nodeAtIndex, .pop, .removeLast, .removeAfter]
        case .doublyLinkedList:
            operations = []
        case .binaryTree:
            operations = []
        }
        return operations
    }()
    
    init(lessonName: LessonName) {
        self.name = lessonName
    }
    
}
