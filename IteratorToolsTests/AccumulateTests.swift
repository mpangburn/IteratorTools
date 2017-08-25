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
    
    func testAccumulateAdd() {
        var accumulator = [1, 2, 3].accumulate(+)
        XCTAssert(accumulator.next() == 1)
        XCTAssert(accumulator.next() == 3)
        XCTAssert(accumulator.next() == 6)
        XCTAssert(accumulator.next() == nil)
    }

    func testAccumulateMultiply() {
        var accumulator = [1, 2, 3].accumulate(*)
        XCTAssert(accumulator.next() == 1)
        XCTAssert(accumulator.next() == 2)
        XCTAssert(accumulator.next() == 6)
        XCTAssert(accumulator.next() == nil)
    }

    func testAccumulateCustom() {
        var accumulator = ["Hello", "q ", "zWorld", ".!"].accumulate {
            $0 + String($1.characters.dropFirst())
        }
        XCTAssert(accumulator.next() == "Hello")
        XCTAssert(accumulator.next() == "Hello ")
        XCTAssert(accumulator.next() == "Hello World")
        XCTAssert(accumulator.next() == "Hello World!")
        XCTAssert(accumulator.next() == nil)
    }
}
