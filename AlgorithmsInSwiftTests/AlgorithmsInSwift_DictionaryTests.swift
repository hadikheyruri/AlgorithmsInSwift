//
//  AlgorithmsInSwift_DictionaryTests.swift
//  AlgorithmsInSwiftTests
//
//  Created by Hadi Kheyruri on 2021-01-26.
//

import XCTest
@testable import AlgorithmsInSwift

class AlgorithmsInSwift_DictionaryTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testAutoComplete() {
        
        let dsa = DSA_Dictionary()
        let voc = ["dog", "deer", "deal", "beautiful", "bear", "bee"]
        XCTAssertEqual((dsa.autoComlpete(prefix: "de", vocabulary: voc)), ["deer", "deal"])
    }
    
    func testSumOfTwoNumbersInList() throws {
        
        let dsa = DSA_Dictionary()
        XCTAssertTrue(dsa.sumOfTwoNumbersInList(list: [10, 15, 3, 7], k: 17))
    }
    
    func testAdjacencyList() throws {
        
        var graph = AdjacencyList()
        graph.addNode("Bob")
        graph.addNode("Alice")
        graph.addNode("Mark")
        graph.addNode("Rob")
        graph.addNode("Maria")
        graph.addEdge(from: "Bob", to: "Alice")
        graph.addEdge(from: "Bob", to: "Rob")
        graph.addEdge(from: "Alice", to: "Bob")
        graph.addEdge(from: "Alice", to: "Mark")
        graph.addEdge(from: "Mark", to: "Alice")
        graph.addEdge(from: "Mark", to: "Rob")
        graph.addEdge(from: "Rob", to: "Bob")
        graph.addEdge(from: "Rob", to: "Mark")
        graph.addEdge(from: "Alice", to: "Maria")
        graph.addEdge(from: "Rob", to: "Maria")
        graph.addEdge(from: "Maria", to: "Alice")
        graph.addEdge(from: "Maria", to: "Rob")
        
        XCTAssertEqual(graph.breadthFirstTraverse(root: "Bob"), ["Bob", "Alice", "Rob", "Mark", "Maria"])
        XCTAssertEqual(graph.depthFirstTraverse(root: "Bob"),  ["Bob", "Rob", "Maria", "Alice", "Mark"])
    }
    
    func testGraph() throws {
        
        var graph = Graph()
        
        graph.addNode(withLabel: "A")
        graph.addNode(withLabel: "B")
        graph.addNode(withLabel: "C")
        graph.addNode(withLabel: "D")
        graph.addNode(withLabel: "E")
        
        graph.removeNode(withLabel: "F")
        graph.addNode(withLabel: "A")
        XCTAssertEqual(graph.description, "[A: []][B: []][C: []][D: []][E: []]")
        
        graph.addEdge(from: "A", to: "B", weight: 1)
        graph.addEdge(from: "A", to: "E", weight: 2)
        graph.addEdge(from: "A", to: "D", weight: 2)
        graph.addEdge(from: "E", to: "D", weight: 8)
        graph.addEdge(from: "E", to: "C", weight: 12)
        graph.addEdge(from: "B", to: "D", weight: 3)
        graph.addEdge(from: "A", to: "C", weight: 4)
        graph.addEdge(from: "C", to: "D", weight: 5)
        graph.addEdge(from: "D", to: "C", weight: 6)

        graph.addEdge(from: "B", to: "B")
        graph.addEdge(from: "E", to: "F", weight: 3)
        XCTAssertEqual(graph.description, "[A: [B:1.0, E:2.0, D:2.0, C:4.0]][B: [A:1.0, D:3.0]][C: [E:12.0, A:4.0, D:5.0]][D: [A:2.0, E:8.0, B:3.0, C:5.0]][E: [A:2.0, D:8.0, C:12.0]]")

        graph.removeEdge(from: "C", to: "E")
        graph.removeEdge(from: "B", to: "B")
        graph.removeEdge(from: "F", to: "B")
        XCTAssertEqual(graph.description, "[A: [B:1.0, E:2.0, D:2.0, C:4.0]][B: [A:1.0, D:3.0]][C: [A:4.0, D:5.0]][D: [A:2.0, E:8.0, B:3.0, C:5.0]][E: [A:2.0, D:8.0]]")

        graph.removeNode(withLabel: "E")
        XCTAssertEqual(graph.description, "[A: [B:1.0, D:2.0, C:4.0]][B: [A:1.0, D:3.0]][C: [A:4.0, D:5.0]][D: [A:2.0, B:3.0, C:5.0]]")
    }
    
    func testDijkstraTestCaseI() throws {
        
        var graph = Graph()

        graph.addNode(withLabel: "A")
        graph.addNode(withLabel: "B")
        graph.addNode(withLabel: "C")
        graph.addNode(withLabel: "D")
        graph.addNode(withLabel: "E")
        
        graph.addEdge(from: "A", to: "B", weight: 7)
        graph.addEdge(from: "A", to: "C", weight: 3)
        graph.addEdge(from: "C", to: "B", weight: 1)
        graph.addEdge(from: "C", to: "D", weight: 2)
        graph.addEdge(from: "D", to: "B", weight: 2)
        graph.addEdge(from: "D", to: "E", weight: 4)
        graph.addEdge(from: "E", to: "B", weight: 6)

        XCTAssertEqual(graph.description, "[A: [B:7.0, C:3.0]][B: [A:7.0, C:1.0, D:2.0, E:6.0]][C: [A:3.0, B:1.0, D:2.0]][D: [C:2.0, B:2.0, E:4.0]][E: [D:4.0, B:6.0]]")
        
        let (prevNodes, distances) = graph.shortestPathTable(from: "A", to: "E")
        XCTAssertEqual(prevNodes, ["", "C", "A", "C", "D"])
        XCTAssertEqual(distances, [0.0, 4.0, 3.0, 5.0, 9.0])
        XCTAssertEqual(graph.shortestPath(from: "A", to: "E"), ["A", "C", "D", "E"])
    }
    
    func testDijkstraTestCaseII() throws {
        
        var graph = Graph()

        graph.addNode(withLabel: "A")
        graph.addNode(withLabel: "B")
        graph.addNode(withLabel: "C")
        graph.addNode(withLabel: "D")
        graph.addNode(withLabel: "E")
        graph.addNode(withLabel: "F")
        graph.addNode(withLabel: "G")
        
        graph.addEdge(from: "A", to: "B", weight: 2)
        graph.addEdge(from: "A", to: "C", weight: 6)
        graph.addEdge(from: "B", to: "D", weight: 5)
        graph.addEdge(from: "C", to: "D", weight: 8)
        graph.addEdge(from: "D", to: "E", weight: 10)
        graph.addEdge(from: "D", to: "F", weight: 15)
        graph.addEdge(from: "E", to: "F", weight: 6)
        graph.addEdge(from: "E", to: "G", weight: 2)
        graph.addEdge(from: "F", to: "G", weight: 6)

        XCTAssertEqual(graph.description, "[A: [B:2.0, C:6.0]][B: [A:2.0, D:5.0]][C: [A:6.0, D:8.0]][D: [B:5.0, C:8.0, E:10.0, F:15.0]][E: [D:10.0, F:6.0, G:2.0]][F: [D:15.0, E:6.0, G:6.0]][G: [E:2.0, F:6.0]]")
        
        let (prevNodes, distances) = graph.shortestPathTable(from: "A", to: "G")
        XCTAssertEqual(prevNodes, ["", "A", "A", "B", "D", "D", "E"])
        XCTAssertEqual(distances, [0.0, 2.0, 6.0, 7.0, 17.0, 22.0, 19.0])
        XCTAssertEqual(graph.shortestPath(from: "A", to: "G"), ["A", "B", "D", "E", "G"])
    }
    
    func testDijkstraTestCaseIII() throws {
        
        var graph = Graph()

        graph.addNode(withLabel: "A")
        graph.addNode(withLabel: "B")
        graph.addNode(withLabel: "C")
        graph.addNode(withLabel: "D")
        graph.addNode(withLabel: "E")
        graph.addNode(withLabel: "F")
        graph.addNode(withLabel: "G")
        graph.addNode(withLabel: "H")
        
        graph.addEdge(from: "A", to: "B", weight: 7)
        graph.addEdge(from: "A", to: "D", weight: 6)
        graph.addEdge(from: "B", to: "C", weight: 9)
        graph.addEdge(from: "B", to: "D", weight: 8)
        graph.addEdge(from: "B", to: "G", weight: 6)
        graph.addEdge(from: "D", to: "F", weight: 2)
        graph.addEdge(from: "E", to: "H", weight: 1)
        graph.addEdge(from: "F", to: "G", weight: 6)
        graph.addEdge(from: "G", to: "H", weight: 8)

        XCTAssertEqual(graph.description, "[A: [B:7.0, D:6.0]][B: [A:7.0, C:9.0, D:8.0, G:6.0]][C: [B:9.0]][D: [A:6.0, B:8.0, F:2.0]][E: [H:1.0]][F: [D:2.0, G:6.0]][G: [B:6.0, F:6.0, H:8.0]][H: [E:1.0, G:8.0]]")
        
        let (prevNodes, distances) = graph.shortestPathTable(from: "A", to: "H")
        XCTAssertEqual(prevNodes, ["", "A", "B", "A", "H", "D", "B", "G"])
        XCTAssertEqual(distances, [0.0, 7.0, 16.0, 6.0, 22.0, 8.0, 13.0, 21.0])
        XCTAssertEqual(graph.shortestPath(from: "A", to: "E"), ["A", "B", "G", "H", "E"])
        XCTAssertEqual(graph.shortestPath(from: "B", to: "E"), ["B", "G", "H", "E"])
        XCTAssertEqual(graph.shortestPath(from: "E", to: "B"), ["E", "H", "G", "B"])
    }
    
    func testShortestSubstring() throws {
        
        let dsa = DSA_Dictionary()
        XCTAssertEqual(dsa.shortestSubstring("figehaeci", containing: "aei"), "aeci")
        XCTAssertEqual(dsa.shortestSubstring("a", containing: "a"), "a")
        XCTAssertEqual(dsa.shortestSubstring("adobecodebanc", containing: "abc"), "banc")
        XCTAssertEqual(dsa.shortestSubstring("this is a test string", containing: "tist"), "t stri")
        XCTAssertEqual(dsa.shortestSubstring("adobecodebanc", containing: "cdn"), "debanc")
        XCTAssertEqual(dsa.shortestSubstring("adobecodebanc", containing: "abn"), "ban")
    }
    
    func testSubsetSum() throws {
        
        let dsa = DSA_Dictionary()
        XCTAssertTrue(dsa.subsetSum(arr: [3, 34, 4, 12, 5, 2], k: 9))
        XCTAssertTrue(dsa.subsetSum(arr: [12, 1, 61, 5, 9, 2], k: 24))
        XCTAssertFalse(dsa.subsetSum(arr: [12, 1, 61, 5, 9, 2], k: 25))
        XCTAssertTrue(dsa.subsetSum(arr: [7, 3, 2, 5, 8, 20], k: 14))
        XCTAssertTrue(dsa.subsetSum(arr: [7, 3, 2, 5, 8], k: 18))
        XCTAssertFalse(dsa.subsetSum(arr: [7, 3, 2, 5, 8], k: 6))
    }
    
    func testBalancedBrackets() throws {
        
        let dsa = DSA_Dictionary()
        
        XCTAssertTrue(dsa.matchingBrackets(brackets: "([])[]({})"))
        XCTAssertFalse(dsa.matchingBrackets(brackets: "([)]"))
        XCTAssertFalse(dsa.matchingBrackets(brackets: "((()"))
    }

}
