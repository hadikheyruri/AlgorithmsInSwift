//
//  DSA_Array.swift
//  DSA_Easy
//
//  Created by Hadi Kheyruri on 2020-12-01.
//  Copyright © 2020 SerenaVisions Technology Inc. All rights reserved.
//

import Foundation

class DSA_Array {
    
    /// Given a list of integers, return the largest product that can be made by multiplying any three integers.
    /// You can assume the list has at least three integers.
    ///
    /// ```
    /// e.g. given [-10, -10, 5, 2], we should return 500, since that's -10 * -10 * 5.
    /// ```
    ///
    /// - parameter arr: An array of integers.
    /// - returns: A tuple of three integers that have the largest product.
    func largestProducts(arr: inout [Int]) -> (Int, Int, Int) {
        
        assert(arr.count >= 3, "The input array must be have at least three elements.")
        
        let sorted = arr.sorted()
        
        let min1 : Int = sorted[0]
        let min2 : Int = sorted[1]
        
        let max1 : Int = sorted[sorted.count - 1]
        let max2 : Int = sorted[sorted.count - 2]
        let max3 : Int = sorted[sorted.count - 3]
        
        // the algorithm should pick two negative numbers or none.
        if min1 * min2 > max2 * max3 {
            return (max1, min1, min2)
        }
        
        return (max1, max2, max3)
    }
    
    /// Find the largest absolute difference in a list of integers.
    ///
    /// - parameter arr: An array of integers.
    /// - returns: An integer, which is the largest absolute difference.
    func largestAbsoluteDifference(arr: inout [Int]) -> Int {
        
        var min : Int = Int.max
        var max : Int = Int.min
        
        for num in arr {
            
            if num < min {
                min = num
            }
            
            if num > max {
                max = num
            }
        }
        
        return abs(max - min)
    }
    
    /// Given an array of integers, return a new array such that each element at index i of the new array is the product of
    /// all the numbers in the original array except the one at i. You can't use division.
    ///
    /// ```
    /// e.g. given [3, 2, 1], the expected output is [2, 3, 6].
    /// e.g. given [1, 2, 3, 4, 5], the expected output is [120, 60, 40, 30, 24].
    /// ```
    ///
    /// - parameter arr: An array of integers.
    /// - returns: An array of integers.
    func cumulativeProducts(arr: [Int]) -> [Int] {
        
        var results: [Int] = Array(repeating: 0, count: arr.count)
        
        // Make use of left products:e.g. [1, 2, 6, 24, 120] & right products: e.g. [120 ,120, 60, 20, 5]
        var leftProds:  [Int] = Array(repeating: 1, count: arr.count)
        var rightProds: [Int] = Array(repeating: 1, count: arr.count)
        
        leftProds[0] = arr[0]
        for index in 1..<arr.count {
            leftProds[index] = leftProds[index - 1] * arr[index]
        }
        
        rightProds[arr.count - 1] = arr[arr.count - 1]
        for index in stride(from: arr.count - 2, to: 0, by: -1) {
            rightProds[index] = rightProds[index + 1] * arr[index]
        }
        
        results[0] = rightProds[1]
        results[results.count - 1] = leftProds[results.count - 2]
        for index in 1..<arr.count - 1 {
            results[index] = leftProds[index - 1] * rightProds[index + 1]
        }
        
        return results
    }
    
