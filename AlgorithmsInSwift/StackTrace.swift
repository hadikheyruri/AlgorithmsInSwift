//
//  StackTrace.swift
//  DSA_Easy
//
//  Created by Hadi Kheyruri on 2020-11-18.
//  Copyright © 2020 SerenaVisions Technology Inc. All rights reserved.
//

import Foundation

/// A stack is LIFO (Last In, First Out) structure. In a stack elements that are pushed in
/// last, get poped out first. A stack can be implemented using an array or a linked list.
/// This implementation uses an array and also traces the element with maximum value
/// in the Stack.
struct StackTrace<T: Comparable> {
    
    private var stack = [T]()
    private var track = [T]() /// Tracking current Maximum Element in a Stack.
    
    /// Determines whether the stack is empty or not.
    ///
    /// - returns: A boolean indicating if the stack is empty or not.
    var isEmpty : Bool {
        return self.stack.isEmpty
    }
    
    /// Pushes an item to the top of the stack.
    ///
    /// - parameter element: A value that gets pushed to the top of the stack.
    mutating func push(_ element: T) {
        self.stack.append(element)
        
        if let last = self.track.last {
            if element > last {
                self.track.append(element)
            } else {
                self.track.append(last)
            }
        } else {
            self.track.append(element)
        }
    }
    
    /// Removes an item from top of the stack.
    ///
    /// - returns: The value that is removed from top of the stack.
    @discardableResult mutating func pop() -> T? {
        
        if self.stack.isEmpty { return nil }
        
        let pop = self.stack.last
        self.stack.removeLast()
        self.track.removeLast()
        return pop
    }
    
    /// Observes the item from top of the stack.
    ///
    /// - returns: The observed item from top of the stack.
    mutating func peek() -> T? {
        return self.stack.last
    }
    
    /// Determines the largest value in the stack.
    ///
    /// - returns: The largest value in the stack.
    mutating func max() -> T? {
        return self.track.last
    }
}
