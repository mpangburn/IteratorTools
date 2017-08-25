//
//  TeeTests.swift
//  IteratorTools
//
//  Created by Michael Pangburn on 8/25/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import XCTest
@testable import IteratorTools


class TeeTests: XCTestCase {

    func testTeeBasic() {
        let iterators = [1, 2, 3].tee(3)
        XCTAssert(iterators.count == 3)
        for var iterator in iterators {
            XCTAssert(iterator.next() == 1)
            XCTAssert(iterator.next() == 2)
            XCTAssert(iterator.next() == 3)
            XCTAssert(iterator.next() == nil)
        }
    }

    func testTeeEmpty() {
        let iterators = [].tee(5)
        XCTAssert(iterators.count == 5)
        for var iterator in iterators {
            XCTAssert(iterator.next() == nil)
        }
    }

    func testTeeZero() {
        let iterators = [1, 2, 3].tee(0)
        XCTAssert(iterators.count == 0)
    }
}
