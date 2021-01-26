//
//  AdjacencyList.swift
//  DSA_Easy
//
//  Created by Hadi Kheyruri on 2020-12-01.
//  Copyright © 2020 SerenaVisions Technology Inc. All rights reserved.
//

import Foundation

fileprivate struct AdjNode: Equatable, Hashable, CustomStringConvertible {
    
    private var label: String = ""
    var description: String { return label }
    
    init(_ label: String) {
        self.label = label
    }
    
    static func == (lhs: AdjNode, rhs: AdjNode) -> Bool {
        return lhs.label == rhs.label
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(label)
    }
}


struct AdjacencyList: CustomStringConvertible {
    
    private var adjList: [AdjNode: [AdjNode]] = [:]
    
    var description: String { return "\(adjList)" }
    
    /// Add a node to the adjacency list.
    ///
    /// - parameter label: The label of the node that is to be added to the Graph.
    /// - complexity: O(1)
    mutating func addNode(_ label: String) {
        let node = AdjNode(label)
        guard adjList[node] == nil else { return }
        adjList[node] = []
    }
    
    /// Removes a node from the adjacency list.
    ///
    /// - parameter label: The label of the node that is to be removed from the Graph.
    /// - complexity: O(n), where n is the number of nodes in the adjacency list.
    mutating func removeNode(_ label: String) {
        let node = AdjNode(label)
        guard adjList[node] != nil else { return }
        adjList[node] = nil
        
        for key in adjList.keys {
            adjList[key] = adjList[key]?.filter() { $0 != node }
        }
    }
    
    /// Adds an edge between from and to nodes.
    ///
    /// - parameter from: The label for the node at head of the edge.
    /// - parameter to: The label for the node at the tail of the edge.
    /// - complexity: O(1)
    mutating func addEdge(from fromLabel: String, to toLabel: String) {
        
        let fromNode = AdjNode(fromLabel)
        let toNode   = AdjNode(toLabel)
        
        guard adjList[fromNode] != nil else { return }
        guard adjList[toNode] != nil else { return }
        
        if let contains = adjList[fromNode]?.contains(toNode), contains == false {
            adjList[fromNode]?.append(toNode)
        }
    }
    
    /// Removes and edge between from and to nodes.
    ///
    /// - parameter from: The label for the node at head of the edge.
    /// - parameter to: The label for the node at the tail of the edge.
    mutating func removeEgde(from fromLabel: String, to toLabel: String) {
        
        let fromNode = AdjNode(fromLabel)
        let toNode   = AdjNode(toLabel)
        
        guard adjList[fromNode] != nil else { return }
        guard adjList[toNode] != nil else { return }
        adjList[fromNode] = adjList[fromNode]?.filter() { $0 != toNode }
    }
    
    /// Depth First Traverse of the adjacency list  starting from a given root node.
    ///
    /// - parameter root: The label of node from which the depth first traverse begins.
    /// - returns: An array of labels of nodes in order which they were visited.
    func depthFirstTraverse(root label: String) -> Array<String> {
        
        var visited: Array = Array<String>()
        var stack: Stack = Stack<AdjNode>()
        let node = AdjNode(label)
        
        guard adjList[node] != nil else { return visited }
        
        stack.push(node)
        while !stack.isEmpty {
            
            guard let node = stack.pop() else { continue }
            
            if !visited.contains("\(node)") {
                visited.append("\(node)")
                let adjacantNodes = self.adjacantVertices(for: "\(node)")
                for listNode in adjacantNodes {
                    stack.push(listNode)
                }
            }
        }
        
        return visited
    }
    
    /// Breadth First Traverse of the graph statring from a given root node.
    ///
    /// - parameter root: The label of node from which the breadth first traverse begins.
    /// - returns: An array of labels of nodes in order which they were visited.
    func breadthFirstTraverse(root label: String) -> Array<String> {

        var visited: Array = Array<String>()
        let queue: Deque = Deque<AdjNode>()
        let node = AdjNode(label)

        guard adjList[node] != nil else { return visited }

        visited.append("\(node)")
        queue.insertFront(node)

        while !queue.isEmpty {

            guard let node = queue.removeFront() else { continue }
            let adjacantNodes = self.adjacantVertices(for: "\(node)")

            for listNode in adjacantNodes {

                if !visited.contains("\(listNode)") {
                    visited.append("\(listNode)")
                    queue.insertFront(listNode)
                }
            }
        }

        return visited
    }
    
    /// Access method for adjacant vertices for a specific node.
    ///
    /// - parameter for: The label of a specific node that adjacency is queried.
    /// - returns: An array of adjacant nodex.
    fileprivate func adjacantVertices(for label: String) -> [AdjNode] {
        
        let node = AdjNode(label)
        guard let nodeList = adjList[node] else { return [] }
        
        return nodeList
    }
}

