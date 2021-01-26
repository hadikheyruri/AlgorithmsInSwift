//
//  Stack.swift
//  LinkedListStack
//
//  Created by Hadi Kheyruri on 2020-10-13.
//  Copyright © 2020 SerenaVisions Technology Inc. All rights reserved.
//

import Foundation

/// A stack is LIFO (Last In, First Out) structure. In a stack elements that are pushed in
/// last, get poped out first. A stack can be implemented using an array or a linked list.
/// This implementation uses a linked list.
class StackList<T: Comparable> {
    
    private var list  = LinkedList<T>()
    private var track = LinkedList<T>()
    
    /// Determines whether the stack is empty or not.
    ///
    /// - returns: A boolean indicating if the stack is empty or not.
    var isEmpty: Bool { return self.list.isEmpty }
    
    /// Pushes an item to the top of the stack.
    ///
    /// - parameter element: A value that gets pushed to the top of the stack.
    func push(_ element: T) {
        
        self.list.push(element: element)
        
        if let last = self.track.peek() {
            if element > last {
                self.track.push(element: element)
            } else {
                self.track.push(element: last)
            }
        } else {
            self.track.push(element: element)
        }
    }
    
    /// Removes an item from top of the stack.
    ///
    /// - returns: The value that is removed from top of the stack, nil if stack is empty.
    @discardableResult func pop() -> T? {
        
        if self.list.isEmpty { return nil }
        
        let pop = self.list.pop()
        _ = self.track.pop()
        return pop
    }
    
    /// Observes the item from top of the stack.
    ///
    /// - returns: The observed item from top of the stack, nil if stack is empty.
    func peek() -> T? {
        return self.list.peek()
    }
    
    /// Determines the largest value in the stack.
    ///
    /// - returns: The largest value in the stack, nil if stack is empty.
    func max() -> T? {
        if let last = self.track.peek() { return last }
        return nil
    }
}

extension StackList: CustomStringConvertible {
    var description: String {
        return self.list.displayString()
    }
}
