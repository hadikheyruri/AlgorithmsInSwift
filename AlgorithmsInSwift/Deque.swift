//
//  Deque.swift
//  DSA_Easy
//
//  Created by Hadi Kheyruri on 2020-11-28.
//  Copyright © 2020 SerenaVisions Technology Inc. All rights reserved.
//

import Foundation

fileprivate class DequeNode<Element>: CustomStringConvertible {
    
    var value: Element?
    var next: DequeNode? // used to traverse the Deque and add nodes to the front.
    var last: DequeNode? // used to only remove nodes from rear.
    
    var description: String {
        guard let sValue = value else { return "" }
        return "\(sValue)"
    }
}

/// Deque is two sided queue in which operations of insertion and deletion
/// can be performed on both ends in constant time complexity of O(1).
class Deque<Element> {
    
    fileprivate var front: DequeNode<Element>?
    fileprivate var rear: DequeNode<Element>?
    fileprivate var counter: Int = 0
    
    /// Determines whether the deque is empty or not.
    ///
    /// - returns: A boolean indicating if the deque is empty or not.
    var isEmpty: Bool {
        guard let _ = front, let _ = rear else { return true }
        return false
    }
    
    /// Number of elements in the deque.
    ///
    /// - returns: An integer indicating number of elements in the deque.
    /// - complexity: O(1)
    var count: Int { return counter }
    
    /// Adds an item to front of the deque.
    ///
    /// - parameter item: An integer to be added to the front of the deque.
    /// - complexity: O(1)
    func insertFront(_ item: Element) {
        
        if self.isEmpty {
            let deq: DequeNode = DequeNode<Element>()
            deq.value  = item
            deq.last = nil
            deq.next = nil
            self.front = deq
            self.rear  = deq
            counter += 1
            return
        }
        
        if self.count == 1 {
            let deq: DequeNode = DequeNode<Element>()
            deq.value  = item
            deq.next   = self.rear
            self.front = deq
            self.rear?.last = self.front
            counter += 1
            return
        }
        
        let deq: DequeNode = DequeNode<Element>()
        self.front?.last = deq
        deq.value  = item
        deq.next   = self.front
        self.front = deq
        counter += 1
        
    }
    
    /// Adds an item to the end of the deque.
    ///
    /// - parameter item: An integer to be added to end of the deque.
    /// - complexity: O(1)
    func insertRear(_ item: Element) {
        
        if self.isEmpty {
            let deq: DequeNode = DequeNode<Element>()
            deq.value = item
            deq.last = nil
            deq.next = nil
            self.front = deq
            self.rear  = deq
            counter += 1
            return
        }
        
        if self.count == 1 {
            let deq: DequeNode = DequeNode<Element>()
            deq.value = item
            self.front?.next = deq
            deq.last = self.rear
            self.rear = deq
            counter += 1
            return
        }
        
        let deq: DequeNode = DequeNode<Element>()
        deq.value = item
        deq.last  = self.rear
        self.rear?.next = deq
        self.rear = deq
        counter += 1
    }
    
    /// Remove an item from front of the deque.
    ///
    /// - returns: An integer that is removed from end of the deque.
    /// - complexity: O(1)
    @discardableResult func removeFront() -> Element? {
        
        if self.isEmpty { return nil }
        
        let tmp = self.front?.value

        if self.count == 1 {
            self.front = nil
            self.rear = nil
            counter -= 1
        } else if self.count == 2 {
            self.rear?.next = nil
            self.rear?.last = nil
            self.front = self.rear
            counter -= 1
        } else {
            self.front = self.front?.next
            counter -= 1
        }
        
        return tmp
    }

    /// Remove an item from end of the deque.
    ///
    /// - returns: An integer that is removed from front of the deque.
    /// - complexity: O(1)
    @discardableResult func removeRear() -> Element? {
        
        if self.isEmpty { return nil }
        
        let tmp = self.rear?.value
        
        if self.count == 1 {
            self.front = nil
            self.rear = nil
            counter -= 1
        } else if self.count == 2 {
            self.front?.next = nil
            self.front?.last = nil
            self.rear = self.front
            counter -= 1
        } else {
            self.rear = self.rear?.last
            self.rear?.next = nil
            counter -= 1
        }

        return tmp
    }
    
    /// Looks up the value at the front of the deque.
    ///
    /// - returns: The value at front of the deque.
    /// - complexity: O(1)
    func peekFront() -> Element? {
        return self.front?.value
    }
    
    /// Looks up the value at the end of the deque.
    ///
    /// - returns: The value at the end of the deque.
    /// - complexity: O(1)
    func peekRear() -> Element? {
        return self.rear?.value
    }
    
    /// Dump all items in the deque in an array.
    ///
    /// - returns: The an array of all values in the deque while preserving their order.
    /// - complexity: O(1)
    func dump() -> [Element] {
        var array: [Element] = []
        var current = front
        
        if let value = current?.value { array.append(value) }
        while let next = current?.next {
            current = next
            if let value = current?.value { array.append(value) }
        }
        return array
    }
}

extension Deque: CustomStringConvertible {
    var description: String {
        var str = ""
        
        var current = front
        if let node = current { str += "|\(node)|" }
        while let next = current?.next {
            current = next
            if let node = current { str += " -> |\(node)|" }
        }
        return str
    }
}

extension Array {
    init(_ deq: Deque<Element>) {
        self.init()
        
        self = deq.dump()
    }
}
