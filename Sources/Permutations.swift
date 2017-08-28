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
     Returns an array containing the permutations of elements in the sequence.
     ```
     let values = [1, 2, 3].permutations()
     // [[1, 2, 3], [1, 3, 2], [2, 1, 3], [2, 3, 1], [3, 1, 2], [3, 2, 1]]
     
     let values = [1, 2, 3].permutations(length: 2)
     // [[1, 2], [1, 3], [2, 1], [2, 3], [3, 1], [3, 2]]
     ```
     - Returns: An array containing the permutations of elements in the sequence.
     */
    func permutations(length: Int? = nil) -> [[Iterator.Element]] {
        return Array(Permutations(sequence: self, length: length))
    }
}


public extension LazySequenceProtocol {

    /**
     Returns an iterator that returns the permutations of elements in the sequence.
     ```
     let values = [1, 2, 3].lazy.permutations()
     // [1, 2, 3], [1, 3, 2], [2, 1, 3], [2, 3, 1], [3, 1, 2], [3, 2, 1]
     
     let values = [1, 2, 3].lazy.permutations(length: 2)
     // [1, 2], [1, 3], [2, 1], [2, 3], [3, 1], [3, 2]
     ```
     - Returns: An iterator that returns the permutations of elements in the sequence.
     */
    func permutations(length: Int? = nil) -> Permutations<Self> {
        return Permutations(sequence: self, length: length)
    }
}


/// An iterator that returns the permutations of elements in a sequence. 
/// See the `permutations` and `permutations(length:)` Sequence and LazySequenceProtocol methods.
public struct Permutations<S: Sequence>: IteratorProtocol, Sequence {

    var values: [S.Iterator.Element]
    let permutationLength: Int
    var indicesIterator: SingleTypeCartesianProduct<CountableRange<Int>>

    init(sequence: S, length: Int?) {
        self.values = Array(sequence)

        // Use of ternary operator produces compile-time error
        if let length = length {
            self.permutationLength = length
        } else {
            self.permutationLength = values.count
        }

        self.indicesIterator = product(values.indices, repeated: permutationLength)
    }

    public mutating func next() -> [S.Iterator.Element]? {
        guard let indices = indicesIterator.next() else {
            return nil
        }

        guard Set(indices).count == permutationLength else {
            return next()
        }

        let permutation = indices.map { values[$0] }
        return permutation.isEmpty ? nil : permutation
    }
}
