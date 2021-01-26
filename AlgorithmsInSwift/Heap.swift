//
//  Heap.swift
//  DSA_Easy
//
//  Created by Hadi Kheyruri on 2020-11-19.
//  Copyright © 2020 SerenaVisions Technology Inc. All rights reserved.
//

import Foundation

enum HeapType {
    case minHeap
    case maxHeap
}

/// Heap is a almost fully complete binary tree with a heap condition. A heap  can be either
/// a min heap or a max heap. Every node in min heap is smaller than it's children and a respectively
/// every node in a max heap is larger than it's children. A heap is also known as Priority Queue.
///
/// The root of a Min Heap is always the smallest element in the heap thus time complexity of finding the
/// smallest/ largest element in min/ max heap is constant O(1)
struct Heap<Element> where Element: Comparable {
    
    fileprivate var heapType : HeapType = .minHeap
    fileprivate var elements : [Element] = []
    
    /// A Boolean value indicating whether the heap is empty.
    var isEmpty: Bool { return self.elements.isEmpty }
    
    /// The number of elements in the heap.
    var count: Int { return self.elements.count }
    
    /// Custom initializer for the heap.
    ///
    /// - parameter array: An array of uniform and comparable elements.
    /// - parameter heapType: Indicating type of the heap which is either .minHeap or .maxHeap.
    ///
    /// - complexity: O(n log n)
    init(_ array: [Element] = [], heapType: HeapType = .minHeap) {
        self.heapType = heapType
        self.elements = array
        
        for index in 0..<self.count { self.siftUp(from: index) }
    }
    
    /// Adds elements to the heap.
    ///
    /// - parameter element: The element to be added to the heap.
    /// - complexity: O(log n)
    mutating func enqueue(_ element: Element) {
        self.elements.append(element)
        self.siftUp(from: self.count - 1)
    }
    
    /// The root element of the heap, which depending on the type of the heap,
    /// it's either the smallest or largest element in the heap.
    ///
    /// - complexity: O(1)
    func peek() -> Element? {
        return self.elements.first
    }
    
    /// Removes and returns the top most element in the heap.
    ///
    /// - returns: The removed element.
    /// - complexity: O(log n)
    @discardableResult mutating func dequeue() -> Element? {
        guard !isEmpty else { return nil }
        if self.count == 1 { return self.elements.removeLast() }
        let out = self.elements[0]
        self.elements[0] = self.elements.removeLast()
        self.siftDown(from: 0)
        return out
    }
    
    /// A tree-like textual representation of the heap.
    func treeString() -> String { return diagram(index: 0) }
}


private extension Heap {
    
    mutating func siftUp(from index: Int) {
        var childIndex = index

        while hasParent(childIndex) && !hasCorrectPriority(parentIndex: childIndex.parent, childIndex: childIndex) {
            self.elements.swapAt(childIndex.parent, childIndex)
            childIndex = childIndex.parent
        }
    }
    
    mutating func siftDown(from index: Int) {
        
        var parent = index
        while hasLeftChild(parent) {

            var swapIndex = parent.leftChild
            if hasRightChild(parent) {
                
                if heapType == .minHeap && elements[parent.rightChild] < elements[parent.leftChild] {
                    swapIndex = parent.rightChild
                }
                else if heapType == .maxHeap &&  elements[parent.rightChild] > elements[parent.leftChild] {
                    swapIndex = parent.rightChild
                }
            }
            
            if hasCorrectPriority(parentIndex: parent, childIndex: swapIndex) {
                break
            } else {
                elements.swapAt(parent, swapIndex)
            }
            parent = swapIndex
        }
    }
    
    func hasCorrectPriority(parentIndex: Int, childIndex: Int) -> Bool {
        
        switch heapType {
        case .minHeap:
            return self.elements[parentIndex] <= self.elements[childIndex]
        case .maxHeap:
            return self.elements[parentIndex] >= self.elements[childIndex]
        }
    }
    
    func hasLeftChild(_ index: Int) -> Bool {
        return index.leftChild < self.count
    }
    
    func hasRightChild(_ index: Int) -> Bool {
        return index.rightChild < self.count
    }
    
    func hasParent(_ index: Int) -> Bool {
        return index.parent >= 0
    }
}

extension Heap: CustomStringConvertible {
    
    public var description: String { "\(elements)" }

    private func diagram(index: Int? = 0,
                 _ top: String = " ",
                 _ root: String = " ",
                 _ bottom: String = " ") -> String {
        guard let index = index else { return "" }
        guard index < self.count else { return "" }
        
        if !hasLeftChild(index) && !hasRightChild(index) {
            return root + " \(elements[index])\n"
        }
        
        var parentValueString: String!
        if root == " " {
            parentValueString = root + "\(elements[index])\n"
        } else {
            parentValueString = root + " \(elements[index])\n"
        }
        
        return  diagram(index: index.rightChild,
                        top + "   ",
                        top + "┌─",
                        top + "│  ") +
            parentValueString +
            diagram(index: index.leftChild,
                    bottom + "│  ",
                    bottom + "└─",
                    bottom + "   ")
    }
}


/// private will restrict access to other methods within the same type definition, so we use fileprivate to
/// limit access only to this file for our own Heap implementation.
fileprivate extension Int {
    
    var leftChild: Int {
      return (2 * self) + 1
    }
    
    var rightChild: Int {
      return (2 * self) + 2
    }
    
    var parent: Int {
      return (self - 1) / 2
    }
}
