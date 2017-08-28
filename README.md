# IteratorTools
A Swift port of Python's [itertools](https://docs.python.org/3/library/itertools.html).

## From Python to Swift
Python's `Iterator` and `Iterable` are equivalent to Swift's `IteratorProtocol` and `Sequence`. In Python, every `Iterator` must also be an `Iterable`. Though Swift has no such constraint, the return types of most IteratorTools functions implement both `IteratorProtocol` and `Sequence` to follow Python's pattern and to reduce boilerplate code. These types will henceforth be referred to as iterator-sequences.

Due to the nature of Swift's static typing system, some functions cannot be generalized to the extent to which they are in Python. These limitations are noted where appropriate in the function descriptions below.

## Free Functions and Methods

While Python favors free functions, Swift favors methods. Where applicable, methods are implemented eagerly as Sequence extensions and lazily as LazySequenceProtocol extensions. For example:

```swift
let values = [1, 2, 3].cycle(times: 2)
// [1, 2, 3, 1, 2, 3]

let values = [1, 2, 3].lazy.cycle(times: 2)
// 1, 2, 3, 1, 2, 3
```
Functions such as `product`, however, are better semantically suited as free functions. The free functions in IteratorTools always compute lazily.

The table below lists the functions provided by Python's itertools and their Swift IteratorTools counterparts.

| itertools                       | Free Function(s)                                  | Method(s)                                                   | Notes                              | 
|---------------------------------|---------------------------------------------------|-------------------------------------------------------------|------------------------------------| 
| `accumulate`                    | -                                                 | `accumulate(_:)`                                            |                                    | 
| `chain`                         | `chain(_:)`                                       | -                                                           |                                    | 
| `chain.from_iterable`           | `chain(_:)`                                       | -                                                           |                                    | 
| `combinations`                  | -                                                 | `combinations(length:)`                                     |                                    | 
| `combinations_with_replacement` | -                                                 | `combinationsWithReplacement(length:)`                      |                                    | 
| `compress`                      | `compress(data:selectors:)`                       | -                                                           |                                    | 
| `count`                         | `counter()`, `counter(start:step:)`               | -                                                           |                                    | 
| `cycle`                         | -                                                 | `cycle()`, `cycle(times:)`                                  |                                    | 
| `dropwhile`                     | -                                                 | `drop(while:)`                                              | Provided by Swift standard library | 
| `filterfalse`                   | -                                                 | `reject(predicate:)`                                        | Renamed for clarity                | 
| `groupby`                       | -                                                 | `grouped(by:)`                                              |                                    | 
| `islice`                        | -                                                 | `stride(from:to:by:)`                                       | Provided by Swift standard library | 
| `permutations`                  | -                                                 | `permutations()`, `permutations(length:)`                   |                                    | 
| `product`                       | -                                                 | `product(_:)`, `product(_:repeated:_`, `mixedProduct(_:_:)` | See distinctions below             | 
| `repeat`                        | `repeater(value:)`, `repeater(value:times:)`      | -                                                           | `repeat` keyword taken in Swift    | 
| `starmap`                       | -                                                 | -                                                           | No appropriate Swift equivalent    | 
| `takewhile`                     | -                                                 | `prefix(while:)`                                            | Provided by Swift standard library | 
| `tee`                           | -                                                 | `tee(_:)`                                                   |                                    | 
| `zip_longest`                   | `zipLongest(_:_:firstFillValue:secondFillValue:)` | -  

## Free Functions
### counter(start:step:)


```swift
var values = counter()
// 0, 1, 2, 3, ...

var values = counter(start: 1, step: 2)
// 1, 3, 5, 7, ...
```
