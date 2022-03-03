//
//  CodablePropertyWrapper.swift
//  
//
//  Created by xj on 2020/5/16.
//

import Foundation

@propertyWrapper
public final class Coda<Value>: Codable {
    private(set) var name: String!
    var val: Value?
    public var wrappedValue: Value {
        set {
            val = newValue
        }
        get {
            val!
        }
    }
    
    init(name: String, defaultValue: Value) {
        self.name = name
        self.wrappedValue = defaultValue
    }
    
    public init(from decoder: Decoder) throws {
        
    }
}


extension Coda {
    public func encode(to encoder: Encoder) throws {
        
    }
}



// init method
public extension Coda where Value: Codable {
    convenience init<Wrapped>(_ ddd: String) where Value == Wrapped? {
        self.init(name: ddd, defaultValue: Wrapped?.none)
    }

    convenience init(key: String, wrappedVal: Value) {
        self.init(name: key, defaultValue: wrappedVal)
    }
    
}

// override  encode
extension KeyedEncodingContainer {
    
    public mutating func encode<T, Value>(_ value: T, forKey key: Key) throws where T: Coda<Value> {
        var rewriteKey = value.name ?? ""
        if rewriteKey == "" {
            rewriteKey = key.stringValue
        }
        if let key = CodaKey(stringValue: rewriteKey), let wrappedValue = value.wrappedValue as? Encodable {
            var container = encoder.container(keyedBy: CodaKey.self)
        }
    }
}
