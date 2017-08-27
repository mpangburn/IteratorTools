//
//  Permutations.swift
//  IteratorTools
//
//  Created by Michael Pangburn on 8/27/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import Foundation


public extension Sequence {

    /**
     Returns an array containing the permutations of elements in the sequence using [Heap's algorithm]( https://en.wikipedia.org/wiki/Heap%27s_algorithm ).
     ```
     let values = [1, 2, 3].permutations()
     // [1, 2, 3], [2, 1, 3], [3, 1, 2], [1, 3, 2], [2, 3, 1], [3, 2, 1]
     ```
     - Returns: An array containing the permutations of elements in the sequence.
     */
    public func permutations() -> [[Iterator.Element]] {
        return Array(PermutationIterator(sequence: self))
    }
}


public extension LazySequenceProtocol {

    /**
     Returns an iterator that returns the permutations of elements in the sequence using [Heap's algorithm]( https://en.wikipedia.org/wiki/Heap%27s_algorithm ).
     ```
     let values = [1, 2, 3].permutations()
     // [1, 2, 3], [2, 1, 3], [3, 1, 2], [1, 3, 2], [2, 3, 1], [3, 2, 1]
     ```
     - Returns: An iterator that returns the permutations of elements in the sequence.
     */
    public func permutations() -> PermutationIterator<Self> {
        return PermutationIterator(sequence: self)
    }
}


/// An iterator that returns the permutations of elements in a sequence. See the `permutations` Sequence and LazySequenceProtocol methods.
public struct PermutationIterator<S: Sequence>: IteratorProtocol, Sequence {

    var values: [S.Iterator.Element]
    var counts: [Int]
    var currentIndex: Int = 0
    var hasReturnedFirst = false

    init(sequence: S) {
        self.values = Array(sequence)
        self.counts = Array(repeating: 0, count: values.count)
    }

    public mutating func next() -> [S.Iterator.Element]? {
        guard currentIndex < values.count else {
            return nil
        }

        if !hasReturnedFirst {
            hasReturnedFirst = true
            return values
        }

        if counts[currentIndex] < currentIndex {
            if currentIndex % 2 == 0 {
                swap(&values[0], &values[currentIndex])
            } else {
                swap(&values[counts[currentIndex]], &values[currentIndex])
            }
            counts[currentIndex] += 1
            currentIndex = 0
            return values
        } else {
            counts[currentIndex] = 0
            currentIndex += 1
            return next()
        }
    }
}
