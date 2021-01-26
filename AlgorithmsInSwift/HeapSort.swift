//
//  HeapSort.swift
//  DSA_Easy
//
//  Created by Hadi Kheyruri on 2020-11-20.
//  Copyright © 2020 SerenaVisions Technology Inc. All rights reserved.
//

import Foundation


extension Array where Element: Comparable {
    
    /// Sorts the array through using  a heap.
    ///
    /// - returns: An array containing the sorted elements from the original array.
    /// - complexity: O(n log n)
    func heapSort() -> [Element] {
        
        var sortedArray = [Element]()
        
        let copy = self.map { $0 }
        var heap = Heap(copy, heapType: .minHeap)
        
        for _ in 0..<self.count {
            if let item = heap.dequeue() {
                sortedArray.append(item)
            }
        }
        
        return sortedArray
    }
}