    /// Given an array of numbers, find the length of the longest increasing subsequence in the array. The
    /// subsequence does not necessarily have to be contiguous.
    ///
    /// ```
    /// e.g. given [0, 8, 4, 12, 2, 10, 6, 14, 1, 9, 5, 13, 3, 11, 7, 15],
    /// the longest increasing subsequence has length 6: it is 0, 2, 6, 9, 11, 15.
    ///
    /// e.g. given [10, 22, 9, 33, 21, 50, 41, 60, 80],
    /// the longest increasing subsequence is: 10, 22, 33, 41, 60, 80.
    /// ```
    ///
    /// - parameter arr: An array of integers.
    /// - returns: A subsequence array of integers.
    func longestIncreasingSubsequence(arr: [Int]) -> [Int] {
        
        // We maintain a list of active subsequences. We keep the list in
        // an increasing order with respect to the size of the subsequences.
        // This method results in one and only one active subsequence for a specific subsequent length.
        //
        // Three cases arise when reading new elements:
        //
        // case 1 (Insert):
        //         IF the element is less than the smallest element in the active subsequences:
        //         -> we insert the element as a subsequence of one in the head of active subsequences.
        // case 2 (Clone & Extend):
        //         IF the element is largest among all top elememts of subsequences:
        //         -> we clone the largest subsequence and append the element to it.
        // case 3 (Replace): ELSE
        //         -> we will find a subsequence with the largest top that is smaller than the element.
        //         -> we clone this sebsequence and append the element to it.
        //         -> we discard all sebsequences with the same length as the new subsequence.
        
        var active : [[Int]] = []
        
        for element in arr {
            
            if active.isEmpty {
                active.append([element])
                continue;
            }
            
            // case 1: for the smallest item in the active subsequences we don't need to iterate.
            // The first subsequence will always have only one item, which would be the smallest item.
            let smallestItem = active[0][0]
            if element < smallestItem {
                active.insert([element], at: 0)
                continue;
            }
            
            // case 2: for largest we don't need to iterate over all active subsequences.
            // The top of the last subsequence is the largest item among all items in the active subsequences.
            if let lastItem = active[active.count - 1].last, element > lastItem {
                let subsequence = active[active.count - 1].map { $0 }
                active.append(subsequence + [element])
                continue;
            }
            
            // case 3: find a subsequence with the largest top that is smaller than the element.
            // The construction of the active subsequences yields a sorted array.
            for index in 1..<active.count {
                if let lastItem = active[index].last, element < lastItem {
                    let subsequence = active[index - 1].map { $0 }
                    active.insert(subsequence + [element], at: index)
                    active.remove(at: index + 1)
                    break;
                }
            }
        }
        
        return active[active.count - 1]
    }
    
    /// Find the sub array with maximum contiguous sum.
    ///
    ///```
    ///e.g. given [-2, -3, 4, -1, -2, 1, 5, -3] return [4, -1, -2, 1, 5]
    ///e.g. given [-2, 1, -3, 4, -1, 2, 1, -5, 4] return [4, -1, 2, 1]
    ///```
    /// - parameter array: Takes an array of integers.
    /// - returns: A sub array with max contiguous sum.
    func maxContiguousSumSubarray(_ array: [Int]) -> [Int] {
        
        guard !array.isEmpty else { return [] }
        
        var sum: Int = 0
        var max: Int = Int.min
        var startIndex: Int = 0
        var endIndex: Int = 0
        var startCandidateIndex: Int = 0
        
        for i in 0..<array.count {
            
            // take  max(sum + new number, new number)
            // should we start a new potential subarray? (does previous sum hurt the new number?)
            if array[i] > sum + array[i]  {
                sum = array[i]
                startCandidateIndex = i
            } else { // extend the previous subarray.
                sum = sum + array[i]
            }

            if sum > max {
                max = sum  // 1. update max.
                endIndex = i // 2. extend the ending of old subarray.
                startIndex = startCandidateIndex // 3. commit the potential subarray.
                // startIndex only really gets updated when we start a new subarray, in
                // this case startIndex and endIndex will have the same value; otherwise
                // the assignment to startIndex will be idempotent.
            }
        }
                
        return Array(array[startIndex...endIndex])
    }
    
    /// Given an array of integers and a number k, compute the maximum values of each subarray of length k.
    ///
    ///```
    /// e.g. given [10, 5, 2, 7, 8, 7], you should return [10, 7, 8, 8].
    ///
    ///    10 = max(10, 5, 2)
    ///    7 = max(5, 2, 7)
    ///    8 = max(2, 7, 8)
    ///    8 = max(7, 8, 7)
    ///```
    ///
    /// - parameter array: An array of integers.
    /// - parameter k: An integer indicating length of the window.
    /// - returns: An array of max values for each slice of array of length k.
    func slidingWindowMaxArray(_ array: [Int], k: Int) -> [Int] {
        
        guard !array.isEmpty else { return [] }
        
        if k > array.count {
            if let max = array.max() {
                return [max]
            }
        }
        
        var res: [Int] = []
        
        for i in 0...array.count - k {
            if let max = array[i...k + i - 1].max() {
                res.append(max)
            }
        }
        
        return res
    }
    
