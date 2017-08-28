//
//  CombinationsTests.swift
//  IteratorTools
//
//  Created by Michael Pangburn on 8/28/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import XCTest
@testable import IteratorTools


// MARK: - Combinations without replacement tests

class CombinationsTests: XCTestCase {
    
    // MARK: - Eager computation

    func testCombinationsOfLengthTwo() {
        let combinations = [1, 2, 3].combinations(length: 2)
        let expectedValues = [[1, 2], [1, 3], [2, 3]]
        XCTAssert(combinations.count == expectedValues.count)
        for index in expectedValues.indices {
            XCTAssert(combinations[index] == expectedValues[index])
        }
    }

    func testMoreCombinationsOfLengthTwo() {
        let combinations = [1, 2, 3, 4].combinations(length: 2)
        let expectedValues = [
            [1, 2], [1, 3], [1, 4],
            [2, 3], [2, 4], [3, 4]
        ]
        XCTAssert(combinations.count == expectedValues.count)
        for index in expectedValues.indices {
            XCTAssert(combinations[index] == expectedValues[index])
        }
    }

    func testCombinationsOfLengthOne() {
        let combinations = [1, 2, 3].combinations(length: 1)
        let expectedValues = [[1], [2], [3]]
        XCTAssert(combinations.count == expectedValues.count)
        for index in expectedValues.indices {
            XCTAssert(combinations[index] == expectedValues[index])
        }
    }

    func testCombinationsOfLengthZero() {
        let combinations = [1, 2, 3].combinations(length: 0)
        XCTAssert(combinations.isEmpty)
    }

    func testCombinationsOfEqualLength() {
        let combinations = [1, 2, 3].combinations(length: 3)
        XCTAssert(combinations.count == 1)
        XCTAssert(combinations[0] == [1, 2, 3])
    }

    func testCombinationsOfLongerLength() {
        let combinations = [1, 2, 3].combinations(length: 4)
        XCTAssert(combinations.isEmpty)
    }

    func testCombinationsEmpty() {
        let combinations = [].combinations(length: 1)
        XCTAssert(combinations.isEmpty)
    }

    // MARK: - Lazy computation

    func testLazyCombinationsOfLengthTwo() {
        var combinations = [1, 2, 3].lazy.combinations(length: 2)
        let expectedValues = [[1, 2], [1, 3], [2, 3]]
        for index in expectedValues.indices {
            XCTAssert(combinations.next()! == expectedValues[index])
        }
        XCTAssert(combinations.next() == nil)
    }

    func testMoreLazyCombinationsOfLengthTwo() {
        var combinations = [1, 2, 3, 4].lazy.combinations(length: 2)
        let expectedValues = [
            [1, 2], [1, 3], [1, 4],
            [2, 3], [2, 4], [3, 4]
        ]
        for index in expectedValues.indices {
            XCTAssert(combinations.next()! == expectedValues[index])
        }
        XCTAssert(combinations.next() == nil)
    }

    func testLazyCombinationsOfLengthOne() {
        var combinations = [1, 2, 3].lazy.combinations(length: 1)
        let expectedValues = [[1], [2], [3]]
        for index in expectedValues.indices {
            XCTAssert(combinations.next()! == expectedValues[index])
        }
        XCTAssert(combinations.next() == nil)
    }

    func testLazyCombinationsOfLengthZero() {
        var combinations = [1, 2, 3].lazy.combinations(length: 0)
        XCTAssert(combinations.next() == nil)
    }

    func testLazyCombinationsOfEqualLength() {
        var combinations = [1, 2, 3].lazy.combinations(length: 3)
        XCTAssert(combinations.next()! == [1, 2, 3])
        XCTAssert(combinations.next() == nil)
    }

    func testLazyCombinationsOfLongerLength() {
        var combinations = [1, 2, 3].lazy.combinations(length: 4)
        XCTAssert(combinations.next() == nil)
    }

    func testLazyCombinationsEmpty() {
        var combinations = [].lazy.combinations(length: 1)
        XCTAssert(combinations.next() == nil)
    }
}


// MARK: - Combinations with replacement tests

class CombinationsWithReplacementTests: XCTestCase {

    // MARK: - Eager computation

    func testCombinationsOfLengthTwoWithReplacement() {
        let combinations = [1, 2, 3].combinationsWithReplacement(length: 2)
        let expectedValues = [
            [1, 1], [1, 2], [1, 3],
            [2, 2], [2, 3], [3, 3]
        ]
        XCTAssert(combinations.count == expectedValues.count)
        for index in expectedValues.indices {
            XCTAssert(combinations[index] == expectedValues[index])
        }
    }

