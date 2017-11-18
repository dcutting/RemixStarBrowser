//  Copyright © 2017 Schibsted. All rights reserved.

import UIKit

private let objCBoolIsChar = (OBJC_BOOL_IS_BOOL == 0)

public class RuntimeType: NSObject {

    public enum Kind: Equatable, CustomStringConvertible {
        case any(Any.Type)
        case `class`(AnyClass)
        case `struct`(String)
        case pointer(String)
        case `protocol`(Protocol)
        case `enum`(Any.Type, [String: AnyHashable])
        case options(Any.Type, [String: Any])

        public static func == (lhs: Kind, rhs: Kind) -> Bool {
            return lhs.description == rhs.description
        }

        public var description: String {
            switch self {
            case let .any(type),
                 let .enum(type, _),
                 let .options(type, _):
                return "\(type)"
            case let .class(type):
                return "\(type).Type"
            case let .struct(type),
                 let .pointer(type):
                return type
            case let .protocol(proto):
                return "<\(NSStringFromProtocol(proto))>"
            }
        }
    }

    public enum Availability: Equatable {
        case available
        case unavailable(reason: String?)

        public static func == (lhs: Availability, rhs: Availability) -> Bool {
            switch (lhs, rhs) {
            case (.available, .available):
                return true
            case let (.unavailable(lhs), .unavailable(rhs)):
                return lhs == rhs
            case (.available, _), (.unavailable, _):
                return false
            }
        }
    }

    public typealias Getter = (_ target: AnyObject, _ key: String) -> Any?
    public typealias Setter = (_ target: AnyObject, _ key: String, _ value: Any) throws -> Void
    private typealias Caster = (_ value: Any) -> Any?

    public let type: Kind
    private(set) var availability = Availability.available
    private(set) var getter: Getter?
    private(set) var setter: Setter?
    private var caster: Caster?

    static func unavailable(_ reason: String? = nil) -> RuntimeType? {
        #if arch(i386) || arch(x86_64)
            return RuntimeType(String.self, .unavailable(reason: reason))
        #else
            return nil
        #endif
    }

    public var isAvailable: Bool {
        switch availability {
        case .available:
            return true
        case .unavailable:
            return false
        }
    }

    public var values: [String: Any] {
        switch type {
        case let .enum(_, values):
            return values as [String: Any]
        case let .options(_, values):
            return values
        case .any, .class, .struct, .pointer, .protocol:
            return [:]
        }
    }

    @nonobjc private init(_ type: Kind, _ availability: Availability = .available) {
        self.type = type
        self.availability = availability
    }

    @nonobjc public convenience init(_ type: Any.Type, _ availability: Availability = .available) {
        let name = "\(type)"
        switch name {
        case "CGColor", "CGImage", "CGPath":
            self.init(.pointer(name), availability)
        case "NSString":
            self.init(.any(String.self), availability)
        default:
            self.init(.any(type), availability)
        }
    }

    @nonobjc public convenience init(class: AnyClass, _ availability: Availability = .available) {
        self.init(.class(`class`), availability)
    }

    @nonobjc public convenience init(_ type: Protocol, _ availability: Availability = .available) {
        self.init(.protocol(type), availability)
    }

    @nonobjc public convenience init?(_ typeName: String, _ availability: Availability = .available) {
        guard let type = classFromString(typeName) else {
            guard let proto = protocolFromString(typeName) else {
                let instanceName = sanitizedTypeName(typeName)
                guard RuntimeType.responds(to: Selector(instanceName)),
                    let type = RuntimeType.value(forKey: instanceName) as? RuntimeType else {
                    return nil
                }
                self.init(type.type, availability) // TODO: This copying isn't ideal
                return
            }
            self.init(proto, availability)
            return
        }
        self.init(type, availability)
    }

