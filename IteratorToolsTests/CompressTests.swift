//
//  CompressTests.swift
//  IteratorTools
//
//  Created by Michael Pangburn on 8/25/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import XCTest
@testable import IteratorTools


class CompressTests: XCTestCase {

    func testCompressBasic() {
        var values = compress(data: [1, 2, 3, 4, 5], selectors: [true, true, false, true, false])
        XCTAssert(values.next() == 1)
        XCTAssert(values.next() == 2)
        XCTAssert(values.next() == 4)
        XCTAssert(values.next() == nil)
    }

    func testCompressEmpty() {
        var values = compress(data: [], selectors: [true, false])
        XCTAssert(values.next() == nil)
    }

    func testCompressMoreDataThanSelectors() {
        var values = compress(data: [1, 2, 3, 4, 5], selectors: [false, true])
        XCTAssert(values.next() == 2)
        XCTAssert(values.next() == nil)
    }

    func testCompressMoreSelectorsThanData() {
        var values = compress(data: [1, 2, 3], selectors: [true, false, false, false, false])
        XCTAssert(values.next() == 1)
        XCTAssert(values.next() == nil)
    }
}