    func testCombinationsOfEqualLengthWithReplacement() {
        let combinations = [1, 2, 3].combinationsWithReplacement(length: 3)
        let expectedValues = [
            [1, 1, 1], [1, 1, 2], [1, 1, 3], [1, 2, 2], [1, 2, 3],
            [1, 3, 3], [2, 2, 2], [2, 2, 3], [2, 3, 3], [3, 3, 3]
        ]
        XCTAssert(combinations.count == expectedValues.count)
        for index in expectedValues.indices {
            XCTAssert(combinations[index] == expectedValues[index])
        }
    }

    func testCombinationsOfLongerLengthWithReplacement() {
        let combinations = [1, 2, 3].combinationsWithReplacement(length: 4)
        let expectedValues = [
            [1, 1, 1, 1], [1, 1, 1, 2], [1, 1, 1, 3], [1, 1, 2, 2], [1, 1, 2, 3],
            [1, 1, 3, 3], [1, 2, 2, 2], [1, 2, 2, 3], [1, 2, 3, 3], [1, 3, 3, 3],
            [2, 2, 2, 2], [2, 2, 2, 3], [2, 2, 3, 3], [2, 3, 3, 3], [3, 3, 3, 3]
        ]
        XCTAssert(combinations.count == expectedValues.count)
        for index in expectedValues.indices {
            XCTAssert(combinations[index] == expectedValues[index])
        }
    }

    func testCombinationsOfLengthOneWithReplacement() {
        let combinations = [1, 2, 3].combinationsWithReplacement(length: 1)
        let expectedValues = [[1], [2], [3]]
        XCTAssert(combinations.count == expectedValues.count)
        for index in expectedValues.indices {
            XCTAssert(combinations[index] == expectedValues[index])
        }
    }

    func testCombinationsOfLengthZeroWithReplacement() {
        let combinations = [1, 2, 3].combinationsWithReplacement(length: 0)
        XCTAssert(combinations.isEmpty)
    }

    func testCombinationsWithReplacementEmpty() {
        let combinations = [].combinationsWithReplacement(length: 1)
        XCTAssert(combinations.isEmpty)
    }

    // MARK: - Lazy computation

    func testLazyCombinationsOfLengthTwoWithReplacement() {
        var combinations = [1, 2, 3].lazy.combinationsWithReplacement(length: 2)
        let expectedValues = [
            [1, 1], [1, 2], [1, 3],
            [2, 2], [2, 3], [3, 3]
        ]
        for index in expectedValues.indices {
            XCTAssert(combinations.next()! == expectedValues[index])
        }
        XCTAssert(combinations.next() == nil)
    }

    func testLazyCombinationsOfEqualLengthWithReplacement() {
        var combinations = [1, 2, 3].lazy.combinationsWithReplacement(length: 3)
        let expectedValues = [
            [1, 1, 1], [1, 1, 2], [1, 1, 3], [1, 2, 2], [1, 2, 3],
            [1, 3, 3], [2, 2, 2], [2, 2, 3], [2, 3, 3], [3, 3, 3]
        ]
        for index in expectedValues.indices {
            XCTAssert(combinations.next()! == expectedValues[index])
        }
        XCTAssert(combinations.next() == nil)
    }

    func testLazyCombinationsOfLongerLengthWithReplacement() {
        var combinations = [1, 2, 3].lazy.combinationsWithReplacement(length: 4)
        let expectedValues = [
            [1, 1, 1, 1], [1, 1, 1, 2], [1, 1, 1, 3], [1, 1, 2, 2], [1, 1, 2, 3],
            [1, 1, 3, 3], [1, 2, 2, 2], [1, 2, 2, 3], [1, 2, 3, 3], [1, 3, 3, 3],
            [2, 2, 2, 2], [2, 2, 2, 3], [2, 2, 3, 3], [2, 3, 3, 3], [3, 3, 3, 3]
        ]
        for index in expectedValues.indices {
            XCTAssert(combinations.next()! == expectedValues[index])
        }
        XCTAssert(combinations.next() == nil)
    }

    func testLazyCombinationsOfLengthOneWithReplacement() {
        var combinations = [1, 2, 3].lazy.combinationsWithReplacement(length: 1)
        let expectedValues = [[1], [2], [3]]
        for index in expectedValues.indices {
            XCTAssert(combinations.next()! == expectedValues[index])
        }
        XCTAssert(combinations.next() == nil)
    }

    func testLazyCombinationsOfLengthZeroWithReplacement() {
        var combinations = [1, 2, 3].lazy.combinationsWithReplacement(length: 0)
        XCTAssert(combinations.next() == nil)
    }

    func testLazyCombinationsWithReplacementEmpty() {
        var combinations = [].lazy.combinationsWithReplacement(length: 1)
        XCTAssert(combinations.next() == nil)
    }
}
