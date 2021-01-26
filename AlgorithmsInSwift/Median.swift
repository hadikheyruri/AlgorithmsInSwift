//
//  Median.swift
//  DSA_Easy
//
//  Created by Hadi Kheyruri on 2020-11-20.
//  Copyright © 2020 SerenaVisions Technology Inc. All rights reserved.
//

import Foundation


extension Array where Element: FloatingPoint {
    
    func median() -> Element? {
        
        let list : [Element] = self.map { $0 }
        
        var minHeap = Heap<Element>(heapType: .minHeap)
        var maxHeap = Heap<Element>(heapType: .maxHeap)
        
        func median_lookup() -> Element? {
            
            if minHeap.isEmpty && maxHeap.isEmpty { return nil }
            if minHeap.isEmpty { return maxHeap.peek() }
            if maxHeap.isEmpty { return minHeap.peek() }
            
            guard let minPeek = minHeap.peek(), let maxPeek = maxHeap.peek() else { return nil }
            
            if minHeap.count > maxHeap.count { return minPeek }
            else if maxHeap.count > minHeap.count { return maxPeek }
                        
            return (minPeek + maxPeek) / (2.0 as! Element) /// return the average of two middle elements if heaps are even.
        }
        
        
        for element in list {
            
            if minHeap.isEmpty && maxHeap.isEmpty {
                minHeap.enqueue(element)
                continue
            }
            
            guard let median = median_lookup() else { continue }
            
            if element > median { minHeap.enqueue(element)
            } else { maxHeap.enqueue(element) }
            
            /// balance the number of elements in the  minHeap and maxHeap.
            if minHeap.count > (maxHeap.count + 1) {
                if let temp = minHeap.dequeue() { maxHeap.enqueue(temp) }
            } else if maxHeap.count > (minHeap.count + 1) {
                if let temp = maxHeap.dequeue() { minHeap.enqueue(temp) }
            }
        }
        
        return median_lookup()
    }
    

}
