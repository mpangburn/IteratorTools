//
//  CounterTests.swift
//  IteratorTools
//
//  Created by Michael Pangburn on 8/24/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import XCTest
@testable import IteratorTools


class CounterTests: XCTestCase {

    func testCounterBasic() {
        var values = counter(start: 0)
        XCTAssert(values.start == 0)
        XCTAssert(values.step == 1)
        XCTAssert(values.next() == 0)
        XCTAssert(values.start == 1)
        for index in 1...100 {
            XCTAssert(values.next() == Double(index))
        }
    }

    func testStepOfTwo() {
        var values = counter(start: 0, step: 2)
        for index in 0...100 {
            XCTAssert(values.next() == Double(index * 2))
        }
    }

    func testNegativeStep() {
        var values = counter(start: 0, step: -1)
        for index in 0...100 {
            XCTAssert(values.next() == Double(-index))
        }
    }

    func testLazyMap() {
        let values = counter(start: 0).map { $0 }
        for value in values {
            if value == 100 {
                break
            }
        }
    }
}
