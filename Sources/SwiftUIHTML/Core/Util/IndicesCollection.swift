//  Copyright © 2025 PRND. All rights reserved.
import Foundation


extension RandomAccessCollection where Indices == Range<Int> {
    var indicesCollection: IndicesCollection<Self> {
        IndicesCollection(self)
    }
}

struct IndicesCollection<T: RandomAccessCollection>: RandomAccessCollection where T.Indices == Range<Int> {

    let collection: T
    let indices: Range<Int>

    init(_ collection: T) {
        self.collection = collection
        self.indices = collection.indices
    }

    var startIndex: Int {
        Int(indices.lowerBound)
    }

    var endIndex: Int {
        Int(indices.upperBound)
    }

    subscript(position: Int) -> (Int, T.Element) {
        (position, collection[position])
    }
}
