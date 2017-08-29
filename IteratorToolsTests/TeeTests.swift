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

    // MARK: - Eager computation

    func testTeeBasic() {
        let iterators = [1, 2, 3].tee()
        XCTAssert(iterators.count == 2)
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
        XCTAssert(iterators.isEmpty)
    }

    // MARK: - Lazy computation

    func testLazyTeeBasic() {
        var iterators = [1, 2, 3].lazy.tee(3)
        for _ in 1...3 {
            var iterator = iterators.next()!
            XCTAssert(iterator.next() == 1)
            XCTAssert(iterator.next() == 2)
            XCTAssert(iterator.next() == 3)
            XCTAssert(iterator.next() == nil)
        }
        XCTAssert(iterators.next() == nil)
    }

    func testLazyTeeEmpty() {
        var iterators = [].lazy.tee(5)
        for _ in 1...5 {
            var iterator = iterators.next()!
            XCTAssert(iterator.next() == nil)
        }
        XCTAssert(iterators.next() == nil)
    }

    func testLazyTeeZero() {
        var iterators = [1, 2, 3].lazy.tee(0)
        XCTAssert(iterators.next() == nil)
    }
}
