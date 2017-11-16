//  Copyright © 2017 Schibsted. All rights reserved.

import Foundation

// Identifier

struct Identifier<T>: Hashable {

    let value: String

    var hashValue: Int {
        return value.hashValue
    }

    static func == (lhs: Identifier<T>, rhs: Identifier<T>) -> Bool {
        return lhs.value == rhs.value
    }

    static func make() -> Identifier {
        return Identifier(value: UUID().uuidString)
    }
}

// Result

enum Result<T> {
    case success(T)
    case error(Error)
}

// Wireframe

protocol Navigatable: class {}

protocol NavigationWireframe {
    func push(_ navigatable: Navigatable)
}
