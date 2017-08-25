//
//  CycleTests.swift
//  IteratorTools
//
//  Created by Michael Pangburn on 8/24/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import XCTest
@testable import IteratorTools


class CycleTests: XCTestCase {

    func testInfiniteCycle() {
        var cycleIterator = [1, 2, 3].cycle()
        for _ in 0...100 {
            XCTAssert(cycleIterator.next() == 1)
            XCTAssert(cycleIterator.next() == 2)
            XCTAssert(cycleIterator.next() == 3)
        }
        XCTAssert(cycleIterator.next() == 1)
    }

    func testEmptyInfiniteCycle() {
        var cycleIterator = [].cycle()
        XCTAssert(cycleIterator.next() == nil)
    }

    func testLazyCycleZeroTimes() {
        var cycleIterator = [1, 2, 3].lazy.cycle(times: 0)
        XCTAssert(cycleIterator.next() == nil)
    }

    func testLazyCycle() {
        var cycleIterator = [1, 2, 3].lazy.cycle(times: 3)
        for _ in 0...2 {
            XCTAssert(cycleIterator.next() == 1)
            XCTAssert(cycleIterator.next() == 2)
            XCTAssert(cycleIterator.next() == 3)
        }
        XCTAssert(cycleIterator.next() == nil)
    }
}
