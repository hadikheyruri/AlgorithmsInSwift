//
//  AlgorithmsInSwiftTests.swift
//  AlgorithmsInSwiftTests
//
//  Created by Hadi Kheyruri on 2021-01-26.
//

import XCTest
@testable import AlgorithmsInSwift

class AlgorithmsInSwiftTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testColorGraph() throws {
        
        let a = Vertex("a")
        let b = Vertex("b")
        let c = Vertex("c")

        a.adjacencies.insert(b)
        b.adjacencies.insert(a)
        b.adjacencies.insert(c)
        c.adjacencies.insert(b)

        let graph = [a, b, c]
        
        let dsa = DSA_Easy()
        let coloredGraph = dsa.colorGraph(graph, withColors: ["red", "blue", "pink"])
        XCTAssertEqual(coloredGraph.description, "[a:red, b:blue, c:red]")
    }
    
    func testColorGraphUndirected() throws {
        
        let a = Vertex("a")
        let b = Vertex("b")
        let c = Vertex("c")
        let d = Vertex("d")
        let e = Vertex("e")

        a.adjacencies.insert(b)
        b.adjacencies.insert(a)

        a.adjacencies.insert(c)
        c.adjacencies.insert(a)

        b.adjacencies.insert(c)
        c.adjacencies.insert(b)

        b.adjacencies.insert(d)
        d.adjacencies.insert(b)

        c.adjacencies.insert(d)
        d.adjacencies.insert(c)

        d.adjacencies.insert(e)
        e.adjacencies.insert(d)

        let graph = [a, b, c, d, e]
        
        let dsa = DSA_Easy()
        let coloredGraph = dsa.colorGraph(graph, withColors: ["red", "blue", "pink"])
        XCTAssertEqual(coloredGraph.description, "[a:red, b:blue, c:pink, d:red, e:blue]")
    }

    
    func testMergeOverlappingIntervals() throws {
        
        let dsa = DSA_Easy()
        let intervals1: [(Int, Int)] = [(1, 5), (2, 3), (4, 6), (7, 8), (8, 10), (12, 15)]
        XCTAssertEqual("\(dsa.mergeOverlappingIntervals(intervals: intervals1))", "[(1, 6), (7, 10), (12, 15)]")
        
        let intervals2: [(Int, Int)] = [(1, 3), (2, 6), (8, 10), (15, 18)]
        XCTAssertEqual("\(dsa.mergeOverlappingIntervals(intervals: intervals2))", "[(1, 6), (8, 10), (15, 18)]")
        
        let intervals3: [(Int, Int)] = [(1, 3), (5, 8), (4, 10), (20, 25)]
        XCTAssertEqual("\(dsa.mergeOverlappingIntervals(intervals: intervals3))", "[(1, 3), (4, 10), (20, 25)]")
    }
    
    func testRudimentaryDivision() throws {
        
        let dsa = DSA_Easy()
        XCTAssertEqual(dsa.rudimentaryDivision(17, by: 5), 3)
        XCTAssertEqual(dsa.rudimentaryDivision(40, by: 2), 20)
        XCTAssertEqual(dsa.rudimentaryDivision(3, by: 5), 0)
    }
    
    func testPrimeSplitCount() throws {
        
        let dsa = DSA_Easy()
        XCTAssertEqual(dsa.primeSplitCount(s: "43", len: "43".count), 1)
        XCTAssertEqual(dsa.primeSplitCount(s: "563", len: "563".count), 1)
        XCTAssertEqual(dsa.primeSplitCount(s: "9", len: "9".count), 0)
        XCTAssertEqual(dsa.primeSplitCount(s: "24", len: "24".count), 0)
        XCTAssertEqual(dsa.primeSplitCount(s: "33", len: "33".count), 1)
        XCTAssertEqual(dsa.primeSplitCount(s: "719", len: "719".count), 2)
        XCTAssertEqual(dsa.primeSplitCount(s: "1337", len: "1337".count), 2)
        XCTAssertEqual(dsa.primeSplitCount(s: "3175", len: "3175".count), 3)
        XCTAssertEqual(dsa.primeSplitCount(s: "11375", len: "11375".count), 3)
        XCTAssertEqual(dsa.primeSplitCount(s: "13499315", len: "13499315".count), 2)
        XCTAssertEqual(dsa.primeSplitCount(s: "3175", len: "3175".count), 3)
        XCTAssertEqual(dsa.primeSplitCount(s: "11373", len: "11373".count), 6)
        XCTAssertEqual(dsa.primeSplitCount(s: "135029", len: "135029".count), 1)
    }
    
    func testHeapEnqueue() throws {
        
        var heap = Heap<Int>(heapType: .maxHeap)
        heap.enqueue(80)
        heap.enqueue(20)
        heap.enqueue(60)
        heap.enqueue(40)
        heap.enqueue(10)
        heap.enqueue(30)
        heap.enqueue(50)
        heap.enqueue(90)
        heap.enqueue(5)
        XCTAssertEqual(heap.description, "[90, 80, 60, 40, 10, 30, 50, 20, 5]")
    }
    
    func testHeapInit() throws {
        
        let heap = Heap<Int>( [80, 20, 60, 40, 10, 30, 50, 90, 5], heapType: .maxHeap)
        XCTAssertEqual(heap.description, "[90, 80, 60, 40, 10, 30, 50, 20, 5]")
    }

    func testStackList() throws {
    
        let lStack = StackList<Int>()
        XCTAssertTrue(lStack.isEmpty)
        XCTAssertEqual(lStack.pop(), nil)

        lStack.push(25)
        lStack.push(30)
        lStack.push(4)
        lStack.push(1)
        lStack.push(36)
        lStack.push(11)
        lStack.pop()
        lStack.pop()
        lStack.pop()
        lStack.push(38)
        lStack.push(36)
        lStack.push(37)
        
        XCTAssertEqual(lStack.description, "|37|-->|36|-->|38|-->|4|-->|30|-->|25|")
        XCTAssertEqual(lStack.max(), 38)
        XCTAssertEqual(lStack.peek(), 37)
        XCTAssertFalse(lStack.isEmpty)
    }
    
    func testStack() throws {
        
        var stack = Stack<Int>()
        XCTAssertTrue(stack.isEmpty)

        stack.push(5)
        XCTAssertEqual(stack.pop(), 5)
        stack.push(10)
        stack.push(1)
        stack.push(4)
        
        XCTAssertEqual(stack.peek(), 4)
        XCTAssertFalse(stack.isEmpty)
        XCTAssertEqual(stack.allElements(), [10, 1, 4])
    }
    
    func testStackTrace() throws {
        
        var stack = StackTrace<Int>()
        XCTAssertTrue(stack.isEmpty)
        XCTAssertEqual(stack.pop(), nil)

        stack.push(5)
        XCTAssertEqual(stack.pop(), 5)
        stack.push(10)
        stack.push(1)
        stack.push(21)
        stack.push(3)
        stack.push(20)
        stack.push(4)
        
        XCTAssertEqual(stack.peek(), 4)
        XCTAssertFalse(stack.isEmpty)
        XCTAssertEqual(stack.max() , 21)
    }
    
    func testTrie() throws {
        
        let t = Trie()
        t.insert("deer")
        t.insert("dear")
        t.insert("beautiful")
        t.insert("dog")
        t.insert("deal")
        t.insert("besty")
        
        XCTAssertFalse(t.search("bee"))
        XCTAssertTrue(t.search("dog"))
        
        let result = Set(arrayLiteral: "besty", "beautiful")
        XCTAssertEqual(Set(t.autoComplete("be")), result)
    }
    
    func testDeque() throws {
        
        let deqList = Deque<Int>()
        XCTAssertEqual("\(deqList)", "")

        deqList.removeFront()
        deqList.removeRear()
        deqList.insertRear(10)
        deqList.removeRear()
        deqList.insertFront(11)
        deqList.insertFront(88)
        XCTAssertEqual(Array(deqList), [88, 11])
        
        deqList.removeFront()
        deqList.removeFront()
        deqList.insertRear(22)
        deqList.insertRear(33)
        deqList.removeRear()
        deqList.removeRear()
        XCTAssertEqual(Array(deqList), [])

        deqList.insertFront(77)
        deqList.insertRear(5)
        deqList.insertFront(7)
        deqList.insertFront(9)
        deqList.insertFront(3)
        deqList.removeRear()
        deqList.removeRear()
        XCTAssertEqual(Array(deqList), [3, 9, 7])
        XCTAssertEqual(deqList.description, "|3| -> |9| -> |7|")
        
        deqList.insertFront(9)
        deqList.insertFront(3)
        deqList.insertFront(2)
        deqList.insertRear(0)
        deqList.insertRear(100)
        deqList.insertRear(101)
        deqList.removeRear()
        deqList.removeFront()
        deqList.removeRear()
        deqList.insertRear(666)
        deqList.insertFront(1111)
        XCTAssertEqual(Array(deqList), [1111, 3, 9, 3, 9, 7, 0, 666])
        XCTAssertEqual(deqList.peekRear(), 666)
        XCTAssertEqual(deqList.peekFront(), 1111)
    }
    
    func testBST() throws {
        
        let bst = BSTNode<Int>()
        
        bst.insert(key: 10)
        XCTAssertTrue(bst.contains(key: 10))
        bst.insert(key: 5)
        bst.insert(key: 90)
        bst.insert(key: 32)
        bst.delete(key: 5)
        bst.insert(key: 150)
        bst.delete(key: 4)
        bst.delete(key: 2)
        bst.insert(key: 8)
        bst.insert(key: 66)
        bst.insert(key: 55)
        bst.insert(key: 13)
        bst.insert(key: 39)
        XCTAssertFalse(bst.contains(key: 5))
        XCTAssertFalse(bst.contains(key: 4))
        XCTAssertTrue(bst.contains(key: 150))
        XCTAssertTrue(bst.contains(key: 39))
        
        XCTAssertEqual(bst.count(), 9)
    }
    
    func testAnagram() throws {
        
        let dsa = DSA_Easy()
        XCTAssertFalse(dsa.anagrams("geeksforgeeks","forgeekggeeks"))
        XCTAssertTrue(dsa.anagrams("geeksforgeeks","forgeeksgeeks"))
    }
    
    func testIsRotatedSame() throws {
        
        let dsa = DSA_Easy()
        XCTAssertTrue(dsa.isRotatedSame("abcde", "cdeab"))
        XCTAssertFalse(dsa.isRotatedSame("abc", "acb"))
    }
    
    func testShortestSubstring() throws {
        
        let dsa = DSA_Easy()
        XCTAssertEqual(dsa.shortestSubstring("figehaeci", containing: "aei"), "aeci")
        XCTAssertEqual(dsa.shortestSubstring("figehaeci", containing: "haec"), "haec")
        XCTAssertEqual(dsa.shortestSubstring("a", containing: "a"), "a")
        XCTAssertEqual(dsa.shortestSubstring("adobecodebanc", containing: "abc"), "banc")
        XCTAssertEqual(dsa.shortestSubstring("adobecodebanc", containing: "abcd"), "adobec")
        XCTAssertEqual(dsa.shortestSubstring("adobecodebanc", containing: "abn"), "ban")
        XCTAssertEqual(dsa.shortestSubstring("adobecodebanc", containing: "cdn"), "debanc")
    }
    
    func testLongestPalindromicSubstring() throws {
        
        let dsa = DSA_Easy()
        XCTAssertEqual(dsa.longestPalindromicSubstring("dubootrtooz"),"ootrtoo")
        XCTAssertEqual(dsa.longestPalindromicSubstring("praderredim"),"derred")
        XCTAssertEqual(dsa.longestPalindromicSubstring("prade"),"")
        XCTAssertEqual(dsa.longestPalindromicSubstring("tenet"),"tenet")
        XCTAssertEqual(dsa.longestPalindromicSubstring("booo"),"ooo")
        XCTAssertEqual(dsa.longestPalindromicSubstring("roose"),"oo")
    }
    
    func testMakePalindrome() throws {
        
        let dsa = DSA_Easy()
        XCTAssertEqual(dsa.makePalindrome(from: "google"), "elgoogle")
        XCTAssertEqual(dsa.makePalindrome(from: "tenet"), "tenet")
        XCTAssertEqual(dsa.makePalindrome(from: "race"), "ecarace")

    }
    
    func testReconstructSentence() throws {
        
        let dsa = DSA_Easy()
        var words: Set = Set<String>()
        words.insert("quick")
        words.insert("fox")
        words.insert("the")
        words.insert("silver")
        
        XCTAssertEqual(dsa.reconstructSentence(from: "thequickbrownfox", and: words), [])
        words.insert("brown")

        XCTAssertEqual(dsa.reconstructSentence(from: "thequickbrownfox", and: words), ["the", "quick", "brown", "fox"])
    }
    
    func testQueue() throws {
        
        var q: Queue = Queue<Int>()
        XCTAssertTrue(q.isEmpty)
        q.enqueue(newElement: 6)
        q.enqueue(newElement: 4)
        q.enqueue(newElement: 9)
        q.enqueue(newElement: 2)
        q.enqueue(newElement: 8)
        
        q.dequeue()
        q.dequeue()
        q.enqueue(newElement: 7)
        
        XCTAssertEqual(q.count, 4)
        XCTAssertEqual(q.dequeue(), 9)
        XCTAssertFalse(q.isEmpty)
    }
    
    func testReverse() throws {
        
        let dsa = DSA_Easy()
        XCTAssertEqual(dsa.reverse(sentence: "you shall not pass"), "pass not shall you")
    }
    
    func testEstimatePi() throws {
        
        let dsa = DSA_Easy()
        XCTAssertEqual(dsa.estimatePi(), 3.14)
    }
    
    func testExtractNumber() throws {
        
        let dsa = DSA_Easy()
        XCTAssertEqual(dsa.extractNumber(from: "unicorn120p"), 120)
        XCTAssertEqual(dsa.extractNumber(from: "unicorn32p"), 32)
        XCTAssertEqual(dsa.extractNumber(from: "uni01p"), 1)
        XCTAssertEqual(dsa.extractNumber(from: "u_929"), 929)
        XCTAssertEqual(dsa.extractNumber(from: "applepie4200"), 4200)
        XCTAssertEqual(dsa.extractNumber(from: "last00"), 0)
        XCTAssertEqual(dsa.extractNumber(from: "last_name"), 0)
    }

}
