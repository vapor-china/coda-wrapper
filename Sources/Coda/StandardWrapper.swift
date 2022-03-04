//
//  File.swift
//  
//
//  Created by 楠 on 2022/3/4.
//

import Foundation

public struct EncodeCoda<CustomEncoder: StandardEncoder>: StandardEncoderWrapper {
    public var wrappedValue: CustomEncoder.EncodeType
    public init(wrappedValue: CustomEncoder.EncodeType) {
        self.wrappedValue = wrappedValue
    }
}

public struct DecodeCoda<CustomDecoder: StandardDecoder>: StandardDecoderWrapper {
    public var wrappedValue: CustomDecoder.DecodeType
    public init(wrappedValue: CustomDecoder.DecodeType) {
        self.wrappedValue = wrappedValue
    }
}

public struct StandardCoda<CustomCoder: StandardCoder>: StandardCoderWrapper {
    public typealias CustomEncoder = CustomCoder
    public typealias CustomDecoder = CustomCoder
    
    public var wrappedValue: CustomCoder.CodingType
    public init(wrappedValue: CustomCoder.CodingType) {
        self.wrappedValue = wrappedValue
    }
    
}

public protocol EncodeTransformer: Encodable {
    associatedtype ValueType: Encodable
    var wrappedValue: ValueType { get }
}

//public protocol FuzzyNameProvider: StandardEncoder {
//    var name: String? { get }
//}
//extension FuzzyNameProvider {
//    public static func encode(value: EncodeType, to encoder: Encoder) throws {
//
//
//        let container = encoder.container(keyedBy: CodaKey.self)
//        value.encode(to: container)
//    }
//}
//extension Encodable {
//    func encode<K>(to container: inout KeyedEncodingContainer<K>, forKey key: KeyedEncodingContainer<K>.Key) throws {
//        try container.encode(self, forKey: key)
//    }
//}

// Rename Wrapper

@propertyWrapper
public struct FuzzyName<CustomEncoder: StandardEncoder>: FuzzyNameWrapper {
    public var name: String?
    
    public let wrappedValue: CustomEncoder.EncodeType

    public init(wrappedValue: CustomEncoder.EncodeType, name: String? = nil) {
        self.name = name
        self.wrappedValue = wrappedValue
    }
}

//extension FuzzyName: Encodable {}
//extension FuzzyName: Decodable {}

public protocol FuzzyNameWrapper: StandardEncoderWrapper & StandardEncoderWrapper {
    var name: String? { get }
}

extension KeyedEncodingContainer {
    public mutating func encode<T>(_ value: T, forKey key: KeyedEncodingContainer<K>.Key) throws where T: Encodable, T: FuzzyNameWrapper {
//        return try decodeIfPresent(T.self, forKey: key) ?? T(wrappedValue: nil)
        var rewriteKey = value.name ?? ""
                if rewriteKey == "" {
                    rewriteKey = key.stringValue
                }

        if let codaKey = CodaKey(stringValue: rewriteKey), let key = codaKey as? K {
            try encodeIfPresent(value.wrappedValue, forKey: key)
        } else {
            print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>\n  renaem key failed \n>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
            try encodeIfPresent(value.wrappedValue, forKey: key)
        }
    }
}

extension KeyedDecodingContainer {
    public func decode<T>(_ tpe: T.Type, forKey key: KeyedDecodingContainer<K>.Key) throws where T: Decodable, T: FuzzyNameWrapper {
        
    }
}