    @nonobjc public init?(objCType: String, _ availability: Availability = .available) {
        guard let first = objCType.unicodeScalars.first else {
            assertionFailure("Empty objCType")
            return nil
        }
        self.availability = availability
        switch first {
        case "c" where objCBoolIsChar, "B":
            type = .any(Bool.self)
        case "c", "i", "s", "l", "q":
            type = .any(Int.self)
        case "C", "I", "S", "L", "Q":
            type = .any(UInt.self)
        case "f":
            type = .any(Float.self)
        case "d":
            type = .any(Double.self)
        case "*":
            type = .any(UnsafePointer<Int8>.self)
        case "@":
            if objCType.hasPrefix("@\"") {
                let range = "@\"".endIndex ..< objCType.index(before: objCType.endIndex)
                let className: String = String(objCType[range])
                if className.hasPrefix("<") {
                    let range = "<".endIndex ..< className.index(before: className.endIndex)
                    let protocolName: String = String(className[range])
                    if let proto = NSProtocolFromString(protocolName) {
                        type = .protocol(proto)
                        return
                    }
                } else if let cls = NSClassFromString(className) {
                    if cls == NSString.self {
                        type = .any(String.self)
                    } else {
                        type = .any(cls)
                    }
                    return
                }
            }
            // Can't infer the object type, so ignore it
            return nil
        case "#":
            // Can't infer the specific subclass, so ignore it
            return nil
        case ":":
            type = .any(Selector.self)
            getter = { target, key in
                let selector = Selector(key)
                let fn = unsafeBitCast(
                    class_getMethodImplementation(Swift.type(of: target), selector),
                    to: (@convention(c) (AnyObject?, Selector) -> Selector?).self
                )
                return fn(target, selector)
            }
            setter = { target, key, value in
                let selector = Selector(
                    "set\(key.capitalized()):"
                )
                let fn = unsafeBitCast(
                    class_getMethodImplementation(Swift.type(of: target), selector),
                    to: (@convention(c) (AnyObject?, Selector, Selector?) -> Void).self
                )
                fn(target, selector, value as? Selector)
            }
        case "{":
            type = .struct(sanitizedStructName(objCType))
        case "^" where objCType.hasPrefix("^{"),
             "r" where objCType.hasPrefix("r^{"):
            type = .pointer(sanitizedStructName(objCType))
        default:
            // Unsupported type
            return nil
        }
    }

    @nonobjc public init<T: RawRepresentable & Hashable>(_: T.Type, _ values: [String: T]) {
        type = .enum(T.self, values)
        getter = { target, key in
            (target.value(forKey: key) as? T.RawValue).flatMap { T(rawValue: $0) }
        }
        setter = { target, key, value in
            target.setValue((value as? T)?.rawValue, forKey: key)
        }
        availability = .available
    }

    @nonobjc public convenience init<T: RawRepresentable & Hashable>(_ values: [String: T]) {
        self.init(T.self, values)
    }

    @nonobjc public init<T: RawRepresentable>(_: T.Type, _ values: [String: T]) {
        type = .options(T.self, values) // Can't validate options, so we'll only validate type
        getter = { target, key in
            (target.value(forKey: key) as? T.RawValue).flatMap { T(rawValue: $0) }
        }
        setter = { target, key, value in
            target.setValue((value as? T)?.rawValue, forKey: key)
        }
        availability = .available
    }

    @nonobjc public init<T: Hashable>(_: T.Type, _ values: [String: T]) {
        type = .enum(T.self, values)
        availability = .available
    }

    @nonobjc public convenience init<T: Hashable>(_ values: [String: T]) {
        self.init(T.self, values)
    }

    @nonobjc public init<T>(_: T.Type, _ values: [String: T]) {
        type = .options(T.self, values) // Can't validate options, so we'll just validate type
        availability = .available
    }

    @nonobjc public init<T: RawRepresentable & OptionSet>(_: T.Type, _ values: [String: T]) {
        type = .options(T.self, values)
        getter = { target, key in
            (target.value(forKey: key) as? T.RawValue).flatMap { T(rawValue: $0) }
        }
        setter = { target, key, value in
            target.setValue((value as? T)?.rawValue, forKey: key)
        }
        caster = { value in
            if let values = value as? [T] {
                return values.reduce([]) { (lhs: T, rhs: T) -> T in lhs.union(rhs) }
            }
            return value as? T
        }
        availability = .available
    }

    @nonobjc public convenience init<T: RawRepresentable & OptionSet>(_ values: [String: T]) {
        self.init(T.self, values)
    }

    @nonobjc public init(_ values: Set<String>) {
        // TODO: add a new, optimized internal type for this case
        var keysAndValues = [String: String]()
        for string in values {
            keysAndValues[string] = string
        }
        type = .enum(String.self, keysAndValues)
        availability = .available
    }

    public override var description: String {
        switch availability {
        case .available:
            return type.description
        case .unavailable:
            return "<unavailable>"
        }
    }

    public override func isEqual(_ object: Any?) -> Bool {
        guard let object = object as? RuntimeType else {
            return false
        }
        if self === object {
            return true
        }
        switch (availability, object.availability) {
        case (.available, .available):
            return type == object.type
        case let (.unavailable(lreason), .unavailable(rreason)):
            return lreason == rreason
        case (.available, _), (.unavailable, _):
            return false
        }
    }

    public override var hash: Int {
        return description.hashValue
    }

