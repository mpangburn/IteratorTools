//
//  ZipLongestTests.swift
//  IteratorTools
//
//  Created by Michael Pangburn on 8/25/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import XCTest
@testable import IteratorTools


class ZipLongestTests: XCTestCase {

    func testZipLongestMatchingLength() {
        var zipped = zipLongest([1, 2, 3], [4, 5, 6], firstFillValue: 0, secondFillValue: -1)
        XCTAssert(zipped.next()! == (1, 4))
        XCTAssert(zipped.next()! == (2, 5))
        XCTAssert(zipped.next()! == (3, 6))
        XCTAssert(zipped.next() == nil)
    }

    func testZipLongestFirstSequenceLonger() {
        var zipped = zipLongest([1, 2, 3, 4], [5, 6], firstFillValue: 0, secondFillValue: -1)
        XCTAssert(zipped.next()! == (1, 5))
        XCTAssert(zipped.next()! == (2, 6))
        XCTAssert(zipped.next()! == (3, -1))
        XCTAssert(zipped.next()! == (4, -1))
        XCTAssert(zipped.next() == nil)
    }

    func testZipLongestSecondSequenceLonger() {
        var zipped = zipLongest([1, 2], [3, 4, 5, 6], firstFillValue: 0, secondFillValue: -1)
        XCTAssert(zipped.next()! == (1, 3))
        XCTAssert(zipped.next()! == (2, 4))
        XCTAssert(zipped.next()! == (0, 5))
        XCTAssert(zipped.next()! == (0, 6))
        XCTAssert(zipped.next() == nil)
    }

    func testZipLongestEmpty() {
        var zipped = zipLongest([], [], firstFillValue: 0, secondFillValue: 1)
        XCTAssert(zipped.next() == nil)
    }
}
