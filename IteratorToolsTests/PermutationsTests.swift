//
//  PermutationsTests.swift
//  IteratorTools
//
//  Created by Michael Pangburn on 8/27/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import XCTest
@testable import IteratorTools


// MARK: Permutations without Repetition tests

class PermutationsTests: XCTestCase {

    // MARK: - Eager computation

    func testPermutationsOfThree() {
        let permutations = [1, 2, 3].permutations(repeatingElements: false)
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
        let permutations = [1, 2].permutations(repeatingElements: false)
        XCTAssert(permutations.count == 2)
        XCTAssert(permutations[0] == [1, 2])
        XCTAssert(permutations[1] == [2, 1])
    }

    func testPermutationsOfOne() {
        let permutations = [1].permutations(repeatingElements: false)
        XCTAssert(permutations.count == 1)
        XCTAssert(permutations[0] == [1])
    }

    func testPermutationsEmpty() {
        let permutations = [].permutations(repeatingElements: false)
        XCTAssert(permutations.isEmpty)
    }

    func testPermutationsOfShorterLength() {
        let permutations = [1, 2, 3].permutations(length: 2, repeatingElements: false)
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
        let permutations = [1, 2, 3, 4].permutations(length: 2, repeatingElements: false)
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
        let permutations = [1, 2, 3].permutations(length: 4, repeatingElements: false)
        XCTAssert(permutations.isEmpty)
    }

    func testPermutationsOfLengthOne() {
        let permutations = [1, 2, 3].permutations(length: 1, repeatingElements: false)
        let expectedValues = [[1], [2], [3]]
        XCTAssert(permutations.count == expectedValues.count)
        for index in expectedValues.indices {
            XCTAssert(permutations[index] == expectedValues[index])
        }
    }

    func testPermutationsOfLengthZero() {
        let permutations = [1, 2, 3].permutations(length: 0, repeatingElements: false)
        XCTAssert(permutations.isEmpty)
    }

    // MARK: - Lazy computation
    
    func testLazyPermutations() {
        var permutations = [1, 2, 3].lazy.permutations(repeatingElements: false)
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
        var permutations = [].lazy.permutations(repeatingElements: false)
        XCTAssert(permutations.next() == nil)
    }

    func testLazyPermutationsOfShorterLength() {
        var permutations = [1, 2, 3].lazy.permutations(length: 2, repeatingElements: false)
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
        var permutations = [1, 2, 3].lazy.permutations(length: 4, repeatingElements: false)
        XCTAssert(permutations.next() == nil)
    }

    func testLazyPermutationsOfLengthOne() {
        var permutations = [1, 2, 3].lazy.permutations(length: 1, repeatingElements: false)
        let expectedValues = [[1], [2], [3]]
        for value in expectedValues {
            XCTAssert(permutations.next()! == value)
        }
        XCTAssert(permutations.next() == nil)
    }

    func testLazyPermutationsOfLengthZero() {
        var permutations = [1, 2, 3].lazy.permutations(length: 0, repeatingElements: false)
        XCTAssert(permutations.next() == nil)
    }
}


// MARK: Permutations with repetition tests

class PermutationsWithRepetitionTests: XCTestCase {

    // MARK: - Eager computation

    func testPermutationssOfLengthTwoWithRepetition() {
        let permutations = [1, 2, 3].permutations(length: 2, repeatingElements: true)
        let expectedValues = [
            [1, 1], [1, 2], [1, 3],
            [2, 1], [2, 2], [2, 3],
            [3, 1], [3, 2], [3, 3]
        ]
        XCTAssert(permutations.count == expectedValues.count)
        for index in expectedValues.indices {
            XCTAssert(permutations[index] == expectedValues[index])
        }
    }

    func testPermutationsOfEqualLengthWithRepetition() {
        let permutations = [1, 2, 3].permutations(repeatingElements: true)
        let expectedValues = [
            [1, 1, 1], [1, 1, 2], [1, 1, 3],
            [1, 2, 1], [1, 2, 2], [1, 2, 3],
            [1, 3, 1], [1, 3, 2], [1, 3, 3],
            [2, 1, 1], [2, 1, 2], [2, 1, 3],
            [2, 2, 1], [2, 2, 2], [2, 2, 3],
            [2, 3, 1], [2, 3, 2], [2, 3, 3],
            [3, 1, 1], [3, 1, 2], [3, 1, 3],
            [3, 2, 1], [3, 2, 2], [3, 2, 3],
            [3, 3, 1], [3, 3, 2], [3, 3, 3]
        ]
        XCTAssert(permutations.count == expectedValues.count)
        for index in expectedValues.indices {
            XCTAssert(permutations[index] == expectedValues[index])
        }
    }

