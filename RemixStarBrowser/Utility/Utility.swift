import Foundation

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

protocol Emptyable {
    static var empty: Self { get }
}

enum Result<T> {
    case success(T)
    case error
}

typealias AsyncResult<T> = (Result<T>) -> Void

typealias Callback = () -> Void
