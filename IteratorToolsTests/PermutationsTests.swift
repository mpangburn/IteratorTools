//
//  PermutationsTests.swift
//  IteratorTools
//
//  Created by Michael Pangburn on 8/27/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import XCTest
@testable import IteratorTools


class PermutationsTests: XCTestCase {

    // MARK: - Eager computation

    func testPermutationsOfThree() {
        let permutations = [1, 2, 3].permutations()
        let expectedValues = [
            [1, 2, 3], [1, 3, 2], [2, 1, 3],
            [2, 3, 1], [3, 1, 2], [3, 2, 1]
        ]
        XCTAssert(permutations.count == expectedValues.count)
        for index in expectedValues.indices {
            XCTAssert(permutations[index] == expectedValues[index])
        }
    }

    func testPermutationsOfTwo() {
        let permutations = [1, 2].permutations()
        XCTAssert(permutations.count == 2)
        XCTAssert(permutations[0] == [1, 2])
        XCTAssert(permutations[1] == [2, 1])
    }

    func testPermutationsOfOne() {
        let permutations = [1].permutations()
        XCTAssert(permutations.count == 1)
        XCTAssert(permutations[0] == [1])
    }

    func testPermutationsEmpty() {
        let permutations = [].permutations()
        XCTAssert(permutations.isEmpty)
    }

    func testPermutationsOfShorterLength() {
        let permutations = [1, 2, 3].permutations(length: 2)
        let expectedValues = [
            [1, 2], [1, 3], [2, 1],
            [2, 3], [3, 1], [3, 2]
        ]
        XCTAssert(permutations.count == expectedValues.count)
        for index in expectedValues.indices {
            XCTAssert(permutations[index] == expectedValues[index])
        }
    }

    func testPermutationsOfShorterLength2() {
        let permutations = [1, 2, 3, 4].permutations(length: 2)
        let expectedValues = [
            [1, 2], [1, 3], [1, 4], [2, 1], [2, 3], [2, 4],
            [3, 1], [3, 2], [3, 4], [4, 1], [4, 2], [4, 3]
        ]
        XCTAssert(permutations.count == expectedValues.count)
        for index in expectedValues.indices {
            XCTAssert(permutations[index] == expectedValues[index])
        }
    }

    func testPermutationsOfLongerLength() {
        let permutations = [1, 2, 3].permutations(length: 4)
        XCTAssert(permutations.isEmpty)
    }

    func testPermutationsOfLengthOne() {
        let permutations = [1, 2, 3].permutations(length: 1)
        let expectedValues = [[1], [2], [3]]
        XCTAssert(permutations.count == expectedValues.count)
        for index in expectedValues.indices {
            XCTAssert(permutations[index] == expectedValues[index])
        }
    }

    func testPermutationsOfLengthZero() {
        let permutations = [1, 2, 3].permutations(length: 0)
        XCTAssert(permutations.isEmpty)
    }

    // MARK: - Lazy computation
    
    func testLazyPermutations() {
        var permutations = [1, 2, 3].lazy.permutations()
        let expectedValues = [
            [1, 2, 3], [1, 3, 2], [2, 1, 3],
            [2, 3, 1], [3, 1, 2], [3, 2, 1]
        ]
        for value in expectedValues {
            XCTAssert(permutations.next()! == value)
        }
        XCTAssert(permutations.next() == nil)
    }

    func testLazyPermutationsEmpty() {
        var permutations = [].lazy.permutations()
        XCTAssert(permutations.next() == nil)
    }

    func testLazyPermutationsOfShorterLength() {
        var permutations = [1, 2, 3].lazy.permutations(length: 2)
        let expectedValues = [
            [1, 2], [1, 3], [2, 1],
            [2, 3], [3, 1], [3, 2]
        ]
        for value in expectedValues {
            XCTAssert(permutations.next()! == value)
        }
        XCTAssert(permutations.next() == nil)
    }

    func testLazyPermutationsOfLongerLength() {
        var permutations = [1, 2, 3].lazy.permutations(length: 4)
        XCTAssert(permutations.next() == nil)
    }

    func testLazyPermutationsOfLengthOne() {
        var permutations = [1, 2, 3].lazy.permutations(length: 1)
        let expectedValues = [[1], [2], [3]]
        for value in expectedValues {
            XCTAssert(permutations.next()! == value)
        }
        XCTAssert(permutations.next() == nil)
    }

    func testLazyPermutationsOfLengthZero() {
        var permutations = [1, 2, 3].lazy.permutations(length: 0)
        XCTAssert(permutations.next() == nil)
    }
}
