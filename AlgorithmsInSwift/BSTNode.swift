//
//  BSTNode.swift
//  BST
//
//  Created by Hadi Kheyruri on 2020-09-22.
//  Copyright © 2020 SerenaVisions Technology Inc. All rights reserved.
//

import Foundation

/// A Binary Search Tree is binary tree where for any given node value all the left children are
/// smaller and all the right children are bigger.
/// BSTNode defines a node template that could used as root of a Binary Search Tree.
/// Big O complexity of operations on average are O(lg n) and worst case of O(n).
class BSTNode<T: Comparable> {
    
    var left : BSTNode?
    var right: BSTNode?
    var key  : T?
    
    var traverseString : String = ""
        
    /// Creates a new empty BST node with no value.
    init () {
    }
    
    /// Creates a new BST node with a specified value.
    ///
    /// - parameter key: The value to be inserted into the node.
    init(key: T) {
        self.key = key
    }
    
    /// Inserts a new  BST node with a specified value to exisiting subtree.
    ///
    /// - parameter key: The value to be inserted.
    func insert(key: T) {
        
        guard let nodeKey = self.key else {
            self.key = key
            return
        }
        
        if key < nodeKey {
          
            if let left = self.left {
                left.insert(key: key)
            } else {
                self.left = BSTNode(key: key)
            }
        }
        
        else {
            
            if let right = self.right {
                right.insert(key: key)
            } else {
                self.right = BSTNode(key: key)
            }
        }
    }
    
    /// Queries existence of a specific node with  specified value within the existining subtree.
    ///
    /// - parameter key: The value to be queried.
    func contains(key: T) -> Bool {
        
        if let nodeKey = self.key {

            if nodeKey == key { return true }
            else {
                
                if let left = self.left, key < nodeKey { return left.contains(key: key) }
                if let right = self.right, key > nodeKey{ return right.contains(key: key) }
            }
            
        } else { return false }
        
        return false
    }
    
    /// Finds and deletes a specific node with specified value within the existining subtree.
    ///
    /// - parameter key: The value to be deleted.
    /// - returns: The deleted BST node with the specified value.
    @discardableResult func delete(key: T) -> BSTNode? {

        // To delete node: remove reference of node from parent: detach node from the tree & reclaim memory.
        // means: first find the node & then find the replacement for it.
        guard let nodeKey = self.key else { return nil }
        
        var bst : BSTNode?
        bst = self
        if key < nodeKey {
            bst?.left = self.left?.delete(key: key)
        }
        
        else if key > nodeKey {
            bst?.right = self.right?.delete(key: key)
        }
            
        else if key == nodeKey {
            // we face three cases:
            
            // 1. node has no child: straight forward, return nil.
            if self.left == nil && self.right == nil {
                bst = nil
            }
             
            // 2. node has only one child: link parent's reference to the node's child.
            else if self.left == nil {
                bst = self.right
            }
            
            else if self.right == nil {
                bst = self.left
            }
            
            // 3. node has both childs: EITHER
            //    i.  replace with min of the right subtree & remove the duplicate. OR
            //    ii. replace with max of the left subtree & remove the duplicate.
            else {
                let minRight = self.right?.minNode()
                bst?.key = minRight
                bst?.right = self.right?.delete(key: minRight!)
            }
        }
        
        return bst
    }
    
    /// Finds the smallest value in the exisiting subtree.
    ///
    /// - returns: The value of the left most node.
    private func minNode() -> T {
        var node = self
        while let next = node.left {
            node = next
        }
        return node.key!
    }
    
    /// Finds the largest value in the exisiting subtree.
    ///
    /// - returns: The value of the right most node.
    private func maxNode() -> T {
        var node = self
        while let next = node.right {
            node = next
        }
        return node.key!
    }
    
    /// Counts number of nodes in the exitining subtree.
    ///
    /// - returns: The number of nodes.
    func count() -> Int {
        return (self.left?.count() ?? 0) + 1 + (right?.count() ?? 0)
    }
    
    /// Traverses the subtree in pre-order.
    /// and stores the result in traverseString recursively in a tree-like fashion,
    /// prints the result in console.
    func traversePreOrder() {
        print("-------------------------------")
        guard let node = self.key else { return }
        print("\(node)")
        self.traverseString = ""
        self.traverseString += ("\(node)\n")
        
        let pad = ""
        let rightPointer = "└──"
        let leftPointer = self.right != nil ? "├──" : "└──"
        let leftStr = self.left?.traverse(padding: pad, pointer: leftPointer, hasRightSibling: self.right != nil)
        let rightStr = self.right?.traverse(padding: pad, pointer: rightPointer, hasRightSibling: false)
        
        if let str = leftStr {
            self.traverseString += str
        }
        
        if let str = rightStr {
            self.traverseString += str
        }
    }
    
    /// Auxiliary method for traversePreOrder.
    /// Traverses the subtree in pre-order.
    /// and stores the result in traverseString recursively in a tree-like fashion,
    /// prints the result in console.
    private func traverse(padding: String, pointer: String, hasRightSibling: Bool) -> String {
        guard let node = self.key else { return "" }
        
        let string = padding + pointer + "\(node)"
        print(string)
        
        var pad = ""
        if hasRightSibling {
            pad = padding + "│   "
        } else {
            pad = padding + "    "
        }
        
        let rightPointer = "└──"
        let leftPointer = self.right != nil ? "├──" : "└──"
        let leftStr : String = self.left?.traverse(padding: pad, pointer: leftPointer, hasRightSibling: self.right != nil) ?? ""
        let rightStr : String = self.right?.traverse(padding: pad, pointer: rightPointer, hasRightSibling: false) ?? ""
        
        return string + "\n" + leftStr + rightStr
    }
    
    /// Traverses  and prints the subtree in pre-order recursively.
    private func traverseNodes(padding: String, pointer: String, hasRightSibling: Bool) {
        guard let node = self.key else { return }
        
        let string = padding + pointer + "\(node)"
        print(string)
        
        var pad = ""
        if hasRightSibling {
            pad = padding + " │  "
        } else {
            pad = padding + "    "
        }
        
        let rightPointer = "└──"
        let leftPointer = self.right != nil ? "├──" : "└──"
        self.left?.traverseNodes(padding: pad, pointer: leftPointer, hasRightSibling: self.right != nil)
        self.right?.traverseNodes(padding: pad, pointer: rightPointer, hasRightSibling: false)
    }
}


extension BSTNode: CustomStringConvertible {
    
    var description: String {
        
        guard let nodeKey = self.key else { return "" }
        
        var descript = "[key: \(nodeKey)"
        
        if let left = self.left {
            descript += ", left: \(left.description)"
        }
        
        if let right = self.right {
            descript += ", right: \(right.description)"
        }
                
        return descript
    }
}

/*
 
 AVL Tree
 ========
 
 Height:
 H(0) = -1
 H(Single Node) = 0
 H(n) = max[H(Left_subtree), H(Right_subtree)] + 1
 
 Balance:
 B(n) = H(Left_subtree) - H(Right_subtree)  ----> Left_Heavy:+ , Right_Heavy:-
 AVLTree = absolute[B(n)] <= 1
 
 */
