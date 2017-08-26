//
//  RepeaterTests.swift
//  IteratorTools
//
//  Created by Michael Pangburn on 8/24/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import XCTest
@testable import IteratorTools


class RepeaterTests: XCTestCase {
    
    func testInfiniteRepeater() {
        var values = repeater(value: 0)
        for _ in 0...100 {
            XCTAssert(values.next() == 0)
        }
    }

    func testFiniteRepeater() {
        var values = repeater(value: 0, times: 5)
        for _ in 0...4 {
            XCTAssert(values.next() == 0)
        }
        XCTAssert(values.next() == nil)
    }

    func testSingleRepeater() {
        var values = repeater(value: 0, times: 1)
        XCTAssert(values.next() == 0)
        XCTAssert(values.next() == nil)
    }

    func testZeroRepeater() {
        var values = repeater(value: 0, times: 0)
        XCTAssert(values.next() == nil)
    }
}
