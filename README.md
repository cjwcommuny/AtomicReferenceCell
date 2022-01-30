# Atomic Reference Cell

This project provide two structures: `Arc<T>` and `WeakArc<T>` .

## Usage

Dereference:

```swift
let x: Arc<Int> = Arc(1)
let y: Arc<Int> = Arc(2)
let z: Int = *x + *y
assert(z == 3)
```

To invoke a method:

```swift
let x: Arc<Int> = Arc(1)
let y = (*x).distance(to: 3)
assert(y == 2)
```

To make weak reference:

```swift
let x: Arc<Int> = Arc(1)
let y: WeakArc<Int> = x.weak()
let z: Int? = *y
assert(z == 1)
```

## Installation

SwiftPM:

```swift
.package(url: "https://github.com/cjwcommuny/AtomicReferenceCell", from: "0.1.0")
```

