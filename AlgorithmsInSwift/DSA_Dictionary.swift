//
//  DSA_Dictionary.swift
//  DSA_Easy
//
//  Created by Hadi Kheyruri on 2020-12-01.
//  Copyright © 2020 SerenaVisions Technology Inc. All rights reserved.
//

import Foundation

class DSA_Dictionary {
    
    /// Given a list of numbers and a number k, return whether any two numbers from the list add up to k.
    /// Do it in one pass.
    ///
    /// ```
    /// e.g. given [10, 15, 3, 7] and k of 17, return true since 10 + 7 is 17.
    /// ```
    ///
    /// - parameter list: An array of integers.
    /// - parameter k: The number which sum of two elements from list must add up to.
    /// - returns: A boolean whether the method could find two items from the list that would add up to k.
    func sumOfTwoNumbersInList(list: [Int], k: Int) -> Bool {
        
        var searchCandidates: Set = Set<Int>()
        
        for number in list {
            
            if searchCandidates.contains(number) {
                return true
            }
            
            if number <= k {
                searchCandidates.insert(k - number)
            }
        }
        
        return false
    }
    
    /// Given a query string 's'  and  a set of all possible query strings (i.e. a vocabulary of words), return
    /// all strings in the set that have 's' as a prefix. Preprocess the vocabulary for faster lookup.
    ///
    ///``` eg. given the query string 'de' and set of strings ["dog", "deer", "deal"]
    /// you should return ["deer", "deal"].
    ///```
    ///
    /// - parameters: A string that is a frist few letters (one or more) of a word.
    /// - parameters: A set of all possible words termed as vocabulary.
    /// - returns: An array of suggestions.
    func autoComlpete(prefix: String, vocabulary: [String]) -> [String] {
        
        var dict: [String:[Int]] = [:]
        
        for (index, voc) in vocabulary.enumerated() {
            var key = ""
            for char in Array(voc) {
                key += String(char)
                
                if let indices = dict[key] {
                    dict[key] = indices + [index]
                } else {
                    dict[key] = [index]
                }
            }
        }
        
        guard let keys = dict[prefix] else { return [""] }
        var result: [String] = []
        
        for key in keys {
            result += [vocabulary[key]]
        }
        
        return result
    }
    
    /// Finds shortest substring containing a set of characters in linear time..
    ///
    ///```
    /// e.g. given the string "figehaeci" and set of characters "aei", you should return "aeci"
    /// e.g. given the string "adobecodebanc" and set of characters "abc", you should return "banc"
    ///```
    ///
    /// - parameter str: A string, which will be queried for shortest substring.
    /// - parameter chars: A string of characters, which should be present in the shortest substring.
    /// - returns: A string, that is the shortest substring of the original string containg all characters from second string.
    /// - complexity: O(n), where n is the length of the string.
    func shortestSubstring(_ s: String, containing chars: String) -> String {
        
        let match: [Character] = Array(chars)
        let str: [Character] = Array(s)
        var hashMatch: [Character:Int] = [:]
        var hashString: [Character:Int] = [:]
        
        for char in str { hashString[char] = 0 }
        for char in match {
            hashMatch[char] = (hashMatch[char] ?? 0) + 1
        }
        
        var start: Int = 0
        var windowStart: Int = -1
        var minLength: Int = Int.max
        var count: Int = 0
        
        for j in 0..<str.count {
            
            if let strCount = hashString[str[j]] { hashString[str[j]] = strCount + 1 }
            if let matchCount = hashMatch[str[j]], let strCount = hashString[str[j]], strCount <= matchCount { count += 1 }
            
            if count == match.count {
                var shouldMoveStartIndex: Bool = true
                repeat {
                    
                    guard let matchCount = hashMatch[str[start]] else {
                        start += 1
                        continue
                    }
                    
                    if let strCount = hashString[str[start]], strCount > matchCount {
                        hashString[str[start]] = strCount - 1
                        start += 1
                    } else {
                        shouldMoveStartIndex = false
                    }
                } while shouldMoveStartIndex
                    
                let windowLength = j - start + 1
                if minLength > windowLength {
                    minLength = windowLength
                    windowStart = start
                }
            }
        }
        
        if windowStart == -1 { return "" }
        let windowEnd: Int = windowStart + minLength - 1
        
        return String(str[windowStart...windowEnd])
    }
    
    /// Given a list of integers S and a target number k, write a function that returns whether subset of S that adds up to k.
    /// If such a subset cannot be made, then return false. Integers can appear more than once in the list. You may assume
    /// all numbers in the list are positive.
    /// ```
    /// e.g. given S = [12, 1, 61, 5, 9, 2] and k = 24, return true since [12, 9, 2, 1] sums up to 24.
    /// ```
    /// - parameter arr: An array of integers.
    /// - parameter k: The target sum.
    /// - returns: A boolean indicating if any subset of the  array sums up to the target sum.
    func subsetSum(arr: [Int], k: Int) -> Bool {
        
        var lookup: [String:Bool] = [:]
        
        func subset(n: Int, remainder: Int) -> Bool {
            
            if remainder == 0 { return true }
            if n < 0 || remainder < 0 { return false }
            
            let key = String(n) + ":" + String(remainder)
            
            if let res = lookup[key] {
                return res
            }
            
            let include = subset(n: n - 1, remainder: remainder - arr[n])
            let exclude = subset(n: n - 1, remainder: remainder)
            lookup[key] = include || exclude
            
            return include || exclude
        }
        
        return subset(n: arr.count - 1, remainder: k)
    }
    
    /// Given a string of round, curly, and square open and closing brackets, return whether the brackets are balanced (well-formed).
    /// ```
    /// e.g. given the string  "([])[]({})", should return true.
    /// e.g. given the string "([)]" or "((()", should return false.
    /// ```
    /// - parameter brackets: A string of opening and closing brackets.
    /// - returns: A boolean indicating whether the opening and closing brackets are balanced.
    /// - complexity: O(n), where n is the length of the input string.
    func matchingBrackets(brackets: String) -> Bool {
        
        let chars: [Character] = Array(brackets)
        var stack: Stack = Stack<String>()
        
        let closing: Set = ["]", ")", "}"]
        let opening: Set = ["[", "(", "{"]
        
        let closeMap: [String:String] = [
            "]":"[",
            ")":"(",
            "}":"{"
        ]
                
        for item in chars {
            
            let bracket = String(item)
            
            if closing.contains(bracket) {
                
                if let match = stack.pop() {
                    if let map = closeMap[bracket] {
                        if match != map { return false }
                    } 
                } else {
                    return false
                }
            }
          
            if opening.contains(bracket) {
                stack.push(bracket)
            }
        }
        
        if !stack.isEmpty { return false }
        
        return true
    }
}