    public func cast(_ value: Any) -> Any? {
        guard let value = optionalValue(of: value) else {
            return nil
        }
        if let caster = caster {
            return caster(value)
        }
        func cast(_ value: Any, as type: Any.Type) -> Any? {
            switch type {
            case is NSNumber.Type:
                return value as? NSNumber
            case is CGFloat.Type:
                return value as? CGFloat ??
                    (value as? Double).map { CGFloat($0) } ??
                    (value as? NSNumber).map { CGFloat(truncating: $0) }
            case is Double.Type:
                return value as? Double ??
                    (value as? CGFloat).map { Double($0) } ??
                    (value as? NSNumber).map { Double(truncating: $0) }
            case is Float.Type:
                return value as? Float ??
                    (value as? Double).map { Float($0) } ??
                    (value as? NSNumber).map { Float(truncating: $0) }
            case is Int.Type:
                return value as? Int ??
                    (value as? Double).map { Int($0) } ??
                    (value as? NSNumber).map { Int(truncating: $0) }
            case is UInt.Type:
                return value as? UInt ??
                    (value as? Double).map { UInt($0) } ??
                    (value as? NSNumber).map { UInt(truncating: $0) }
            case is Bool.Type:
                return value as? Bool ??
                    (value as? Double).map { $0 != 0 } ??
                    (value as? NSNumber).map { $0 != 0 }
            case is String.Type,
                 is NSString.Type:
                return value as? String ?? "\(value)"
            case is NSAttributedString.Type:
                return value as? NSAttributedString ?? NSAttributedString(string: "\(value)")
            case is NSArray.Type:
                return value as? NSArray ?? [value] // TODO: validate element types
            case let subtype as AnyClass:
                return (value as AnyObject).isKind(of: subtype) ? value : nil
            case _ where type == Any.self:
                return value
            default:
                if let nsValue = value as? NSValue, sanitizedStructName(String(cString: nsValue.objCType)) == "\(type)" {
                    return value
                }
                return type == Swift.type(of: value) || "\(type)" == "\(Swift.type(of: value))" ? value : nil
            }
        }
        switch type {
        case let .any(subtype), let .options(subtype, _):
            return cast(value, as: subtype)
        case let .class(type):
            if let value = value as? AnyClass, value.isSubclass(of: type) {
                return value
            }
            return nil
        case let .struct(type):
            if let value = value as? NSValue, sanitizedStructName(String(cString: value.objCType)) == type {
                return value
            }
            return nil
        case let .pointer(type):
            switch type {
            case "CGColor" where value is UIColor:
                return (value as! UIColor).cgColor
            case "CGImage" where value is UIImage:
                return (value as! UIImage).cgImage
            case "CGPath":
                if "\(value)".hasPrefix("Path") {
                    return value
                }
                fallthrough
            case "CGColor", "CGImage":
                if "\(value)".hasPrefix("<\(type)") {
                    return value
                }
                return nil
            default:
                return value // No way to validate
            }
        case let .enum(type, enumValues):
            if let value = (cast(value, as: type) as? AnyHashable) ?? (value as? AnyHashable) {
                return enumValues.values.first { $0 == value }?.base
            }
            return nil
        case let .protocol(type):
            return (value as AnyObject).conforms(to: type) ? value : nil
        }
    }

    public func matches(_ type: Any.Type) -> Bool {
        switch self.type {
        case let .any(_type):
            if let lhs = type as? AnyClass, let rhs = _type as? AnyClass {
                return rhs.isSubclass(of: lhs)
            }
            return type == _type || "\(type)" == "\(_type)"
        default:
            return false
        }
    }

    public func matches(_ value: Any) -> Bool {
        return cast(value) != nil
    }
}

// Return the human-readable name, without braces or underscores, etc
private func sanitizedStructName(_ objCType: String) -> String {
    guard let equalRange = objCType.range(of: "="),
        let braceRange = objCType.range(of: "{") else {
        return objCType
    }
    let name: String = String(objCType[braceRange.upperBound ..< equalRange.lowerBound])
    switch name {
    case "_NSRange":
        return "NSRange" // Yay! special cases
    default:
        return name
    }
}

// Converts type name to appropriate selector for lookup on RuntimeType
func sanitizedTypeName(_ typeName: String) -> String {
    var tail = Substring(typeName)
    var head = tail.popFirst().map { String($0.lowercased()) } ?? ""
    while let char = tail.popFirst() {
        if char.isLowercase || tail.first?.isLowercase == true {
            head.append(char)
            break
        }
        head.append(char.lowercased())
    }
    return String(head + tail).replacingOccurrences(of: ".", with: "_")
}
