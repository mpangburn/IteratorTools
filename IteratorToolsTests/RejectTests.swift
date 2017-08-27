//
//  RejectTests.swift
//  IteratorTools
//
//  Created by Michael Pangburn on 8/25/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import XCTest
@testable import IteratorTools


class RejectTests: XCTestCase {

    // MARK: - Eager computation
    
    func testRejectBasic() {
        let values = (1...10).reject { $0 % 2 == 0 }
        XCTAssert(values == [1, 3, 5, 7, 9])
    }

    func testRejectEmpty() {
        let values = [].reject { false }
        XCTAssert(values.isEmpty)
    }

    func testRejectEmptyResult() {
        let values = [1, 2, 3, 4, 5].reject { $0 < 10 }
        XCTAssert(values.isEmpty)
    }

    // MARK: - Lazy computation

    func testLazyReject() {
        var values = [1, 2, 3, 4, 5].lazy.reject { $0 % 2 == 0 }
        XCTAssert(values.next()! == 1)
        XCTAssert(values.next()! == 3)
        XCTAssert(values.next()! == 5)
        XCTAssert(values.next() == nil)
    }

    func testLazyRejectEmpty() {
        var values = [].lazy.reject { $0 }
        XCTAssert(values.next() == nil)
    }
}
