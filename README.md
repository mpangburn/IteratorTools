# IteratorTools
A Swift port of Python's [itertools](https://docs.python.org/3/library/itertools.html).

>The [framework] standardizes a core set of fast, memory efficient tools that are useful by themselves or in combination. Together, they form an “iterator algebra” making it possible to construct specialized tools succinctly and efficiently in pure [Swift].

## Table of Contents
- [**From Python to Swift**](#from-python-to-swift)
	- [Free Functions and Methods](#free-functions-and-methods)
- [**Infinite Iterator-Sequences**](#infinite-iterator-sequences)
- [**Installation**](#installation)
	- [CocoaPods](#cocoapods)
	- [Carthage](#carthage)
- [**Documentation**](#documentation)
	- [Free Functions](#free-functions)
		- [`chain(_:)`](#chain_)
		- [`compress(data:selectors:)`](#compressdataselectors)
		- [`counter(start:step:)`](#counterstartstep)
		- [`product(_:)`, `product(_:repeated:)`, `mixedProduct(_:_:)`](#product_-product_repeated-mixedproduct__)
		- [`repeater(value:times:)`](#repeatervaluetimes)
		- [`zipToLongest(_:_:firstFillValue:secondFillValue:)`](#ziptolongest__firstfillvaluesecondfillvalue)
	- [Methods](#methods)
		- [`accumulate(_:)`](#accumulate_)
		- [`combinations(length:repeatingElements:)`](#combinationslengthrepeatingelements)
		- [`cycle()`, `cycle(times:)`](#cycle-cycletimes)
		- [`grouped(by:)`](#groupedby)
		- [`permutations(length:repeatingElements:)`](#permutationslengthrepeatingelements)
		- [`reject(predicate:)`](#rejectpredicate)
		- [`tee(_:)`](#tee_)
- [**License**](#license)


## From Python to Swift
Python's `iterator` and `iterable` protocols are equivalent to Swift's [`IteratorProtocol`](https://developer.apple.com/documentation/swift/iteratorprotocol) and [`Sequence`](https://developer.apple.com/documentation/swift/sequence). In Python, every `iterator` must also be an `iterable`. Though Swift has no such constraint, the return types of IteratorTools functions implement both `IteratorProtocol` and `Sequence` (or, in [certain cases](#infinite-iterator-sequences), `LazySequenceProtocol`) to follow Python's pattern and to reduce boilerplate code. These types will henceforth be referred to as iterator-sequences.

Due to the current limitations of generics in Swift's typing system, some functions cannot be generalized to the extent to which they are in Python. These limitations are noted where appropriate in the documentation below.

### Free Functions and Methods
While Python favors free functions, Swift favors methods. Where applicable, methods are implemented eagerly as Sequence extensions (returning arrays) and lazily as LazySequenceProtocol extensions (returning iterator-sequences). For example:

```swift
let values = [1, 2, 3].cycle(times: 2)
// [1, 2, 3, 1, 2, 3]

let values = [1, 2, 3].lazy.cycle(times: 2)
// 1, 2, 3, 1, 2, 3
```
Functions such as `product`, however, are better semantically suited as free functions. The free functions in IteratorTools always compute lazily, though they can be casted to an array to access all values eagerly.

```swift
let values = product([1, 2, 3], [4, 5, 6])
// [1, 4], [1, 5], [1, 6], [2, 4], [2, 5], ...

let values = Array(product([1, 2, 3], [4, 5, 6]))
// [[1, 4], [1, 5], [1, 6], [2, 4], [2, 5], ... ]
```

The table below lists the functions provided by Python's itertools and their Swift counterparts.

| itertools                                       | Free Function(s)                                            | Method(s)                                                                     | Notes                              | 
|-------------------------------------------------|-------------------------------------------------------------|-------------------------------------------------------------------------------|------------------------------------| 
| `accumulate`                                    |                                                             | `accumulate(_:)`                                                              |                                    | 
| `chain`                                         | `chain(_:)`                                                 |                                                                               |                                    | 
| `chain.from_iterable`                           | `chain(_:)`                                                 |                                                                               |                                    | 
| `combinations`, `combinations_with_replacement` |                                                             | `combinations(length:repeatingElements:)`                                     |                                    | 
| `compress`                                      | `compress(data:selectors:)`                                 |                                                                               |                                    | 
| `count`                                         | `counter()`, `counter(start:step:)`                         |                                                                               |                                    | 
| `cycle`                                         |                                                             | `cycle()`, `cycle(times:)`                                                    |                                    | 
| `dropwhile`                                     |                                                             | `drop(while:)`                                                                | Provided by Swift standard library | 
| `filterfalse`                                   |                                                             | `reject(predicate:)`                                                          | Renamed for clarity                | 
| `groupby`                                       |                                                             | `grouped(by:)`                                                                |                                    | 
| `islice`                                        |                                                             | `stride(from:to:by:)`                                                         | Provided by Swift standard library | 
| `permutations`                                  |                                                             | `permutations(repeatingElements:)`, `permutations(length:repeatingElements:)` |                                    | 
| `product`                                       | `product(_:)`, `product(_:repeated:_`, `mixedProduct(_:_:)` |                                                                               | See distinctions below             | 
| `repeat`                                        | `repeater(value:)`, `repeater(value:times:)`                |                                                                               | `repeat` keyword taken in Swift    | 
| `starmap`                                       |                                                             |                                                                               | No appropriate Swift equivalent    | 
| `takewhile`                                     |                                                             | `prefix(while:)`                                                              | Provided by Swift standard library | 
| `tee`                                           |                                                             | `tee(_:)`                                                                     |                                    | 
| `zip_longest`                                   | `zipToLongest(_:_:firstFillValue:secondFillValue:)`           |                                                                               |                                    | 


## Infinite Iterator-Sequences
The iterator-sequences returned by `counter(start:step:)`, `repeater(value:)`, and `cycle()` are infinite. These iterator-sequences adopt LazySequenceProtocol, so operations such as `map` and `filter` are implemented lazily. As a result, they can be used even though the sequences are infinite. In practice, iterating over an infinite iterator-sequence requires a statement such as `break` or `return` to transfer the flow of control out of the otherwise infinite loop.

The iterator-sequences returned by `repeater(value:times:)` and the lazy version of `cycle(times:)`, though finite, are of the same types as those produced by their infinite counterparts.

## Installation
### CocoaPods
To install via [CocoaPods](http://cocoapods.org), add the following line to your Podfile:

`pod "IteratorTools"`


### Carthage
To install via [Carthage](https://github.com/Carthage/Carthage), add the following line to your Cartfile:

`github "mpangburn/IteratorTools"`

## Documentation
### Free Functions
#### `chain(_:)`
Returns an iterator-sequence that returns values from each sequence until all are exhausted. This function is used for treating consecutive sequences as a single sequence. `chain(_:)` is overloaded to accept either any number of sequences or an array of sequences as parameters.

```swift
let values = chain([1, 2, 3], [4, 5, 6])
// 1, 2, 3, 4, 5, 6

let values = chain([[1, 2, 3], [4, 5, 6]])
// 1, 2, 3, 4, 5, 6
```
 
#### `compress(data:selectors:)`
Returns an iterator-sequence that filters elements from `data`, returning only those that have a corresponding `true` in `selectors`. Iteration stops when either `data` or `selectors` has been exhausted.

```swift
let values = compress(data: [1, 2, 3, 4], selectors: [true, true, false, true])
// 1, 2, 4

let values = compress(data: [1, 2, 3], selectors: [true, false, true, true, true])
// 1, 3
```

#### `counter(start:step:)`
Returns an infinite iterator-sequence beginning at `start` and incrementing by `step`. By default, this function creates a counter beginning at zero and incrementing by one.

```swift
let values = counter()
// 0, 1, 2, 3, 4, ...

let values = counter(start: 1, step: 2)
// 1, 3, 5, 7, 9, ...
```

#### `product(_:)`, `product(_:repeated:)`, `mixedProduct(_:_:)`
The `product` functions return iterator-sequences for the Cartesian product of sequences. For sequences containing elements of the same type, `product` works as its Python counterpart in that the product can be generated from any number of sequences. To avoid compile-time ambiguity, the function for taking the product of sequences of different types has been renamed `mixedProduct`. Due to Swift's strong, static typing system, `mixedProduct` can take only a finite number of arguments. In the future, `mixedProduct` may be overloaded to take more than two arguments, but each of these implementations must be done individually.

`product(_:)` Returns an iterator-sequence for the Cartesian product of the sequences.

```swift
let values = product([1, 2, 3], [4, 5, 6, 7], [8, 9])
// [1, 4, 8], [1, 4, 9], [1, 5, 8], [1, 5, 9], [1, 6, 8], ... [3, 7, 9]
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

#### `repeater(value:times:)`
Returns an iterator-sequence repeating a value, either infinitely or a specified number of times. This function defaults to infinite repetition without an argument for `times`.

```swift
let values = repeater(value: 0)
// 0, 0, 0, 0, ...

let values = repeater(value: 0, times: 3)
// 0, 0, 0
```

#### `zipToLongest(_:_:firstFillValue:secondFillValue:)`
Returns an iterator-sequence that aggregates elements from each of the sequences. If the sequences are of uneven length, missing values are filled-in with the corresponding fill value. Iteration continues until the longest sequence is exhausted. Because of limitations with Swift's generics, `zipToLongest` can take only a finite number of arguments. In the future, `zipToLongest` may be overloaded to take more than two arguments, but each of these implementations must be done individually at this point in time.

```swift
let values = zipToLongest([1, 2], ["a", "b", "c"], firstFillValue: 0, secondFillValue: "z"
// (1, "a"), (2, "b"), (0, "c")

let values = zipToLongest([1, 2, 3, 4], ["a", "b"], firstFillValue: 0, secondFillValue: "z")
// (1, "a"), (2, "b"), (3, "z"), (4, "z")
```

### Methods
#### `accumulate(_:)`
Returns an array (eager) or an iterator-sequence (lazy) of consecutively accumulated values from the sequence using the specified function.

```swift
let values = [1, 2, 3, 4].accumulate(+)
// [1, 3, 6, 10]

let values = [1, 2, 3, 4].lazy.accumulate(+)
// 1, 3, 6, 10
```

#### `combinations(length:repeatingElements)`
Returns an array (eager) or an iterator-sequence (lazy) of the combinations of the specified length of elements in the sequence.

```swift
let values = [1, 2, 3, 4].combinations(length: 2, repeatingElements: false)
// [[1, 2], [1, 3], [1, 4], [2, 3], [2, 4], [3, 4]]

let values = [1, 2, 3, 4].combinations(length: 2, repeatingElements: true)
// [[1, 1], [1, 2], [1, 3], [1, 4], [2, 2], [2, 3], [2, 4], [3, 3], [3, 4]]

let values = [1, 2, 3, 4].lazy.combinations(length: 2, repeatingElements: false)
// [1, 2], [1, 3], [1, 4], [2, 3], [2, 4], [3, 4]
 
let values = [1, 2, 3, 4].lazy.combinations(length: 2, repeatingElements: true)
// [1, 1], [1, 2], [1, 3], [1, 4], [2, 2], [2, 3], [2, 4], [3, 3], [3, 4]

```

#### `cycle(), cycle(times:)`
`cycle()` Returns an iterator-sequence cycling infinitely through the sequence. This function always computes lazily.

```swift
let values = [1, 2, 3].cycle()
// 1, 2, 3, 1, 2, 3, 1, ...
```

`cycle(times:)` Returns an array (eager) or an iterator-sequence (lazy) of `times` cycles of self.

```swift
let values = [1, 2, 3].cycle(times: 2)
// [1, 2, 3, 1, 2, 3]

let values = [1, 2, 3].lazy.cycle(times: 2)
// 1, 2, 3, 1, 2, 3
```

#### `grouped(by:)`
Returns an array (eager) or an iterator-sequence (lazy) of consecutive keys and groups from the sequence as tuples.
Groups are made based on the element's output from the given key function. 
A group is cut as soon as the sequence's next value produces a different key.
Generally, the sequence should be sorted on the same key function to group all values with the same key.

```swift
let values = (0...10).sorted(by: { $0 % 3 < $1 % 3 }).grouped(by: { $0 % 3 })
// [(key: 0, elements: [0, 3, 6, 9]), (key: 1, elements: [1, 4, 7, 10]), (key: 2, elements: [2, 5, 8])]

let values = (0...10).sorted(by: { $0 % 3 < $1 % 3 }).lazy.grouped(by: { $0 % 3 })
// (key: 0, elements: [0, 3, 6, 9]), (key: 1, elements: [1, 4, 7, 10]), (key: 2, elements: [2, 5, 8])
```

#### `permutations(length:repeatingElements:)`
Returns an array (eager) or an iterator-sequence (lazy) containing the permutations of elements in the sequence, optionally of a specified length. If no `length` argument is provided, the permutation length defaults to the length of the sequence.

```swift
let values = [1, 2, 3].permutations(repeatingElements: false)
// [[1, 2, 3], [1, 3, 2], [2, 1, 3], [2, 3, 1], [3, 1, 2], [3, 2, 1]]

let values = [1, 2, 3].permutations(length: 2, repeatingElements: true)
// [[1, 1], [1, 2], [1, 3], [2, 1], [2, 2], [2, 3], [3, 1], [3, 2], [3, 3]]

let values = [1, 2, 3].lazy.permutations(repeatingElements: false)
// [1, 2, 3], [1, 3, 2], [2, 1, 3], [2, 3, 1], [3, 1, 2], [3, 2, 1]

let values = [1, 2, 3].lazy.permutations(length: 2, repeatingElements: true)
// [1, 1], [1, 2], [1, 3], [2, 1], [2, 2], [2, 3], [3, 1], [3, 2], [3, 3]
```

#### `reject(predicate:)`
Returns an array (eager) or an iterator-sequence (lazy) containing only the elements from the sequence for which the predicate is false.

```swift
let values = [1, 2, 3, 4, 5].reject { $0 % 2 == 0 }
// [1, 3, 5]

let values = [1, 2, 3, 4, 5].lazy.reject { $0 % 2 == 0 }
// 1, 3, 5
```

#### `tee(_:)`
Returns an array (eager) or an iterator-sequence (lazy) of the specified number of independent iterators from the sequence. If no argument is provided, the function defaults to producing two independent iterators.

```swift
let iterators = [1, 2, 3].tee()
// an array of two independent iterators of [1, 2, 3]

let iterators = [1, 2, 3].tee(3)
// an array of three independent iterators of [1, 2, 3]

let iterators = [1, 2, 3].lazy.tee()
// an iterator-sequence of two independent iterators of [1, 2, 3]

let iterators = [1, 2, 3].lazy.tee(3)
// an iterator-sequence of three independent iterators of [1, 2, 3]
```

## License
IteratorTools is released under the MIT license. See [LICENSE](https://github.com/mpangburn/IteratorTools/blob/master/LICENSE) for details.