//
//  LinkedListStack.swift
//  LinkedListStack
//
//  Created by Hadi Kheyruri on 2020-10-13.
//  Copyright © 2020 SerenaVisions Technology Inc. All rights reserved.
//

import Foundation

fileprivate class ListNode<T>: CustomStringConvertible {
    var value: T?
    var last: ListNode?

    var description: String {
        if let _ = last, let value = self.value {
            return "|\(value)|-->"
        } else if let value = self.value {
            return "|\(value)|"
        }
        
        return ""
    }
}

class LinkedList<T>{
    
    private var top: ListNode<T>?
    
    /// Determines whether the linked list is empty or not.
    ///
    /// - returns: A boolean indicating if the linked list is empty or not.
    var isEmpty: Bool {
        guard let _ = self.top else { return true }
        return false
    }
    
    /// A look up at the top value in the linked list.
    ///
    /// - returns: The value of the top most element in the linked list, nil if the list is empty.
    func peek() -> T? {
        return self.top?.value
    }
    
    /// Appends an item to the head linked list.
    ///
    /// - parameter element: A value that gets appended  to the head of the linked list.
    func push(element: T) {
        
        let temp: ListNode<T> = ListNode<T>()
        
        if let topNode = self.top {
            temp.value = element
            temp.last  = topNode
            self.top   = temp
        } else {
            temp.value = element
            self.top   = temp
        }
    }
    
    /// Removes and item from head of the linked list.
    ///
    /// - returns: The value that is removed from head of the linked list, nil if the list is empty.
    func pop() -> T? {
        
        if let _ = self.top {
            var temp: ListNode<T>?
            temp = self.top
            self.top = self.top?.last
            return temp?.value
        }
        
        return nil
    }

    /// Generates a string that contains the linked list from head to tail.
    ///
    /// - returns: A string of the lists values.
    func displayString() -> String {
        
        var describingString = ""

        if let topNode = self.top {
            describingString += "\(topNode)"

            var temp = topNode
            while let last = temp.last {
                describingString += "\(last)"
                temp = last
            }
        }
        
        return describingString
    }
}
