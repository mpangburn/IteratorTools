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

    func testPermutations() {
        let permutations = [1, 2, 3].permutations()
        let expectedValues = [
            [1, 2, 3],
            [2, 1, 3],
            [3, 1, 2],
            [1, 3, 2],
            [2, 3, 1],
            [3, 2, 1]
        ]
        XCTAssert(permutations.count == expectedValues.count)
        for index in 0..<expectedValues.count {
            XCTAssert(permutations[index] == expectedValues[index])
        }
    }

    func testPermutationsEmpty() {
        let permutations = [].permutations()
        XCTAssert(permutations.isEmpty)
    }

    func testPermutationsSingleValue() {
        let permutations = [1].permutations()
        XCTAssert(permutations.count == 1)
        XCTAssert(permutations[0] == [1])
    }

    // MARK: - Lazy computation
    
    func testLazyPermutations() {
        var permutations = [1, 2, 3].lazy.permutations()
        let expectedValues = [
            [1, 2, 3],
            [2, 1, 3],
            [3, 1, 2],
            [1, 3, 2],
            [2, 3, 1],
            [3, 2, 1]
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
}
