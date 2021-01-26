//
//  AlgorithmsInSwift_ArrayTests.swift
//  AlgorithmsInSwiftTests
//
//  Created by Hadi Kheyruri on 2021-01-26.
//

import XCTest
@testable import AlgorithmsInSwift

class AlgorithmsInSwift_ArrayTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testLargestAbsoluteDifference() throws {
        
        let dsa = DSA_Array()
        var arr : [Int] = [-10, -1, 5, 2, 4]
        XCTAssertEqual(dsa.largestAbsoluteDifference(arr: &arr), 15)
    }
    
    func testLargestProducts() throws {
        
        let dsa = DSA_Array()
        var arr : [Int] = [-10, -1, 5, 2, 4]
        XCTAssertEqual("\(dsa.largestProducts(arr: &arr))", "(5, -10, -1)")
    }
    
    func testCumulativeProducts() throws {
        
        let dsa = DSA_Array()
        XCTAssertEqual(dsa.cumulativeProducts(arr: [1,2,3,4,5]), [120, 60, 40, 30, 24])
        XCTAssertEqual(dsa.cumulativeProducts(arr: [3, 2, 1]), [2, 3, 6])
    }
    
    func testLongestIncreasingSubsequence() throws {
        
        let dsa = DSA_Array()
        
        let sample1 = [10, 22, 9, 33, 21, 50, 41, 60, 80]
        XCTAssertEqual(dsa.longestIncreasingSubsequence(arr: sample1), [10, 22, 33, 41, 60, 80])
        
        let sample2 = [0, 8, 4, 12, 2, 10, 6, 14, 1, 9, 5, 13, 3, 11, 7, 15]
        XCTAssertEqual(dsa.longestIncreasingSubsequence(arr: sample2), [0, 2, 6, 9, 11, 15])
    }
    
    func testSubarraySums() throws {
    
        let dsa = DSA_Array()
        XCTAssertEqual(dsa.slidingWindowMaxArray( [10, 5, 2, 7, 8, 7], k: 3), [10, 7, 8, 8])
        XCTAssertEqual(dsa.slidingWindowMaxArray( [3, 19, 11], k: 4), [19])
    }
    
    func testMaxContiguousSumSubarray() throws {
        
        let dsa = DSA_Array()
        XCTAssertEqual(dsa.maxContiguousSumSubarray([-2, -3, 4, -1, -2, 1, 5, -3]), [4, -1, -2, 1, 5])
        XCTAssertEqual(dsa.maxContiguousSumSubarray([-2, 1, -3, 4, -1, 2, 1, -5, 4]), [4, -1, 2, 1])
        XCTAssertEqual(dsa.maxContiguousSumSubarray([34, -50, 42, 14, -5, 86]), [42, 14, -5, 86])
        XCTAssertEqual(dsa.maxContiguousSumSubarray([-5, -1, -8, -9]), [-1])
        XCTAssertEqual(dsa.maxContiguousSumSubarray([-2, -3, 4, -1, -2, 1, 5, -3]), [4, -1, -2, 1, 5])
    }
    
    func testSieveOfEratosthenes() throws {
        
        let dsa = DSA_Array()
        XCTAssertEqual(dsa.sieveOfEratosthenes(n: 30), [2, 3, 5, 7, 11, 13, 17, 19, 23, 29])
    }
    
    func testMergeSort() throws {
        XCTAssertEqual([80, 20, 60, 40, 10, 30, 50, 90, 5].mergeSort(), [5, 10, 20, 30, 40, 50, 60, 80, 90])
    }
    
    func testQuickSort() throws {
        XCTAssertEqual([80, 20, 60, 40, 10, 30, 50, 90, 5].quickSort(), [5, 10, 20, 30, 40, 50, 60, 80, 90])
    }
    
    func testHeapSort() throws {
        XCTAssertEqual([80, 20, 60, 40, 10, 30, 50, 90, 5].heapSort(), [5, 10, 20, 30, 40, 50, 60, 80, 90])
    }
    
    func testMedain() throws {
        
        let sample : [Double] = [80, 20, 60, 40, 10, 30, 50, 90, 5]
        XCTAssertEqual(sample.median(), 40)
    }
    
    func testTrappedWater() throws {
        let dsa = DSA_Array()

        XCTAssertEqual(dsa.trappedWater(arr: []), 0)
        XCTAssertEqual(dsa.trappedWater(arr: [2, 1, 2]), 1)
        XCTAssertEqual(dsa.trappedWater(arr: [3, 0, 1, 3, 0, 5]), 8)
        XCTAssertEqual(dsa.trappedWater(arr: [3, 0, 2, 0, 4]), 7)
        XCTAssertEqual(dsa.trappedWater(arr: [0, 1, 0, 2, 1, 0, 1, 3, 2, 1, 2, 1]), 6)
        XCTAssertEqual(dsa.trappedWater(arr: [3, 0, 2, 0, 4]), 7)
        XCTAssertEqual(dsa.trappedWater(arr: [1, 2, 1, 3, 1, 2, 1, 4, 1, 0, 0, 2, 1, 4]), 22)
    }
    
    func testManacherPalindromicSubstring() throws {
        
        let dsa = DSA_Array()
        XCTAssertEqual(dsa.manacherPalindromicSubstring("dubootrtooz"),"ootrtoo")
        XCTAssertEqual(dsa.manacherPalindromicSubstring("praderredim"),"derred")
        XCTAssertEqual(dsa.manacherPalindromicSubstring("prade"),"")
        XCTAssertEqual(dsa.manacherPalindromicSubstring("tenet"),"tenet")
        XCTAssertEqual(dsa.manacherPalindromicSubstring("booo"),"ooo")
        XCTAssertEqual(dsa.manacherPalindromicSubstring("roose"),"oo")
    }
    
    func testReverse() throws {
        
        let dsa = DSA_Array()
        XCTAssertEqual(dsa.reverse(sentence: "you shall not pass"), "pass not shall you")
        XCTAssertEqual(dsa.reverse(sentence: "you shall not pass!"), "pass not shall you!")
        XCTAssertEqual(dsa.reverse(sentence: "hello/world:here"), "here/world:hello")
        XCTAssertEqual(dsa.reverse(sentence: "hello/world:here/"), "here/world:hello/")
        XCTAssertEqual(dsa.reverse(sentence: "hello//world:here"), "here//world:hello")
        XCTAssertEqual(dsa.reverse(sentence: "hello//world:here!!!"), "here//world:hello!!!")
        XCTAssertEqual(dsa.reverse(sentence: "hello///world:here"), "here///world:hello")
    }
    
    func testSmallestSubarrayContainingAllElements() throws {
        
        let dsa = DSA_Array()
        XCTAssertEqual(dsa.smallestSubarrayContainingAllElements([7, 5, 2, 7, 2, 7, 4, 7]), [5, 2, 7, 2, 7, 4])
        XCTAssertEqual(dsa.smallestSubarrayContainingAllElements([2, 1, 1, 3, 2, 1, 1, 3]), [1, 3, 2])
        XCTAssertEqual(dsa.smallestSubarrayContainingAllElements([7, 3, 7, 3, 1, 3, 4, 1]), [7, 3, 1, 3, 4])
        XCTAssertEqual(dsa.smallestSubarrayContainingAllElements([0, 3, 7, 5, 9, 8, 4, 1]), [0, 3, 7, 5, 9, 8, 4, 1])
        XCTAssertEqual(dsa.smallestSubarrayContainingAllElements([0,0,0,0,0,0,0,0,0,0,1,0,3]), [1, 0, 3])
    }

}
