//
//  GroupedTests.swift
//  IteratorTools
//
//  Created by Michael Pangburn on 8/25/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import XCTest
@testable import IteratorTools


class GroupedTests: XCTestCase {

    func testGroupedUnsorted() {
        var groups = (0...10).grouped { $0 % 3 }
        for index in 0...10 {
            let next = groups.next()!
            XCTAssert(next.key == index % 3)
            XCTAssert(next.elements == [index])
        }
        XCTAssert(groups.next() == nil)
    }

    func testGroupedSorted() {
        var groups = (0...10).sorted(by: { $0 % 3 < $1 % 3 }).grouped(by: { $0 % 3 })
        var next = groups.next()!
        XCTAssert(next.key == 0)
        XCTAssert(next.elements == [0, 3, 6, 9])
        next = groups.next()!
        XCTAssert(next.key == 1)
        XCTAssert(next.elements == [1, 4, 7, 10])
        next = groups.next()!
        XCTAssert(next.key == 2)
        XCTAssert(next.elements == [2, 5, 8])
        XCTAssert(groups.next() == nil)
    }

    func testGroupedBool() {
        var groups = [1, 2, 3, 4, 5].grouped { $0 > 3 }
        var next = groups.next()!
        XCTAssert(next.key == false)
        XCTAssert(next.elements == [1, 2, 3])
        next = groups.next()!
        XCTAssert(next.key == true)
        XCTAssert(next.elements == [4, 5])
        XCTAssert(groups.next() == nil)
    }

    func testGroupEmpty() {
        var groups = [].grouped(by: { 0 })
        XCTAssert(groups.next() == nil)
    }
}
