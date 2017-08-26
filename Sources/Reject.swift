//
//  Reject.swift
//  IteratorTools
//
//  Created by Michael Pangburn on 8/25/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import Foundation


public extension Sequence {

    /**
     Returns the array elements from the sequence for which the predicate is false.
     ```
     var values = [1, 2, 3, 4, 5].reject { $0 % 2 == 0 }
     // [1, 3, 5]
     ```
     - Parameter predicate: The predicate used to determine whether the elements should be included in the result. 
        Elements are included only when the predicate is false.
     - Returns: The array elements from the sequence for which the predicate is false.     
     */
    func reject(predicate: @escaping (Iterator.Element) -> Bool) -> [Iterator.Element] {
        return filter { !predicate($0) }
    }
}
