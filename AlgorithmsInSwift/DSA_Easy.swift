//
//  DSA_Easy.swift
//  DSA_Easy
//
//  Created by Hadi Kheyruri on 2020-11-11.
//  Copyright © 2020 SerenaVisions Technology Inc. All rights reserved.
//

import Foundation

class DSA_Easy {

    /// Given a list of possibly overlapping intervals, return a new list of intervals where all overlapping
    /// intervals have been merged. The input list is not necessarily ordered in any way.
    ///
    /// ```
    /// e.g. given [(1, 3), (5, 8), (4, 10), (20, 25)], return [(1, 3), (4, 10), (20, 25)]
    /// e.g. given [(1, 3), (2, 6), (8, 10), (15, 18)], return [(1, 6), (8, 10), (15, 18)]
    /// e.g. given  [(1, 5), (2, 3), (4, 6), (7, 8), (8, 10), (12, 15)], return [(1, 6), (7, 10), (12, 15)]
    /// ```
    /// - parameter intervals: An array of interval tuples, with each tuple indicating (begin, end) of the interval.
    /// - returns: A merged  array of interval tuples, with each tuple indicating (begin, end) of the interval.
    func mergeOverlappingIntervals(intervals: [(Int, Int)]) -> [(Int, Int)] {
        
        let sorted: [(Int, Int)] = intervals.sorted(by: { $0.0 < $1.0 })
        var stack : Stack = Stack<(Int, Int)>()
        
        for interval in sorted {
            
            if let top = stack.peek(), interval.0 <= top.1 { // In case of overlap update the hi of stack top.
                if let pop = stack.pop() {
                    let item: (Int, Int) = (pop.0, max(interval.1, pop.1))
                    stack.push(item)
                }
            } else {       // the stack is empty or the current interval does not overlap with the stack top.
                stack.push(interval)
            }
        }
        
        return stack.allElements()
    }
  
    /// Division of two positive integers without using the division, multiplication, or modulus operators.
    /// Return the quotient as an integer, ignoring the remainder.
    ///
    /// - parameters:
    ///     - x: An integer dividend
    ///     - y: An integer devisor
    /// - returns: An integer quotient
    func rudimentaryDivision(_ x: Int, by y: Int) -> Int {
        
        if x < y { return 0 }
        
        var remainder = x
        var quotient = 0

        while remainder >= y {
            remainder -= y
            quotient += 1
        }
        
        return quotient
    }
    
    /// A basic reservoir sampling, with a sample size of one.
    /// Given a stream of elements too large to store in memory, pick a random element from the stream with uniform probability.
    ///
    /// ```
    /// usage e.g.:
    /// let stream = [10, 2, 7, 100, 420, 711]
    ///
    /// for item in stream {
    ///     print(dsa.selectRandomNumberFromStream(streamItem: item))
    /// }
    /// ```
    /// - parameter streamItem: An integer in an stream of integers.
    /// - returns: An integer from the input stream of integer items with uniform probability.
    /// - complexity: O(1) space complexity.
    func selectRandomNumberFromStream(streamItem item: Int) -> Int {
        
        struct RandomNumber {
            static var result: Int = 0
            static var count:  Int = 0
            static func incrementCount() { count += 1 }
        }
        
        RandomNumber.incrementCount()
        if RandomNumber.count == 1 {
            RandomNumber.result = item
        } else if Int.random(in: 0..<RandomNumber.count) == 1 {
            RandomNumber.result = item
        }
        
        return RandomNumber.result
    }
    
    /// Counts all the different combinations that a string of integers can be split into prime numbers.
    ///
    /// - parameter s: A string of integers.
    /// - returns: An integer which is the count of different combination of splitting the string into prime numbers.
    func primeSplitCount(s: String, len: Int) -> Int {
        
        if len == 0 { return 1 }
        
        struct NumChar {
            static var chars: [Character] = []
            static func num(from: Int, to: Int) -> Int {
                return Int(String(chars[from..<to])) ?? 0
            }
        }
        
        func isPrime(num: Int) -> Bool {
            if num <= 1 { return false }
            if num <= 3 { return true }
            
            var counter: Int = 2
            while counter * counter <= num {
                if num % counter == 0 { return false }
                counter += 1
            }
            return true
        }
        
        let mod: Int = 1000000007
        NumChar.chars = Array(s)
        var count: Int = 0
        
        for j in 1...6 {
            
            if len - j >= 0 && NumChar.chars[len - j] != "0" {
                let num = NumChar.num(from: len - j, to: len)
                if isPrime(num: num) {
                    count += primeSplitCount(s: s, len: len - j)
                    count %= mod
                }
            }
        }
        
        return count
    }
    
