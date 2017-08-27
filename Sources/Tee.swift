//
//  Tee.swift
//  IteratorTools
//
//  Created by Michael Pangburn on 8/25/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import Foundation


public extension Sequence {

    /**
     Returns `n` independent iterators from the sequence.
     - Parameter n: The number of iterators to produce.
     - Returns: `n` independent iterators from the sequence.
     */
    func tee(_ n: Int) -> [Iterator] {
        return Array(repeating: makeIterator(), count: n)
    }
}
