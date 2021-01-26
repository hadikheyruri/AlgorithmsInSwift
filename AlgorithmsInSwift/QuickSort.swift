//
//  QuickSort.swift
//  QuickSort
//
//  Created by Hadi Kheyruri on 2020-10-21.
//  Copyright © 2020 SerenaVisions Technology Inc. All rights reserved.
//

import Foundation

/// QuickSort is a recursive algorithm that uses a pivot.
/// It picks a pivot repeatedly from one of the elements in the array and sorts
/// sub-arrays according to the pivot's index and value. This implementation
/// allows repeat elements.
/// Big O complexity of quick sort in average and best cases is O(n * lg n),
/// and in worst is O(n ^ 2).
class QuickSort<T: Comparable> {
    
    private var elements: [T] = []
    
    /// The convenience initializer that takes the unsorted array as input.
    ///
    /// - parameter elements: The unsorted array.
    init(elements: [T]) {
        self.elements = elements
    }
    
    /// This method sorts the input array using the quick sort algorithm.
    ///
    /// - returns: A sorted array.
    func sort() -> [T] {
        self.quickSort(low: 0, high: self.elements.count - 1)
        return self.elements
    }
    
    /// The recursive quick sort algorithm doing the actual sorting.
    ///
    /// - parameter low: Starting index of sub-array to sort.
    /// - parameter high: Ending index of the sub-array to sort.
    private func quickSort(low: Int, high: Int) {
        
        if low >= high { return }
        
        let pivotIndex = self.partition(low: low, high: high)
        
        /// Recursively sort elements before partition and after partition
        self.quickSort(low: low, high: pivotIndex - 1)
        self.quickSort(low: pivotIndex, high: high)
    }
    
    /// This function takes last element as pivot, places the pivot element at its correct
    /// position in sorted array, and places all smaller (smaller than pivot) to left of pivot
    /// and all greater elements to right of pivot.
    ///
    /// - parameter low: Starting index of the sub-array.
    /// - parameter high: Ending index of the sub-array.
    ///
    /// - returns: The new pivot index.
    private func partition(low: Int, high: Int) -> Int {
        
        let pivotValue: T = self.elements[high]
        var i = low - 1   /// index of smaller element.
        
        for j in low..<high {
            
            if self.elements[j] <= pivotValue { /// current element is less than the pivot.
                i += 1
                let temp = self.elements[i]
                self.elements[i] = self.elements[j]
                self.elements[j] = temp
            }
        }
        
        /// swap arr[i+1] and arr[high] (or pivot)
        let temp: T = self.elements[i + 1]
        self.elements[i + 1] = self.elements[high]
        self.elements[high]  = temp
        
        return i + 1
    }
}

extension Array where Element: Comparable {
 
    func quickSort() -> [Element] {
        
        let quick = QuickSort(elements: self)
        return quick.sort()
    }
}