    /// Colors a given graph with set of colors such that no two adjacent vertices have the same color.
    ///
    /// - parameter graph: An array of vertices which represent a graph.
    /// - parameter colors: An array of strings where each string is a color.
    /// - returns: An array of colored vertices which represent the input graph.
    /// - complexity: O(n ^ 2), where n is the number of vertices in the graph.
    func colorGraph(_ graph: [Vertex], withColors colors: [String]) -> [Vertex] {
        
        for node in graph {
            // get the node's neighbors' colors, as a set so we
            // can check if a color is illegal in constant time
            let illegalColors = Set(node.adjacencies.map { $0.color })
            // assign the first legal color
            node.color = colors.first { !illegalColors.contains($0) }
        }
        
        return graph
    }
    
    /// Verifies whether a string is anagram of another string.
    ///
    /// - parameter s1: A string.
    /// - parameter s2: Second string.
    /// - returns: A boolean indicating if s1 is anagram of s2.
    /// - complexity: O(n), where n is length  of each string.
    func anagrams(_ s1: String,_ s2: String) -> Bool {
        
        if s1.count != s2.count { return false }
        var anagram: Int = 0
        
        Array(s1).forEach { char in
            if let value = char.asciiValue { anagram += Int(value) }
        }
        
        Array(s2).forEach { char in
            if let value = char.asciiValue { anagram -= Int(value) }
        }
        
        if anagram == 0 {
            return true
        }
        
        return false
    }
    
    /// Given two strings A and B, return whether or not A can be shifted some number of times to get B.
    ///
    /// - parameter s1: First string.
    /// - parameter s2: Second string.
    /// - returns: A boolean.
    func isRotatedSame(_ s1: String, _ s2: String) -> Bool {
        
        if s1.count != s2.count { return false }
        
        var arr1 = Array(s1)
        let arr2 = Array(s2)

        for _ in 1..<arr1.count {
            arr1.append(arr1.removeFirst())
            if arr1 == arr2 {
                return true
            }
        }
        
        return false
    }
    
    /// A brute force implementation for shortest substring problem. It doesn't account for empty and repeat characters in containing char string.
    ///
    ///```
    /// e.g. given the string "figehaeci" and set of characters "aei", you should return "aeci"
    /// e.g. given the string "adobecodebanc" and set of characters "abc", you should return "banc"
    ///```
    ///
    /// - parameter str: A string, which will be queried for shortest substring.
    /// - parameter chars: A string of characters, which should be present in the shortest substring.
    /// - returns: A string, that is the shortest substring of the original string containg all characters from second string.
    /// - complexity: O(m*n^2), where n is the length of the string and m is the number of  characters that need be in the substring.
    func shortestSubstring(_ str: String, containing containChars: String) -> String {
        
        func isValidSubstring(sub: [Character]) -> Bool {
            let match = Set(sub)
            for containChar in containChars {
                if !match.contains(containChar) { return false }
            }
            return true
        }
        
        let chars: [Character] = Array(str)
        for sliceSize in containChars.count...chars.count {
            for start in 0..<chars.count {
                
                let end = sliceSize + start - 1
                if end >= chars.count { break }
                let sub: [Character] = Array(chars[start...end])
                if isValidSubstring(sub: sub) {
                    return String(sub)
                }
            }
        }
        
        if isValidSubstring(sub: chars) {
            return str
        }
        
        return ""
    }
    
    /// Finds the longest palindromic substring using a brute force method.
    /// 
    /// - parameter s: A string as input.
    /// - returns: A string, which is the longest palindromic substring of the input string.
    /// - complexity: O(n ^ 2), where n is the lenght of the string.
    func longestPalindromicSubstring(_ s: String) -> String {

        let chars: [Character] = Array(s)
        var maxLength: Int = 0
        var start: Int = 0
        let len: Int = s.count
        
        var head: Int = 0
        var tail: Int = 0
        
        // One by one consider every character as center point of even and length palindromes.
        for i in 0..<len {
            
            // Find the longest even length palindrome with center points as i-1 and i.
            head = i - 1
            tail = i
            while head >= 0 && tail < len && chars[head] == chars[tail] {
                if tail - head + 1 > maxLength {
                    start = head
                    maxLength = tail - head + 1
                }
                
                head -= 1 // exapnd the window around the center.
                tail += 1
            }
            
            // Find the longest odd length palindrome with center point as i.
            head = i - 1
            tail = i + 1
            while head >= 0 && tail < len && chars[head] == chars[tail] {
                
                if tail - head + 1 > maxLength {
                    start = head
                    maxLength = tail - head + 1;
                }
                
                head -= 1 // expand the window.
                tail += 1
            }
        }
        
        if maxLength == 0 { return "" }
        
        return String(chars[start...(start + maxLength - 1)])
    }
    
