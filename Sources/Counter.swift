//
//  Counter.swift
//  IteratorTools
//
//  Created by Michael Pangburn on 8/24/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import Foundation


/**
 Returns an iterator beginning at `start` and incrementing by `step`.
 ```
 let values = counter(start: 1, step: 2)
 // 1, 3, 5, 7, 9, ...
 ```
 - Parameters:
    - start: The starting value for the counter.
    - step: The value by which to increment.
 - Returns: An iterator beginning at `start` and incrementing by `step`.
 */
public func counter(start: Double, step: Double = 1) -> Counter {
    return Counter(start: start, step: step)
}


/// An iterator that functions as a simple incremental counter. See `counter(start:step:)`
public struct Counter: IteratorProtocol, LazySequenceProtocol {

    var start: Double
    let step: Double

    init(start: Double, step: Double) {
        self.start = start
        self.step = step
    }

    public mutating func next() -> Double? {
        defer { start += step }
        return start
    }
}
