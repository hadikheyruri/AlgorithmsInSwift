//
//  Queue.swift
//  DSA_Easy
//
//  Created by Hadi Kheyruri on 2020-12-18.
//  Copyright © 2020 SerenaVisions Technology Inc. All rights reserved.
//

import Foundation

struct Queue<T> {
    
    private var inbox: Stack = Stack<T>()
    private var outbox: Stack = Stack<T>()
    
    /// A boolean indicating if the queue is empty or not.
    var isEmpty: Bool {
        return self.inbox.isEmpty && self.outbox.isEmpty
    }
    
    /// The number of elements in the queue.
    var count: Int { return self.inbox.count + self.outbox.count }
    
    /// Adds an element to the queue
    ///
    /// - parameter newElement: An element to be added to the front of the deque.
    /// - complexity: O(1)
    mutating func enqueue(newElement: T) {
        self.inbox.push(newElement)
    }
    
    /// Adds an element to the queue
    ///
    /// - parameter item: An element to be added to the front of the deque.
    /// - complexity: O(n), where n is the number of elements in the queue.
    @discardableResult mutating func dequeue() -> T? {
        
        if self.outbox.isEmpty {
            while let element = self.inbox.pop() {
                self.outbox.push(element)
            }
        }
        
        return self.outbox.pop()
    }
}
