//
//  Graph.swift
//  DSA_Easy
//
//  Created by Hadi Kheyruri on 2020-12-01.
//  Copyright © 2020 SerenaVisions Technology Inc. All rights reserved.
//

import Foundation

enum GraphType {
    case directed
    case undirected
}

fileprivate struct GraphNode: Equatable, Hashable, CustomStringConvertible {
    
    var label: String = ""
    var description: String { return label }
    
    static func ==(lhs: GraphNode, rhs: GraphNode) -> Bool {
        return lhs.label == rhs.label
    }
    
    func hash(hasher: inout Hasher) {
        hasher.combine(label)
    }
}

fileprivate struct GraphEdge: Equatable, CustomStringConvertible {
    
    var neighbour: GraphNode = GraphNode()
    var weight: Double = 0
    var description: String {
        var res = neighbour.description
        res += ":"
        res += "\(weight)"
        return res
    }
    
    init(to: GraphNode, weight: Double = 0) {
        self.neighbour = to
        self.weight = weight
    }
    
    static func ==(lhs: GraphEdge, rhs:GraphEdge) -> Bool {
        return lhs.neighbour == rhs.neighbour
    }
}

fileprivate struct CostItem: Comparable {

    var node: GraphNode = GraphNode()
    var cost: Double = Double.infinity

    static func < (lhs: CostItem, rhs: CostItem) -> Bool {
        return lhs.cost < rhs.cost
    }
}

fileprivate struct GraphPathTable {
    
    var distances: [Double]
    var prevNodes: [String]
}

/// Graph struct is an implementation for an undirected graph, where edges can be weighted.
/// This implementation only allows for a single undirected edge from one node to another.
/// Also it doesn't allow for loops (i.e. an edge from a node to iteself).
struct Graph: CustomStringConvertible {
    
    private var nodes: [GraphNode] = []
    private var edges: [GraphNode: [GraphEdge]] = [:]
    private var nodeIndexes: [GraphNode: Int] = [:]
    private var paths: [GraphNode: GraphPathTable] = [:]

    private var type: GraphType = .undirected
    
    init(type: GraphType = .undirected) {
        self.type = type
    }
    
    var description: String {
        var res = ""
        for key in self.nodes {
            res += "[\(key): "
            if let arr = self.edges[key] { res += arr.description }
            res += "]"
        }
        return res
    }
    
    private func getIndex(for node: GraphNode) -> Int {
        guard let index = self.nodeIndexes[node] else { fatalError("Node: \(node) not in the Graph.") }
        return index
    }
    
    private func getIndex(for label: String) -> Int {
        let node = GraphNode(label: label)
        guard let index = self.nodeIndexes[node] else { fatalError("Node: \(node) not in the Graph.") }
        return index
    }
    
    private func pathArray(for path: GraphPathTable, from: String, to: String) -> [String] {
        
        var index = getIndex(for: to)
        var res: [String] = []
        let fromIndex = getIndex(for: from)
        
        res.append(to)
        while index != fromIndex {
            let prevNode = path.prevNodes[index]
            index = getIndex(for: prevNode)
            res.append(prevNode)
        }
        
        return res.reversed()
    }
    
    /// Adds a node to the graph.
    ///
    /// - parameter label: A string representing the label of the node.
    /// - returns: A boolean indicating whether the operation was successful, it fails if there exists an indentical label in the graph.
    /// - complexity: O(1)
    @discardableResult mutating func addNode(withLabel label: String) -> Bool {
        let node = GraphNode(label: label)
        guard self.edges[node] == nil else { return false }

        self.nodes.append(node)
        self.edges[node] = []
        
        self.nodeIndexes[node] = self.nodes.count - 1
        self.paths.removeAll()

        return true
    }
    
    /// Removes a node from the graph.
    ///
    /// - parameter label: A string representing the label of the node.
    /// - returns: A boolean indicating whether the operation was successful, it fails if there is no such node.
    /// - complexity: O(n + m), where n is the number of nodes in the graph and m is number of edges in the graph.
    @discardableResult mutating func removeNode(withLabel label: String) -> Bool {
        let node = GraphNode(label: label)
        guard let _ = self.edges[node] else { return false }
        self.nodes = self.nodes.filter() { node != $0 }
        self.edges.removeValue(forKey: node)
        
        for key in self.nodes {
            self.edges[key] = self.edges[key]?.filter() { GraphEdge(to: node) != $0 }
        }
        
        self.nodeIndexes.removeValue(forKey: node)
        self.paths.removeAll()

        return true
    }
    
