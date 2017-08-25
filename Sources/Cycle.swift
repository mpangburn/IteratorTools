//
//  Cycle.swift
//  IteratorTools
//
//  Created by Michael Pangburn on 8/24/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import Foundation


public extension Sequence {

    /**
     Returns an iterator cycling infinitely through the sequence.
     ```
     [1, 2, 3].cycle()
     // 1, 2, 3, 1, 2, 3, 1, ...
     ```
     - Returns: An iterator cycling infinitely through the sequence.
     */
    func cycle() -> CycleIterator<Self> {
        return CycleIterator(sequence: self)
    }

    /**
     Returns an iterator of `times` cycles of self.
     ```
     [1, 2, 3].cycle(times: 2)
     // 1, 2, 3, 1, 2, 3
     ```
     - Parameter times: The number of times to cycle through the sequence.
     - Returns: An iterator of `times` cycles of self.
     */
    func cycle(times: Int) -> CycleIterator<Self> {
        return CycleIterator(sequence: self, times: times)
    }
}


/// An iterator for cycling through a collection. See the `cycle` and `cycle(times:)` Sequence methods.
public struct CycleIterator<S: Sequence>: IteratorProtocol, LazySequenceProtocol {

    let sequence: S
    var iterator: S.Iterator
    var times: Int

    init(sequence: S, times: Int = -1) {
        self.sequence = sequence
        self.iterator = sequence.makeIterator()
        self.times = times
    }

    public mutating func next() -> S.Iterator.Element? {
        guard times != 0 else {
            return nil
        }

        if let next = iterator.next() {
            return next
        }

        times -= 1
        guard times != 0 else {
            return nil
        }

        iterator = sequence.makeIterator()
        return iterator.next()
    }
}
