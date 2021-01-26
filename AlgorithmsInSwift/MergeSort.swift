//
//  MergeSort.swift
//  MergeSort
//
//  Created by Hadi Kheyruri on 2020-10-23.
//  Copyright © 2020 SerenaVisions Technology Inc. All rights reserved.
//

import Foundation

/// MergeSort splits the array into left and right sub-arrays recursively, and at the
/// single element level in left and right sub-arrays, merges them in the right order
/// recursively up to the level of first split.
///
/// Big O complexity of MergeSort for Best, Average and Worst case is O(n * lg n).
class MergeSort<T : Comparable> {
    
    private var elements: [T] = []
    
    /// Initializer that takes an array of elements, which are usually unsorted.
    ///
    /// - parameter elements: An array of comparable elements.
    init(elements: [T]) {
        self.elements = elements
    }
    
    /// The interface method for sorting the elements.
    ///
    /// - returns: A sorted array of elements.
    func sort() -> [T] {
        self.split(leftIndex: 0, rightIndex: self.elements.count - 1)
        return self.elements
    }
    
    private func split(leftIndex: Int, rightIndex: Int) {
        
        if leftIndex >= rightIndex { return }
        
        /// Find the middle point.
        let middle : Int = (leftIndex + rightIndex) / 2
        
        /// Split into two halves.
        self.split(leftIndex: leftIndex, rightIndex: middle)
        self.split(leftIndex: middle + 1, rightIndex: rightIndex)
        
        /// Merge the two halves.
        self.merge(leftIndex: leftIndex, middleIndex: middle, rightIndex: rightIndex)
    }
    
    private func merge(leftIndex: Int, middleIndex: Int, rightIndex: Int) {
    
        /// Create temporary arrays.
        let leftArray  = Array(self.elements[leftIndex...middleIndex])
        let rightArray = Array(self.elements[(middleIndex + 1)...rightIndex])

        var i : Int = 0 /// Initial index for left sub-array.
        var j : Int = 0 /// Initial index for the right sub-array.
        var k : Int = leftIndex /// Initial index of merged sub-array.
        
        while i < leftArray.count && j < rightArray.count {
            if leftArray[i] <= rightArray[j] {
                self.elements[k] = leftArray[i]
                i += 1
            } else {
                self.elements[k] = rightArray[j]
                j += 1
            }
            k += 1
        }
        
        /// Copy remaining elements of left array if there are any.
        while i < leftArray.count {
            self.elements[k] = leftArray[i]
            i += 1
            k += 1
        }
        
        /// Copy remaining elements of right array if there are any.
        while j < rightArray.count {
            self.elements[k] = rightArray[j]
            j += 1
            k += 1
        }
    }
}

extension Array where Element: Comparable {
    
    func mergeSort() -> [Element] {
        
        let merge = MergeSort(elements: self)
        return merge.sort()
    }
}