    /// Takes a word and turns it into a palindrome.
    ///
    /// - parameter word: A string, representing a word.
    /// - returns: A string, which is a  palindrome using the input word.
    func makePalindrome(from word: String) -> String {
        
        let chars: [Character] = Array(word)
        var palindrome: String = word
        var prefix: String = ""
        var index: Int = chars.count - 1
        
        while palindrome != String(palindrome.reversed()) {
            
            prefix += String(chars[index])
            palindrome = prefix + word
            index -= 1
        }
        
        return palindrome
    }
    
    /// Given a dictionary of words and a string made up of those words (no spaces), return the original sentence in a list.
    /// If there is more than one possible reconstruction, return any of them. If there is no possible reconstruction, then return null.
    ///
    /// ```
    /// e.g. given the words "quick", "brown", "the", "fox",
    /// and the string "thequickbrownfox", you should return ["the", "quick", "brown", "fox"].
    ///
    /// e.g. given the words "bed", "bath", "bedbath", "and", "beyond", and
    /// the string "bedbathandbeyond", return either ["bed", "bath", "and", "beyond"] or ["bedbath", "and", "beyond"].
    ///```
    ///
    /// - parameter str: An input string representing a senetence with all the words joined in one string.
    /// - parameter words: A set of distinct words.
    /// - returns: An array of strings, representing the resulting senetence where each string is a word in the sentence.
    func reconstructSentence(from str: String, and words: Set<String>) -> [String] {
        
        var wordUse: [String:Bool] = [:]
        let chars: [Character] = Array(str)
        var head: Int = 0
        var sentence: [String] = []
        
        for word in words { wordUse[word] = false }
        
        while head < chars.count {
            
            var foundWord: Bool = false
            for key in wordUse.keys {
                
                guard let usedBefore = wordUse[key], usedBefore == false else { continue }
                
                let tail = min(head + key.count - 1, chars.count - 1)
                let sub = String(chars[head...tail])
       
                if sub == key {
                    sentence.append(key)
                    wordUse[key] = false
                    head += key.count
                    foundWord = true
                    break
                }
            }
            if !foundWord { return [] }
        }
                
        return sentence
    }
    
    /// Reverse words in a sentence where words are separated by an empty space.
    /// ```
    /// e.g. given "you shall not pass", return "pass not shall you"
    /// ```
    /// - parameter sentence: A string containing words separated by an empty space.
    /// - returns: A string with order of the words reversed.
    /// - complexity: O(n), where n is the length of the string.
    func reverse(sentence: String) -> String {
        
        let str: [String] = sentence.split(separator: " ").map(String.init)
        var rev: String = ""
        
        for (index, item) in str.reversed().enumerated() {
            rev.append(item)
            if index != str.count - 1 {
                rev.append(" ")
            }
        }
        
        return rev
    }
    
    /// Estimates pi using monte carlo method on circle euqation: x * x + y * y = r * r
    ///
    /// - returns: A double, which is pi with two decimal points, 3.14.
    func estimatePi() -> Double {
        
        let insideUnitSquareCount: Int = 2000000
        var insideUnitCircleCount: Int = 0
        
        for _ in 1...insideUnitSquareCount {
            
            let x = Float.random(in: -1...1)
            let y = Float.random(in: -1...1)
            let r = x * x + y * y
            if r < 1 { insideUnitCircleCount += 1 }
        }
        
        // square area: d^2 = 1
        // circle area: pi * r^2 = pi * (d/2)^2 = pi * (d^2/4) = pi * square_area / 4 = pi / 4  =>> pi = circle_area * 4
        let area: Double = Double(insideUnitCircleCount) / Double(insideUnitSquareCount)
        let pi = area * 4.0
        
        return round(pi * 100) / 100
    }
    
    /// Extract numbers from a string, concatenates them and returns the numeric integer value.
    ///
    /// - parameter str: A string containing digits and letters.
    /// - returns: An integer, as a numeric value of the digits in the string.
    func extractNumber(from str: String) -> Int {
        
        let digits = CharacterSet.decimalDigits
        var numStr = ""
        
        for scalar in str.unicodeScalars {
            if digits.contains(scalar) {
                numStr += String(scalar)
            }
        }
        guard let num = Int(numStr) else { return 0 }
        
        return num
    }
}
