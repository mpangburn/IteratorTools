//
//  ProductTests.swift
//  IteratorTools
//
//  Created by Michael Pangburn on 8/26/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import XCTest
@testable import IteratorTools


class ProductTests: XCTestCase {

    // MARK: - SingleTypeCartesianProductIterator tests

    func testSingleTypeProductEqualLength() {
        var values = product(

            [1, 2, 3], [4, 5, 6], [7, 8, 9])
        for firstValue in 1...3 {
            for secondValue in 4...6 {
                for thirdValue in 7...9 {
                    XCTAssert(values.next()! == [firstValue, secondValue, thirdValue])
                }
            }
        }
        XCTAssert(values.next() == nil)
    }

    func testSingleTypeProductUnequalLength() {
        var values = product([1], [2, 3], [4, 5, 6])
        for firstValue in 1...1 {
            for secondValue in 2...3 {
                for thirdValue in 4...6 {
                    XCTAssert(values.next()! == [firstValue, secondValue, thirdValue])
                }
            }
        }
        XCTAssert(values.next() == nil)
    }

    func testSingleTypeProductUnequalLength2() {
        var values = product([1, 2, 3], [4], [5, 6], [7, 8, 9])
        for firstValue in 1...3 {
            for secondValue in 4...4 {
                for thirdValue in 5...6 {
                    for fourthValue in 7...9 {
                        XCTAssert(values.next()! == [firstValue, secondValue, thirdValue, fourthValue])
                    }
                }
            }
        }
        XCTAssert(values.next() == nil)
    }

    func testSingleTypeProductSingleSequence() {
        var values = product([1, 2, 3])
        XCTAssert(values.next()! == [1])
        XCTAssert(values.next()! == [2])
        XCTAssert(values.next()! == [3])
        XCTAssert(values.next() == nil)
    }

    func testSingleTypeProductFirstSequenceEmpty() {
        var values = product([], [1, 2], [3, 4, 5])
        XCTAssert(values.next() == nil)
    }

    func testSingleTypeProductMiddleSequenceEmpty() {
        var values = product([1], [], [2, 3])
        XCTAssert(values.next() == nil)
    }

    func testSingleTypeProductLastSequenceEmpty() {
        var values = product([1], [2, 3, 4], [])
        XCTAssert(values.next() == nil)
    }

    func testSingleTypeProductAllSequencesEmpty() {
        var values = product([], [], [], [], [])
        XCTAssert(values.next() == nil)
    }

    func testSingleTypeProductRepeated() {
        var values = product([1, 2, 3], repeated: 2)
        for firstValue in 1...3 {
            for secondValue in 1...3 {
                XCTAssert(values.next()! == [firstValue, secondValue])
            }
        }
        XCTAssert(values.next() == nil)
    }

    func testSingleTypeProductRepeatedOnce() {
        var values = product([1, 2, 3], repeated: 1)
        XCTAssert(values.next()! == [1])
        XCTAssert(values.next()! == [2])
        XCTAssert(values.next()! == [3])
        XCTAssert(values.next() == nil)
    }

    // MARK: - MixedTypeCartesianProductIterator tests
    
    func testMixedTypeProductEqualLength() {
        var values = mixedProduct([1, 2, 3], ["a", "b", "c"])
        for firstValue in 1...3 {
            for secondValue in ["a", "b", "c"] {
                XCTAssert(values.next()! == (firstValue, secondValue))
            }
        }
        XCTAssert(values.next() == nil)
    }

    func testMixedTypeProductLongerFirstSequence() {
        var values = mixedProduct([1, 2, 3, 4], [5, 6])
        for firstValue in 1...4 {
            for secondValue in 5...6 {
                XCTAssert(values.next()! == (firstValue, secondValue))
            }
        }
        XCTAssert(values.next() == nil)
    }

    func testMixedTypeProductLongerSecondSequence() {
        var values = mixedProduct([1, 2], [3, 4, 5, 6])
        for firstValue in 1...2 {
            for secondValue in 3...6 {
                XCTAssert(values.next()! == (firstValue, secondValue))
            }
        }
        XCTAssert(values.next() == nil)
    }

    func testMixedTypeProductEmptyFirstSequence() {
        var values = mixedProduct([], [3, 4, 5])
        XCTAssert(values.next() == nil)
    }

    func testMixedTypeProductEmptySecondSequence() {
        var values = mixedProduct([1, 2, 3], [])
        XCTAssert(values.next() == nil)
    }

    func testMixedTypeProductTwoEmptySequences() {
        var values = mixedProduct([], [])
        XCTAssert(values.next() == nil)
    }

    func testMixedTypeProductAvoidStackOverflow() {
        var values = mixedProduct(0...100_000, [])
        XCTAssert(values.next() == nil)
    }
}
