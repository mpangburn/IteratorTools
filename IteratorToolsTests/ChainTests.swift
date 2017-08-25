//
//  ChainTests.swift
//  IteratorTools
//
//  Created by Michael Pangburn on 8/25/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import XCTest
@testable import IteratorTools


class ChainTests: XCTestCase {
    
    func testChainBasic() {
        var values = chain([1, 2, 3], [4, 5, 6])
        for index in 1...6 {
            XCTAssert(values.next() == index)
        }
        XCTAssert(values.next() == nil)
    }

    func testVariedLengthChain() {
        var values = chain([], [1], [2, 3], [4, 5, 6], [7, 8, 9], [10])
        for index in 1...10 {
            XCTAssert(values.next() == index)
        }
        XCTAssert(values.next() == nil)
    }

    func testChainEmpty() {
        var values = chain([], [], [])
        XCTAssert(values.next() == nil)
    }
}