    /// Adds an edge between two nodes in the graph. Only allows for a single undirected edge from one node to another.
    /// Also it doesn't allow for loops (i.e. an edge from a node to iteself).
    ///
    /// - parameters:
    ///     -   from: A string representing the label for the head of the edge.
    ///     -   to: A string representing the label for the tail of the edge.
    ///     -   weight: Assigns a weight to the edge (optional).
    /// - returns: A boolean indicating whether the operation was successful.
    /// - complexity: O(k), where k is number of edges for from node.
    @discardableResult mutating func addEdge(from: String, to: String, weight: Double = 0) -> Bool {
        let fromNode = GraphNode(label: from)
        let toNode = GraphNode(label: to)
        
        guard fromNode != toNode else { return false }
        guard let _ = self.edges[fromNode], let _ = self.edges[toNode] else { return false }
        
        let directedEdge = GraphEdge(to: toNode, weight: weight)
        if let exists = self.edges[fromNode]?.contains(directedEdge), exists == false {
            self.edges[fromNode]?.append(directedEdge)
        }
        
        if self.type == .directed { return true }
        
        let undirectedEdge = GraphEdge(to: fromNode, weight: weight)
        if let exists = self.edges[toNode]?.contains(undirectedEdge), exists == false {
            self.edges[toNode]?.append(undirectedEdge)
        }
        self.paths.removeAll()

        return true
    }
    
    /// Removes an edge from the graph.
    ///
    /// - parameters:
    ///     -   from: A string representing the label for the head of the edge.
    ///     -   to: A string representing the label for the tail of the edge.
    /// - returns: A boolean indicating whether the operation was successful.
    /// - complexity: O(k), where k is number of edges for from node.
    @discardableResult mutating func removeEdge(from: String, to: String) -> Bool {
        let fromNode = GraphNode(label: from)
        let toNode = GraphNode(label: to)
        
        guard fromNode != toNode else { return false }
        guard let _ = self.edges[fromNode], let _ = self.edges[toNode] else { return false }
        
        if let exists = self.edges[fromNode]?.contains(GraphEdge(to: toNode)), exists == true {
            self.edges[fromNode] = self.edges[fromNode]?.filter() { GraphEdge(to: toNode) != $0 }
        }
        
        if self.type == .directed { return true }

        if let exists = self.edges[toNode]?.contains(GraphEdge(to: fromNode)), exists == true {
            self.edges[toNode] = self.edges[toNode]?.filter() { GraphEdge(to: fromNode) != $0 }
        }
        self.paths.removeAll()
        
        return true
    }
    
    /// Finds the shortest path using the Dijkstra's algorithm implemented  by a binary heap. This method caches the results.
    ///
    /// - parameter from: Label of the starting node.
    /// - parameter to: Label of the end node.
    /// - returns: A table (represented as a tuple) consisting of two arrays. An array for previous node labels and an array for distances from the starting node.
    mutating func shortestPathTable(from: String, to: String) -> ([String], [Double]) {
        
        let fromNode = GraphNode(label: from)
        if let path = self.paths[fromNode] {
            return (path.prevNodes, path.distances)
        }

        var distances = [Double](repeating: Double.infinity, count: self.nodes.count)
        var prevNodes = [String](repeating: "", count: self.nodes.count)
        var visited: Set = Set<GraphNode>()
        var heap = Heap<CostItem>()
        
        heap.enqueue(CostItem(node: fromNode, cost: 0))
        visited.insert(fromNode)

        let startingIndex = getIndex(for: fromNode)
        distances[startingIndex] = 0
        
        while let q = heap.dequeue() {
            
            let uNode = q.node
            let uIndex = getIndex(for: q.node)
            self.edges[uNode]?.forEach() { edge in
                
                let vNode = edge.neighbour
                let vIndex = getIndex(for: vNode)
                if !visited.contains(vNode) && (distances[uIndex] + edge.weight) < distances[vIndex] {
                    
                    distances[vIndex] = distances[uIndex] + edge.weight
                    prevNodes[vIndex] = uNode.description
                    visited.insert(uNode)
                    heap.enqueue(CostItem(node: vNode, cost: q.cost + edge.weight))
                }
            }
            visited.insert(q.node)
        }
        self.paths[fromNode] = GraphPathTable(distances: distances, prevNodes: prevNodes)
        
        return (prevNodes, distances)
    }
    
    /// This method is a Facade for shortestPathTable() method. It generates a node label array for the shortest path
    /// between source (i.e. from) to destination (i.e. to) nodes using the Dijkstra's Path Table.
    ///
    /// - parameter from: Label of the starting node.
    /// - parameter to: Label of the end node.
    /// - returns: An array of nodes designating the shortest path from source to destination.
    mutating func shortestPath(from: String, to: String) -> [String] {
        
        let fromNode = GraphNode(label: from)
        let (prevNodes, distances) = self.shortestPathTable(from: from, to: to)
        let path = GraphPathTable(distances: distances, prevNodes: prevNodes)
        self.paths[fromNode] = path
        
        return self.pathArray(for: path, from: from, to: to)
    }
}
