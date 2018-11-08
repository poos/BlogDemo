import UIKit
import Foundation
import PlaygroundSupport

extension String {
    public func aaaaa() -> Int {
        return self.count
    }
}

let exampleFiles = ["README.md", "HelloWorld.swift", "FlappyBird.swift"]

let map = exampleFiles.map { $0.count }
print(map)
//[9, 16, 16]

let exampleFiles2 = [exampleFiles, [""], exampleFiles]
let flatMap = exampleFiles2.flatMap { (arr) -> [Int] in
    arr.map({ $0.count })
}
print(flatMap)
//[9, 16, 16, 0, 9, 16, 16]

let flatMap1 = exampleFiles2.flatMap { $0 }
print(flatMap1)
//["README.md", "HelloWorld.swift", "FlappyBird.swift", "", "README.md", "HelloWorld.swift", "FlappyBird.swift"]

//'flatMap' is deprecated: Please use compactMap(_:) for the case where closure returns an optional value
let flatMap2 = exampleFiles2.compactMap{ $0.count }
print(flatMap2)
//[3, 1, 3]

let flatMap3 = exampleFiles2.flatMap { $0 }.map({$0.count})
print(flatMap3)
//[9, 16, 16, 0, 9, 16, 16]

let flatMap4 = exampleFiles.flatMap { (item) in
    exampleFiles.map({ (item2) -> (String, String) in
        return (item, item)
    })
}
print(flatMap4)
//[("README.md", "README.md"), ("README.md", "README.md"), ("README.md", "README.md"), ("HelloWorld.swift", "HelloWorld.swift"), ("HelloWorld.swift", "HelloWorld.swift"), ("HelloWorld.swift", "HelloWorld.swift"), ("FlappyBird.swift", "FlappyBird.swift"), ("FlappyBird.swift", "FlappyBird.swift"), ("FlappyBird.swift", "FlappyBird.swift")]

var arrTotal: [String] = []
let flatMap5 = exampleFiles2.flatMap { (arr) -> [String] in
    arrTotal += arr
    return arrTotal
}
print(flatMap5)


let filter = exampleFiles.filter({ $0.hasSuffix(".swift") })
print(filter)
//["HelloWorld.swift", "FlappyBird.swift"]

var reduceR = exampleFiles.reduce("") { (total, item) -> String in
    if total.count == 0 {
        return item
    } else {
        return total + "," + item
    }
}
print(reduceR)
//README.md,HelloWorld.swift,FlappyBird.swift


let reduceInto = exampleFiles.reduce(into: [String: Int]()) { (result, item) in
    let index = item.lastIndex(of: ".") ?? item.startIndex
    let key = item.suffix(from: index)
    result["\(key)", default: 0] += 1
}
print(reduceInto)
//[".md": 1, ".swift": 2]

let reduceInto2 = exampleFiles2.reduce(into: [Int]()) { (result, item) in
    return result += item.map({ $0.count })
}
print(reduceInto2)
//[9, 16, 16, 0, 9, 16, 16]



extension Array {
    func map2<T>(transform: (Element) -> T) -> [T] {
        var result: [T] = []
        for x in self {
            result.append(transform(x))
            print(x)
        }
        return result
    }
}

let map2 = exampleFiles.map2 { $0.count }
print(map2)

let map3 = exampleFiles.map2 { (item) -> Int in
    return item.count
}
print(map3)


let map4 = exampleFiles.map2 { $0.count }.map2(transform: { $0 == 2 })
print(map4)


