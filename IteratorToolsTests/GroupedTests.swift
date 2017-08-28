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

    // MARK: - Eager computation

    func testGroupedUnsorted() {
        let range = 0...10
        let groups = range.grouped { $0 % 3 }
        XCTAssert(groups.count == range.count)
        for index in groups.indices {
            let group = groups[index]
            XCTAssert(group.key == index % 3)
            XCTAssert(group .elements == [index])
        }
    }

    func testGroupedSorted() {
        let groups = (0...10).sorted(by: { $0 % 3 < $1 % 3 }).grouped(by: { $0 % 3 })
        let keys = [0, 1, 2]
        let elements = [[0, 3, 6, 9], [1, 4, 7, 10], [2, 5, 8]]
        XCTAssert(groups.count == keys.count)
        for index in groups.indices {
            XCTAssert(groups[index].key == keys[index])
            XCTAssert(groups[index].elements == elements[index])
        }
    }

    func testGroupedBool() {
        let groups = [1, 2, 3, 4, 5].grouped { $0 > 3 }
        let keys = [false, true]
        let elements = [[1, 2, 3], [4, 5]]
        XCTAssert(groups.count == keys.count)
        for index in groups.indices {
            XCTAssert(groups[index].key == keys[index])
            XCTAssert(groups[index].elements == elements[index])
        }
    }

    func testGroupEmpty() {
        let groups = [].grouped(by: { 0 })
        XCTAssert(groups.isEmpty)
    }

    // MARK: - Lazy computation

    func testLazyGroupedUnsorted() {
        var groups = (0...10).lazy.grouped { $0 % 3 }
        for index in 0...10 {
            let next = groups.next()!
            XCTAssert(next.key == index % 3)
            XCTAssert(next.elements == [index])
        }
        XCTAssert(groups.next() == nil)
    }

    func testLazyGroupedSorted() {
        var groups = (0...10).sorted(by: { $0 % 3 < $1 % 3 }).lazy.grouped(by: { $0 % 3 })
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

    func testLazyGroupedBool() {
        var groups = [1, 2, 3, 4, 5].lazy.grouped { $0 > 3 }
        var next = groups.next()!
        XCTAssert(next.key == false)
        XCTAssert(next.elements == [1, 2, 3])
        next = groups.next()!
        XCTAssert(next.key == true)
        XCTAssert(next.elements == [4, 5])
        XCTAssert(groups.next() == nil)
    }

    func testLazyGroupEmpty() {
        var groups = [].lazy.grouped(by: { 0 })
        XCTAssert(groups.next() == nil)
    }
}