    /// Generates prime numbers using the Sieve of Eratosthenes.
    ///
    /// - parameter n: An integer indicating the cielling for the generating numbers.
    /// - returns: An array of prime integers.
    /// - complexity: O(n)
    func sieveOfEratosthenes(n: Int) -> [Int] {
        
        var isPrime: [Bool] = Array(repeating: true, count: n + 1)
        var primes: [Int] = []
        var smallestPrimeFactor: [Int] = Array(repeating: 0, count: n + 1)
        
        isPrime[0] = false
        isPrime[1] = false
        
        var counter = 1
        for index in 0..<n {
            
            if isPrime[index] == true {
                primes.append(index)
                smallestPrimeFactor[index] = index
            }
            
            var j = 0
            while j < primes.count && primes[j] <= smallestPrimeFactor[index] && index * primes[j] < n {
                
                counter += 1
                isPrime[index * primes[j]] = false
                smallestPrimeFactor[index * primes[j]] = primes[j]
                
                j += 1
            }
        }
        
        return primes
    }
    
    /// You are given an array of non-negative integers that represents a two-dimensional elevation map where each element is unit-width wall and the integer is the
    /// height. Suppose it will rain and all spots between two walls get filled up. Compute how many units of water remain trapped on the map in O(N) time and O(1) space.
    ///```
    /// e.g. given the input [2, 1, 2], we can hold 1 unit of water in the middle.
    /// e.g. given the input [3, 0, 1, 3, 0, 5], we can hold 3 units in the first index, 2 in the second, and 3 in the fourth index
    /// (we cannot hold 5 since it would run off to the left), so we can trap 8 units of water.
    ///```
    /// - parameter arr: An array of integers.
    /// - returns: An integer, representing the units of trapped water.
    /// - complexity: O(n) time complexity, where n is length of the array and O(1) space complexity.
    func trappedWater(arr: [Int]) -> Int {
        
        if arr.isEmpty { return 0 }
        var units: Int = 0
        
        var prevMax: Int = arr[0]   // setting first element to be prevMax
        var prevMaxIndex: Int = 0   // storing the first index for prevMax
        
        var temp: Int = 0           // store the water units until a larger wall is found, otherwise remove that amount from units.
        for i in 1..<arr.count {
            if arr[i] > prevMax {   // if the current wall is larger set the current wall to be prevMax,
                prevMax = arr[i]
                prevMaxIndex = i
                temp = 0
            } else {                // otherwise there is water on top of current wall, so add that to units.
                units += prevMax - arr[i]
                temp += prevMax - arr[i]  // if we don't find larger wall by end of loop, we subtract this ammount from units.
            }
        }
        
        if prevMaxIndex < arr.count - 1 {
            
            units -= temp           // we remove the gathered temp from units from the prevMaxIndex till end because we couldn't find
            prevMax = arr[arr.count - 1] // a wall tall enough to be capable of holding that amount.
            
            (prevMaxIndex...arr.count-1).reversed().forEach { index in
                if arr[index] > prevMax {  // now we have to loop backwards till prevMaxIndex from end of the array,
                    prevMax = arr[index]
                } else {
                    units += prevMax - arr[index] // to add any amount of water that can be gathered between prevMaxIndex and array size.
                }
            }
        }
        
        return units
    }
    
