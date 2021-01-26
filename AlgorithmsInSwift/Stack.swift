//
//  Stack.swift
//  DSA_Easy
//
//  Created by Hadi Kheyruri on 2020-11-18.
//  Copyright © 2020 SerenaVisions Technology Inc. All rights reserved.
//

import Foundation

/// A stack is LIFO (Last In, First Out) structure. In a stack elements that are pushed in
/// last, get poped out first. A stack can be implemented using an array or a linked list.
/// This implementation uses an array.
struct Stack<T> {
    
    private var stack = [T]()
    
    /// Determines whether the stack is empty or not.
    ///
    /// - returns: A boolean indicating if the stack is empty or not.
    var isEmpty : Bool { return self.stack.isEmpty }
    
    /// The number of elements in the stack.
    var count: Int { return self.stack.count }
    
    /// Pushes an item to the top of the stack.
    ///
    /// - parameter element: A value that gets pushed to the top of the stack.
    mutating func push(_ element: T) {
        self.stack.append(element)
    }

    /// Observes the item from top of the stack.
    ///
    /// - returns: The observed item from top of the stack, nil if stack is empty.
    mutating func peek() -> T? {
        if self.isEmpty { return nil }
        return self.stack.last
    }
    
    /// Removes an item from top of the stack.
    ///
    /// - returns: The value that is removed from top of the stack.
    @discardableResult mutating func pop() -> T? {
        if self.isEmpty { return nil }
        return self.stack.removeLast()
    }
    
    /// Dumps the stack as an array while preserving the stack order.
    ///
    /// - returns: An array of all elements in the stack.
    mutating func allElements() -> [T] {
        return self.stack
    }
}
