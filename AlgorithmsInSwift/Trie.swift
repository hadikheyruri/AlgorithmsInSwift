//
//  Trie.swift
//  DSA_Easy
//
//  Created by Hadi Kheyruri on 2020-11-23.
//  Copyright © 2020 SerenaVisions Technology Inc. All rights reserved.
//

import Foundation

fileprivate let kAlphabetSize: Int = 26

/// A trie or prefix tree  is a tree data structure that is usually used to store and search strings.
/// In a trie nodes contain characters and not strings. A typical use case for trie data strcuture is auto complete.
/// In a trie each node fans-out equal to the number of possible values of alphabet (similar to binary tree that
/// fans-out only to 0 and 1).
///
/// Within a trie, words with the same stem (prefix) share the memory area that corresponds to the stem.
/// What makes the trie structure really perform well in these situations is that the cost of looking up a word
/// or prefix is fixed and dependent only on the number of characters in the word and not on the size of the vocabulary.
class Trie {
    
    class TrieNode {
        var children: [TrieNode?] = [TrieNode?](repeating: nil, count: kAlphabetSize)
        var isLeaf: Bool = false
    }
    
    private var root: TrieNode?
    
    init() {
        root = TrieNode()
    }
    
    /// Adds a strings to the trie.
    ///
    /// - parameter word: A string to be added to the trie.
    /// - complexity: O(k) where k is the length of the string.
    func insert(_ word: String) {
            
        var pCrawl = root
        for char in Array(word) {
            guard let index = charIndex(char) else { continue }
            if pCrawl?.children[index] == nil {
                pCrawl?.children[index] = TrieNode()
                pCrawl?.isLeaf = false
            }
            
            pCrawl = pCrawl?.children[index]
        }
        
        pCrawl?.isLeaf = true
    }
    
    /// Queries existence of a word in the trie.
    ///
    /// - parameter word: A string that is to be queried.
    /// - returns: A boolean indicating whether a word is present in the trie or not.
    /// - complexity: O(k) where k is the length of the string.
    func search(_ word: String) -> Bool {

        var pCrawl = root
        for char in Array(word) {
            
            guard let index = charIndex(char) else { continue }
            guard pCrawl?.children[index] != nil else { return false }
            pCrawl = pCrawl?.children[index]
        }
                
        return pCrawl?.isLeaf ?? false
    }
    
    /// Searches the trie for all strings with a specific prefix stem.
    ///
    /// - parameter prefix: A string prefix.
    /// - returns: An array of strings that share the same prefix.
    func autoComplete(_ prefix: String) -> [String] {
        
        var pCrawl = root
        for char in Array(prefix) {
            
            guard let index = charIndex(char) else { continue }
            guard pCrawl?.children[index] != nil else { return [] }
            pCrawl = pCrawl?.children[index]
        }
        
        if pCrawl?.isLeaf == true { return [] }
        
        return self.suggestionRec(prefix, node: pCrawl, suggestions: [])
    }
    
    /// Recursive method for crawling the trie.
    private func suggestionRec(_ prefix: String, node: TrieNode?, suggestions: [String]) -> [String]  {
      
        guard let node = node else { return [] }

        if node.isLeaf == true { return [prefix] + suggestions }

        var suggested: [String] = suggestions
        for index in 0..<kAlphabetSize {
            let char = Character(UnicodeScalar(UInt8(index + 97)))
            let appended = prefix + "\(char)"
            suggested += self.suggestionRec(appended, node: node.children[index], suggestions: suggestions)
        }
        
        return suggested
    }
    
    /// Ascii value of a character.
    private func charIndex(_ char: Character) -> Int? {
        guard let asc = char.asciiValue else { return nil }
        return Int(asc - 97) // ascii value for letter a is 97.
    }
}