    /// Finds the longest palindromic substring using the Manacher's algorithm.
    ///
    /// - parameter s: A string as input.
    /// - returns: A string, which is the longest palindromic substring of the input string.
    /// - complexity: O(n), where n is the lenght of the string.
    func manacherPalindromicSubstring(_ s: String) -> String {
        
        let modified = String(s.enumerated().map { $0 % 1 == 0 ? ["#", $1] : [$1]}.joined())
        let chars: [Character] = Array(modified + "#")
        let len: Int = chars.count
        
        var maxLength: Int = 0
        var maxLenCenter: Int = 0
        
        var currentCenter: Int = 1
        var rightBoundary: Int = 2

        var LPS: [Int] = Array(repeating: 0, count: chars.count)
        LPS[1] = 1
        
        for i in 2..<len {
            
            let mirror: Int = 2 * currentCenter - i
            if rightBoundary > i {
                LPS[i] = min(rightBoundary - i, LPS[mirror])
            }
            
            // Find longest polindrome at center i. Big part of this manacher guys trick over the brute force method:
            var head: Int = i - 1 + LPS[i]
            var tail: Int = i + 1 + LPS[i]
            while head >= 0 && tail < len && chars[head] == chars[tail] {
                LPS[i] += 1
                head -= 1 // expand window
                tail += 1
            }
            
            // check if the expanded palindrome at i is expanding beyond the right boundary of
            // current longest palindrome at center c if it is, the new center is i.
            if rightBoundary < i + LPS[i]  {
                rightBoundary = i + LPS[i]
                currentCenter = i
            }
            
            if maxLength < LPS[i] {
                maxLength = LPS[i]
                maxLenCenter = i
            }
        }
 
        if maxLength == 1 { return "" }
        
        let start: Int = maxLenCenter - maxLength
        let end:   Int = maxLenCenter + maxLength
        let res = chars[start...end].filter() { $0 != "#" }
        
        return String(res)
    }
    
    /// Given a string and a set of delimiters, reverse the words in the string while maintaining the relative order of the delimiters.
    /// ```
    /// e.g. given "hello/world:here", return "here/world:hello"
    /// ```
    /// - parameter sentence: A string containing words and delimiters.
    /// - returns: A string with order of the words reversed.
    /// - complexity: O(n), where n is the length of the string.
    func reverse(sentence: String) -> String {
        
        var str: [String] = []
        var specials: [String] = []
        
        let specialChars: Set = [":", "/", "!", " "]
        let chars: [Character] = Array(sentence)
        
        var rev: String = ""
        var head: Int = 0
        var tail: Int = 1

        while head < chars.count && tail < chars.count {
            
            if specialChars.contains(String(chars[tail])) {
                
                if specialChars.contains(String(chars[tail - 1])) {
                    let q = specials.removeLast() + String(chars[tail])
                    specials.append(q)
                } else {
                    let component: String = String(chars[head...(tail - 1)])
                    str.append(component)
                    specials.append(String(chars[tail]))
                }
                head = tail + 1

            } else if tail == chars.count - 1 {
                
                let component: String = String(chars[head...tail])
                str.append(component)
            }
            
            tail += 1
        }
        
        var index = 0
        for item in str.reversed() {
            
            rev.append(item)
            if index < specials.count {
                rev.append(specials[index])
                index += 1
            }
        }
        
        while index < specials.count {
            rev.append(specials[index])
            index += 1
        }
        
        return rev
    }
    
    
    /// Finds the smallest subarray containing all elements of the array.
    /// ```
    /// e.g. given [7, 5, 2, 7, 2, 7, 4, 7], it will return [5, 2, 7, 2, 7, 4]
    /// ```
    /// - parameter arr: An array of integers.
    /// - returns: The smallest subarray of the original array containing all of its elements.
    func smallestSubarrayContainingAllElements(_ arr: [Int]) -> [Int] {
        
        var lengths: [Int] = Array(repeating: arr.count, count: arr.count)
        let elements: Set = Set(arr)
        for head in 0..<arr.count {

            var visited: Set = Set<Int>()
            for tail in head..<arr.count {

                visited.insert(arr[tail])
                if visited == elements {
                    lengths[head] = tail - head
                    break
                }
            }
        }

        var minLength: Int = arr.count
        var head: Int = 0
        for (index, item) in lengths.enumerated() {
            if item < minLength {
                head = index
                minLength = item
            }
        }
        let tail: Int = head + minLength
                
        return Array(arr[head...tail])
    }

}
