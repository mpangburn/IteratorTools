//
//  ZipLongest.swift
//  IteratorTools
//
//  Created by Michael Pangburn on 8/25/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import Foundation


/**
 Returns an iterator-sequence that aggregates elements from each of the sequences. 
 If the sequences are of uneven length, missing values are filled-in with the corresponding fill value. 
 Iteration continues until the longest sequence is exhausted.
 ```
 let values = zipLongest([1, 2, 3, 4], [5, 6], firstFillValue: 0, secondFillValue: -1)
 // (1, 5), (2, 6), (3, -1), (4, -1)
 ```
 - Parameters:
    - firstSequence: The first of the sequences from which to aggregate elements.
    - secondSequence: The second of the sequences from which to aggregate elements.
    - firstFillValue: The value to use as a filler in zipping when the second sequence is longer than the first.
    - secondFillValue: The value to use as a filler in zipping when the first sequence is longer than the second.
 - Returns: An iterator-sequence that aggregates elements from each of the sequences.
 */
public func zipLongest<S1: Sequence, S2: Sequence>(_ firstSequence: S1, _ secondSequence: S2, firstFillValue: S1.Iterator.Element, secondFillValue: S2.Iterator.Element) -> ZipLongest<S1, S2> {
        return ZipLongest(firstSequence, secondSequence, firstFillValue: firstFillValue, secondFillValue: secondFillValue)
}


/// An iterator-sequence that aggregates elements from two sequences, filling in with values when one sequence is longer than the other.
/// See `zipLongest(_:_:firstFillValue:secondFillValue:)`.
public struct ZipLongest<S1: Sequence, S2: Sequence>: IteratorProtocol, Sequence {

    var firstIterator: S1.Iterator
    var secondIterator: S2.Iterator
    let firstFillValue: S1.Iterator.Element
    let secondFillValue: S2.Iterator.Element

    init(_ sequence1: S1, _ sequence2: S2, firstFillValue: S1.Iterator.Element, secondFillValue: S2.Iterator.Element) {
        self.firstIterator = sequence1.makeIterator()
        self.secondIterator = sequence2.makeIterator()
        self.firstFillValue = firstFillValue
        self.secondFillValue = secondFillValue
    }

    public mutating func next() -> (S1.Iterator.Element, S2.Iterator.Element)? {
        let firstValue = firstIterator.next()
        let secondValue = secondIterator.next()
        guard firstValue != nil || secondValue != nil else {
            return nil
        }
        return (firstValue ?? firstFillValue, secondValue ?? secondFillValue)
    }
}