    func testPermutationsOfLongerLengthWithRepetition() {
        let permutations = [1, 2].permutations(length: 3, repeatingElements: true)
        let expectedValues = [
            [1, 1, 1], [1, 1, 2],
            [1, 2, 1], [1, 2, 2],
            [2, 1, 1], [2, 1, 2],
            [2, 2, 1], [2, 2, 2]
        ]
        XCTAssert(permutations.count == expectedValues.count)
        for index in expectedValues.indices {
            XCTAssert(permutations[index] == expectedValues[index])
        }
    }

    func testPermutationsOfLengthOneWithRepetition() {
        let permutations = [1, 2, 3].permutations(length: 1, repeatingElements: true)
        let expectedValues = [[1], [2], [3]]
        XCTAssert(permutations.count == expectedValues.count)
        for index in expectedValues.indices {
            XCTAssert(permutations[index] == expectedValues[index])
        }
    }

    func testPermutationsOfLengthZeroWithRepetition() {
        let permutations = [1, 2, 3].permutations(length: 0, repeatingElements: true)
        XCTAssert(permutations.isEmpty)
    }

    func testPermutationsWithRepetitionEmpty() {
        let permutations = [].permutations(length: 1, repeatingElements: true)
        XCTAssert(permutations.isEmpty)
    }

    // MARK: - Lazy computation

    func testLazyPermutationsOfLengthTwoWithRepetition() {
        var permutations = [1, 2, 3].lazy.permutations(length: 2, repeatingElements: true)
        let expectedValues = [
            [1, 1], [1, 2], [1, 3],
            [2, 1], [2, 2], [2, 3],
            [3, 1], [3, 2], [3, 3]
        ]
        for index in expectedValues.indices {
            XCTAssert(permutations.next()! == expectedValues[index])
        }
        XCTAssert(permutations.next() == nil)
    }

    func testLazyPermutationsOfEqualLengthWithRepetition() {
        var permutations = [1, 2, 3].lazy.permutations(repeatingElements: true)
        let expectedValues = [
            [1, 1, 1], [1, 1, 2], [1, 1, 3],
            [1, 2, 1], [1, 2, 2], [1, 2, 3],
            [1, 3, 1], [1, 3, 2], [1, 3, 3],
            [2, 1, 1], [2, 1, 2], [2, 1, 3],
            [2, 2, 1], [2, 2, 2], [2, 2, 3],
            [2, 3, 1], [2, 3, 2], [2, 3, 3],
            [3, 1, 1], [3, 1, 2], [3, 1, 3],
            [3, 2, 1], [3, 2, 2], [3, 2, 3],
            [3, 3, 1], [3, 3, 2], [3, 3, 3]
        ]
        for index in expectedValues.indices {
            XCTAssert(permutations.next()! == expectedValues[index])
        }
        XCTAssert(permutations.next() == nil)
    }

    func testLazyPermutationsOfLongerLengthWithRepetition() {
        var permutations = [1, 2].lazy.permutations(length: 3, repeatingElements: true)
        let expectedValues = [
            [1, 1, 1], [1, 1, 2],
            [1, 2, 1], [1, 2, 2],
            [2, 1, 1], [2, 1, 2],
            [2, 2, 1], [2, 2, 2]
        ]
        for index in expectedValues.indices {
            XCTAssert(permutations.next()! == expectedValues[index])
        }
        XCTAssert(permutations.next() == nil)
    }

    func testLazyPermutationsOfLengthOneWithRepetition() {
        var permutations = [1, 2, 3].lazy.permutations(length: 1, repeatingElements: true)
        let expectedValues = [[1], [2], [3]]
        for index in expectedValues.indices {
            XCTAssert(permutations.next()! == expectedValues[index])
        }
        XCTAssert(permutations.next() == nil)
    }

    func testLazyPermutationsOfLengthZeroWithRepetition() {
        var permutations = [1, 2, 3].lazy.permutations(length: 0, repeatingElements: true)
        XCTAssert(permutations.next() == nil)
    }

    func testLazyPermutationsWithRepetitionEmpty() {
        var permutations = [].lazy.permutations(length: 1, repeatingElements: true)
        XCTAssert(permutations.next() == nil)
    }
}


