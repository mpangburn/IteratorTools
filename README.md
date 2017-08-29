# IteratorTools
A Swift port of Python's [itertools](https://docs.python.org/3/library/itertools.html).

## From Python to Swift
Python's `Iterator` and `Iterable` are equivalent to Swift's `IteratorProtocol` and `Sequence`. In Python, every `Iterator` must also be an `Iterable`. Though Swift has no such constraint, the return types of most IteratorTools functions implement both `IteratorProtocol` and `Sequence` to follow Python's pattern and to reduce boilerplate code. These types will henceforth be referred to as iterator-sequences.

Due to the nature of Swift's strong, static typing system, some functions cannot be generalized to the extent to which they are in Python. These limitations are noted where appropriate in the function descriptions below.

### Free Functions and Methods

While Python favors free functions, Swift favors methods. Where applicable, methods are implemented eagerly as Sequence extensions (returning arrays) and lazily as LazySequenceProtocol extensions (returning iterator-sequences). For example:

```swift
let values = [1, 2, 3].cycle(times: 2)
// [1, 2, 3, 1, 2, 3]

let values = [1, 2, 3].lazy.cycle(times: 2)
// 1, 2, 3, 1, 2, 3
```
Functions such as `product`, however, are better semantically suited as free functions. The free functions in IteratorTools always compute lazily, though they can be casted to an array (or other sequence) to access all values.

```swift
let values = product([1, 2, 3], [4, 5, 6])
// [1, 4], [1, 5], [1, 6], [2, 4], [2, 5], ...

let values = Array(product([1, 2, 3], [4, 5, 6]))
// [[1, 4], [1, 5], [1, 6], [2, 4], [2, 5], ... ]
```

The table below lists the functions provided by Python's itertools and their Swift counterparts.

| itertools                       | Free Function(s)                                            | Method(s)                                 | Notes                              | 
|---------------------------------|-------------------------------------------------------------|-------------------------------------------|------------------------------------| 
| `accumulate`                    | -                                                           | `accumulate(_:)`                          |                                    | 
| `chain`                         | `chain(_:)`                                                 | -                                         |                                    | 
| `chain.from_iterable`           | `chain(_:)`                                                 | -                                         |                                    | 
| `combinations`                  | -                                                           | `combinations(length:)`                   |                                    | 
| `combinations_with_replacement` | -                                                           | `combinationsWithReplacement(length:)`    |                                    | 
| `compress`                      | `compress(data:selectors:)`                                 | -                                         |                                    | 
| `count`                         | `counter()`, `counter(start:step:)`                         | -                                         |                                    | 
| `cycle`                         | -                                                           | `cycle()`, `cycle(times:)`                |                                    | 
| `dropwhile`                     | -                                                           | `drop(while:)`                            | Provided by Swift standard library | 
| `filterfalse`                   | -                                                           | `reject(predicate:)`                      | Renamed for clarity                | 
| `groupby`                       | -                                                           | `grouped(by:)`                            |                                    | 
| `islice`                        | -                                                           | `stride(from:to:by:)`                     | Provided by Swift standard library | 
| `permutations`                  | -                                                           | `permutations()`, `permutations(length:)` |                                    | 
| `product`                       | `product(_:)`, `product(_:repeated:_`, `mixedProduct(_:_:)` |                                           | See distinctions below             | 
| `repeat`                        | `repeater(value:)`, `repeater(value:times:)`                | -                                         | `repeat` keyword taken in Swift    | 
| `starmap`                       | -                                                           | -                                         | No appropriate Swift equivalent    | 
| `takewhile`                     | -                                                           | `prefix(while:)`                          | Provided by Swift standard library | 
| `tee`                           | -                                                           | `tee(_:)`                                 |                                    | 
| `zip_longest`                   | `zipLongest(_:_:firstFillValue:secondFillValue:)`           | -                                         |                                    | 


## Free Functions
### chain(_:)
Returns an iterator-sequence that returns values from each sequence until all are exhausted. Used for treating consecutive sequences as a single sequence. This function is overloaded to accept either any number of sequences or an array of sequences as parameters.

```swift
let values = chain([1, 2, 3], [4, 5, 6])
// 1, 2, 3, 4, 5, 6

let values = chain([[1, 2, 3], [4, 5, 6])
// 1, 2, 3, 4, 5, 6
```
 
### compress(data:selectors:)
Returns an iterator-sequence that filters elements from `data`, returning only those that have a corresponding `true` in `selectors`. Stops when either `data` or `selectors` has been exhausted.

```swift
let values = compress([1, 2, 3, 4], [true, true, false, true])
// 1, 2, 4

let values = compress([1, 2, 3], [true, false, true, true, true])
// 1, 3
```

### counter(start:step:)
Returns an infinite iterator-sequence beginning at `start` and incrementing by `step`. By default, creates a counter beginning at zero and incrementing by one.

```swift
let values = counter()
// 0, 1, 2, 3, 4, ...

let values = counter(start: 1, step: 2)
// 1, 3, 5, 7, 9, ...
```

The returned iterator-sequence adopts `LazySequenceProtocol`, so operations such as `map` and `filter` are implemented lazily. As a result, they can be used even though the sequence is infinite. In practice, iterating over the returned iterator-sequence requires a statement such as `break` or `return` to transfer the flow of control out of the otherwise infinite loop.

### product(\_:), product(\_:repeated:), mixedProduct(\_:\_:)
The `product` functions return iterator-sequences for the Cartesian product of sequences. For sequences containing elements of the same type, `product` works as its Python counterpart in that the product can be generated from any number of sequences. To avoid compile-time ambiguity, the function for taking the product of sequences of different types has been renamed `mixedProduct`. Due to Swift's strong, static typing system, `mixedProduct` can take only a finite number of arguments. In the future, `mixedProduct` may be overloaded to take more than two arguments, but each of these implementations must be done individually.

`product(_:)` Returns an iterator-sequence for the Cartesian product of the sequences.

```swift
let values = product([1, 2, 3], [4, 5, 6, 7], [8, 9])
// [1, 4, 8], [1, 4, 9], [1, 5, 8], [1, 5, 9], [1, 6, 8], ...
```

`product(_:repeated:)` Returns an iterator-sequence for the Cartesian product of the sequence repeated with itself a number of times.
 
```swift
let values = product([1, 2, 3], repeated: 2)
// Equivalent to product([1, 2, 3], [1, 2, 3])
```

`mixedProduct(_:_:)` Returns an iterator-sequence for the Cartesian product of two sequences containing elements of different types.

```swift
let values = mixedProduct(["a", "b"], [1, 2, 3])
// ("a", 1), ("a", 2), ("a", 3), ("b", 1), ("b", 2), ("b", 3)
```

### repeater(value:times:)
Returns an iterator-sequence repeating a value, either infinitely or a specified number of times. Defaults to infinite repetition without an argument for `times`.

```swift
let values = repeater(value: 0)
// 0, 0, 0, 0, ...

let values = repeater(value: 0, times: 3)
// 0, 0, 0
```

### zipLongest(\_:\_:firstFillValue:secondFillValue:)
Returns an iterator-sequence that aggregates elements from each of the sequences. If the sequences are of uneven length, missing values are filled-in with the corresponding fill value. Iteration continues until the longest sequence is exhausted.

```swift
let values = zipLongest([1, 2], [3, 4, 5], firstFillValue: 0, secondFillValue: -1
// (1, 3), (2, 4), (0, 5)

let values = zipLongest([1, 2, 3, 4], [5, 6], firstFillValue: 0, secondFillValue: -1)
// (1, 5), (2, 6), (3, -1), (4, -1)
```

## Methods

Details to come.