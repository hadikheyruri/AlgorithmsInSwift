//
//  IntervalTreeNode.swift
//  IntervalTree
//
//  Created by Hadi Kheyruri on 2020-09-29.
//  Copyright © 2020 SerenaVisions Technology Inc. All rights reserved.
//

import Foundation

struct Interval {
    var lo: Int
    var hi: Int
    var label: String  // TODO: to resolve identical bounds, check the label.
}

protocol TreeOperations {
    
    func contains(interval: Interval) -> Bool
    func insert(interval: Interval)
    func delete(interval: Interval) -> IntervalTreeNode?
}

/// An Interval Tree is a special case of Binary Search Tree where the values stored
/// in the nodes are intervals.
/// This class implements Interval Tree using a generic Binary Search Tree and operations
/// have the Big O of O(lg n) on average and O(n) in worst case.
/// An improved self-balancing Binary Search Tree such as an AVL-Tree could yield O(lg n)
/// for worst case for operations.
class IntervalTreeNode {
    
    var left     : IntervalTreeNode?
    var right    : IntervalTreeNode?
    var interval : Interval?
    
    /// Creates an empty node with no specific interval.
    init() {
        // create an empty node.
    }
    
    /// Creates a new  node with a specified interval.
    ///
    /// - parameter key: The interval to be inserted into the node.
    init(interval: Interval) {
        self.interval = interval
    }
}

extension IntervalTreeNode {
    
    func count() -> Int {
        return (self.left?.count() ?? 0) + 1 + (right?.count() ?? 0)
    }
}

extension IntervalTreeNode: CustomStringConvertible {
    
    var description: String {
        
        guard let interval = self.interval else { return "" }
        let intervalString : String = "(\(interval.lo), \(interval.hi))"
            
        var descript = "[Interval: \(intervalString)"
        
        if let left = self.left {
            descript += ", left: \(left.description)"
        }
        
        if let right = self.right {
            descript += ", right: \(right.description)"
        }
                
        return descript
    }
}

extension IntervalTreeNode: TreeOperations {
    
    /// Queries existence of a specific node with specified interval within the existining subtree.
    ///
    /// - parameter key: The value to be queried.
    func contains(interval: Interval) -> Bool {
        
        guard let loBound = self.interval?.lo, let hiBound = self.interval?.hi else { return false }
        
        if interval.lo != loBound && interval.hi != hiBound  {
            return false
        }
        
        if interval.lo < loBound {
            if let left = self.left {
                return left.contains(interval: interval)
            } else {
                return false
            }
        } else {
            if let right = self.right {
                return right.contains(interval: interval)
            } else {
                return false
            }
        }
    }
    
    /// Inserts a new  node with a specified interval to the exisiting subtree.
    ///
    /// - parameter key: The value to be inserted.
    func insert(interval: Interval) {
        
        guard let loBound = self.interval?.lo else {
            self.interval = interval
            return
        }

        if interval.lo < loBound {
            
            if let left = self.left {
                left.insert(interval: interval)
            } else {
                self.left = IntervalTreeNode(interval: interval)
            }
        }
            
        else {
            
            if let right = self.right {
                right.insert(interval: interval)
            } else {
                self.right = IntervalTreeNode(interval: interval)
            }
        }
    }
    
    /// Finds and deletes a specific node with specified interval within the existining subtree.
    ///
    /// - parameter key: The interval to be deleted.
    /// - returns: The deleted  node with the specified interval.
    func delete(interval: Interval) -> IntervalTreeNode? {
        // To delete node: remove reference of node from parent: detach node from the tree & reclaim memory.
        // means: first find the node & then find the replacement for it.
        guard let loBound = self.interval?.lo, let hiBound = self.interval?.hi else { return nil }

        var intervalTree : IntervalTreeNode?
        intervalTree = self
        if interval.lo < loBound {
            intervalTree?.left = self.left?.delete(interval: interval)
        }
            
        else if interval.lo > loBound {
            intervalTree?.right = self.right?.delete(interval: interval)
        }
            
        else if interval.lo == loBound && interval.hi == hiBound {
            // we face three cases:
            
            // 1. node has no child: straight forward, return nil.
            if self.left == nil && self.right == nil {
                intervalTree = nil
            }
                
            // 2. node has only one child: link parent's reference to the node's child.
            else if self.left == nil {
                intervalTree = self.right
            }
                
            else if self.right == nil {
                intervalTree = self.left
            }
                
            // 3. node has both childs: EITHER
            //    i.  replace with min of the right subtree & remove the duplicate. OR
            //    ii. replace with max of the left subtree & remove the duplicate.
            else {
                if let interv = self.right?.minNode() {
                    intervalTree?.interval = interv
                    intervalTree?.right = self.right?.delete(interval: interv)
                }
            }
        }
        
        return intervalTree
    }
    
    /// Finds the left most node in the exisiting subtree.
    ///
    /// - returns: The interval in the left most node.
    private func minNode() -> Interval? {
        var node = self
        while let next = node.left {
            node = next
        }
        return node.interval
    }
    
    /// Finds the right most node in the exisiting subtree.
    ///
    /// - returns: The interval in the  right most node.
    private func maxNode() -> Interval? {
        var node = self
        while let next = node.right {
            node = next
        }
        return node.interval
    }
}

extension IntervalTreeNode {
    
    func overlapSearch(interval: Interval) -> Interval? {
       
        guard let rootInterv = self.interval else { return nil }
        
        if self.overlap(interval1: rootInterv, interval2: interval) {
            return rootInterv
        }
        
        if interval.lo < rootInterv.lo {
            return self.left?.overlapSearch(interval: interval)
        } else {
            return self.right?.overlapSearch(interval: interval)
        }
    }
    
    private func overlap(interval1: Interval, interval2: Interval) -> Bool {
        
        if interval1.lo > interval2.hi || interval1.hi < interval2.lo {
            return false
        }
            
        return true
    }
}

/*


 //
     Given an Array of TimeIntervals (start, end) find the minimum number of rooms required.
     Example = [(30, 75), (0, 50), (60, 150)] should return 2.
 //

 // The question is how many of these have conflicts.
 // We should compare each period with the others in the list to see if we have a conflict.

 -------------------------------------------------------------------------- A1: using an Array


 struct SessionPeriod {
   var startTime : TimeInterval
   var endTime : TimeInterval
 }

 let periods:[SessionPeriod] = [SessionPeriod(30, 75), SessionPeriod(0, 50), SessionPeriod(60, 150)]

 void main() {

   var roomCounter : Int = 1

   for i in 0 ... periods.count()-2 {

     let period1 = periods[index]

     for j in i+1 ...  periods.count()-1 {

       let period2 = periods[j]

       if self.conflict(period1, period2) {
         roomCounter += 1
       }
     }
   }

   print("required number of rooms is: \(roomCounter)")
 }

 func conflict(session1: SessionPeriod, session2: SessionPeriod) -> Bool {

   if session1.startTime > session2.endTime || session1.endTime < session2.startTime {
       return false
   }


   return true
 }


 Big_O Analysis:

 Total number of comparisons: (n-1) + (n-2) + (n-3) + ... + 1
 complexity O(n^2)


 -------------------------------------------------------------------------- A2: using an Interval Tree (assumption tree built using AVL invariant i.e. tree is self-balancing).

 // How to build a Tree from periods?




 Big_O Analysis:

 Building the tree:  O(n * log n)
 Searching the tree: O(k * log n) where k = 1
 Conflicting rooms : k = n. O(n * log n)

 */
