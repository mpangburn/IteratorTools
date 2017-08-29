//
//  Combinations.swift
//  IteratorTools
//
//  Created by Michael Pangburn on 8/28/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import Foundation


public extension Sequence {

    /**
     Returns an array containing the combinations of the specified length of elements in the sequence.
     ```
     let values = [1, 2, 3, 4].combinations(length: 2)
     // [[1, 2], [1, 3], [1, 4], [2, 3], [2, 4], [3, 4]]
     ```
     - Parameter length: The length of the combinations to return.
     - Returns: An array containing the combinations of the specified length of elements in the sequence.
     */
    func combinations(length: Int) -> [[Iterator.Element]] {
        return Array(Combinations(sequence: self, length: length))
    }

    /**
     Returns an array containing the combinations of the specified length of elements in the sequence, with replacement (i.e. elements can repeat).
     ```
     let values = [1, 2, 3, 4].combinationsWithReplacement(length: 2)
     // [[1, 1], [1, 2], [1, 3], [2, 2], [2, 3], [3, 3]]
     ```
     - Parameter length: The length of the combinations to return.
     - Returns: An array containing the combinations of the specified length of elements in the sequence, with replacement (i.e. elements can repeat).
     */
    func combinationsWithReplacement(length: Int) -> [[Iterator.Element]] {
        return Array(CombinationsWithReplacement(sequence: self, length: length))
    }
}


public extension LazySequenceProtocol {

    /**
     Returns an array containing the combinations of the specified length of elements in the sequence.
     ```
     let values = [1, 2, 3, 4].lazy.combinations(length: 2)
     // [1, 2], [1, 3], [1, 4], [2, 3], [2, 4], [3, 4]
     ```
     - Parameter length: The length of the combinations to return.
     - Returns: An iterator-sequence containing the combinations of elements in the sequence of the specified length.
     */
    func combinations(length: Int) -> Combinations<Self> {
        return Combinations(sequence: self, length: length)
    }

    /**
     Returns an array containing the combinations of the specified length of elements in the sequence, with replacement (i.e. elements can repeat).
     ```
     let values = [1, 2, 3].lazy.combinationsWithReplacement(length: 2)
     // [1, 1], [1, 2], [1, 3], [2, 2], [2, 3], [3, 3]
     ```
     - Parameter length: The length of the combinations to return.
     - Returns: An array containing the combinations of the specified length of elements in the sequence, with replacement (i.e. elements can repeat).
     */
    func combinationsWithReplacement(length: Int) -> CombinationsWithReplacement<Self> {
        return CombinationsWithReplacement(sequence: self, length: length)
    }
}


/// An iterator-sequence that returns the combinations of a specified length of elements in a sequence.
/// See the `combinations(length:)` Sequence and LazySequenceProtocol method.
public struct Combinations<S: Sequence>: IteratorProtocol, Sequence {

    let values: [S.Iterator.Element]
    let combinationLength: Int
    var indicesIterator: Permutations<LazyRandomAccessCollection<CountableRange<Int>>>
    
    init(sequence: S, length: Int) {
        self.values = Array(sequence)
        self.combinationLength = length
        self.indicesIterator = values.indices.lazy.permutations(length: combinationLength)
    }

    public mutating func next() -> [S.Iterator.Element]? {
        guard let indices = indicesIterator.next() else {
            return nil
        }

        guard indices.sorted() == Array(indices) else {
            return next()
        }

        let combination = indices.map { values[$0] }
        return combination.isEmpty ? nil : combination
    }
}


/// An iterator-sequence that returns the combinations of elements in a sequence, with replacement (i.e. elements can repeat).
/// See the `combinationsWithReplacement(length:)` Sequence and LazySequenceProtocol method.
public struct CombinationsWithReplacement<S: Sequence>: IteratorProtocol, Sequence {

    let values: [S.Iterator.Element]
    let combinationLength: Int
    var indicesIterator: CartesianProduct<CountableRange<Int>>

    init(sequence: S, length: Int) {
        self.values = Array(sequence)
        self.combinationLength = length
        self.indicesIterator = product(values.indices, repeated: length)
    }

    public mutating func next() -> [S.Iterator.Element]? {
        guard let indices = indicesIterator.next() else {
            return nil
        }

        guard indices.sorted() == Array(indices) else {
            return next()
        }

        let combination = indices.map { values[$0] }
        return combination.isEmpty ? nil : combination
    }
}
