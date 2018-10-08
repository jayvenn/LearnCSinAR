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
    case push =  "push(cube)"
    case pop = "pop()"
    case peek = "peek()"
    case isEmpty = "isEmpty()"
    
    case enqueue = "enqueue(cube)"
    case dequeue = "dequeue()"
    
    case append = "append(cube)"
    case remove = "remove(cube)"
    case nodeAtIndex = "elementAt(index: Int)"
    case removeAll = "removeAll()"
    
    case insertAfter = "insert(after: cube)"
    case removeLast = "removeLast()"
    case removeAfter = "remove(after: cube)"
    
    case find = "find(cube)"
    case addChild = "add(child: cube)"
    case removeChild = "remove(child: cube)"
    
    case comingSoon = "Coming Soon\nTap to Contribute"
}

struct Lesson {
    
    let name: LessonName
    
    lazy var operations: [Operation] = {
        var operations = [Operation]()
        switch name {
        case .stack:
            operations = [.push, .pop]
//            operations = [.push, .pop, .peek, .isEmpty]
        case .queue:
            operations = [.enqueue, .dequeue]
//            operations = [.enqueue, .dequeue, .peek, .isEmpty]
        case .singlyLinkedList, .doublyLinkedList:
            operations = [.comingSoon, .comingSoon]
//            operations = [.push, .pop]
//            operations = [.push, .append, .insertAfter, .nodeAtIndex, .pop, .removeLast, .removeAfter]
        case .binaryTree:
            operations = [.comingSoon, .comingSoon]
//            operations = [.find, .addChild, .removeChild]
        }
        return operations
    }()
    
    init(lessonName: LessonName) {
        self.name = lessonName
    }
    
}
