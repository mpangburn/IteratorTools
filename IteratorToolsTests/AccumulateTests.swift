//
//  AccumulateTests.swift
//  IteratorTools
//
//  Created by Michael Pangburn on 8/24/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import XCTest
@testable import IteratorTools


class AccumulateTests: XCTestCase {

    // MARK: - Eager computation

    func testAccumulateAdd() {
        let values = [1, 2, 3].accumulate(+)
        XCTAssert(values == [1, 3, 6])
    }

    func testAccumulateMultiply() {
        let values = [1, 2, 3].accumulate(*)
        XCTAssert(values == [1, 2, 6])
    }

    func testAccumulateCustom() {
        let values = ["Hello", "q ", "zWorld", ".!"].accumulate {
            $0 + String($1.characters.dropFirst())
        }
        XCTAssert(values == ["Hello", "Hello ", "Hello World", "Hello World!"])
    }

    // MARK: - Lazy computation
    
    func testLazyAccumulateAdd() {
        var accumulator = [1, 2, 3].lazy.accumulate(+)
        XCTAssert(accumulator.next() == 1)
        XCTAssert(accumulator.next() == 3)
        XCTAssert(accumulator.next() == 6)
        XCTAssert(accumulator.next() == nil)
    }

    func testLazyAccumulateMultiply() {
        var accumulator = [1, 2, 3].lazy.accumulate(*)
        XCTAssert(accumulator.next() == 1)
        XCTAssert(accumulator.next() == 2)
        XCTAssert(accumulator.next() == 6)
        XCTAssert(accumulator.next() == nil)
    }

    func testLazyAccumulateCustom() {
        var accumulator = ["Hello", "q ", "zWorld", ".!"].lazy.accumulate {
            $0 + String($1.characters.dropFirst())
        }
        XCTAssert(accumulator.next() == "Hello")
        XCTAssert(accumulator.next() == "Hello ")
        XCTAssert(accumulator.next() == "Hello World")
        XCTAssert(accumulator.next() == "Hello World!")
        XCTAssert(accumulator.next() == nil)
    }
}
