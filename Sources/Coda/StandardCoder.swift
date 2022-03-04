//
//  File.swift
//  
//
//  Created by 楠 on 2022/3/4.
//

import Foundation

// MARK: - Standard Protocols

public protocol StandardEncoder {
    
    associatedtype EncodeType: Encodable
    
    static func encode(value: EncodeType, to encoder: Encoder) throws
}

public protocol StandardDecoder {
    associatedtype DecodeType: Decodable
    
    static func decode(from decoder: Decoder) throws -> DecodeType
}

public protocol StandardCoder: StandardEncoder & StandardDecoder where EncodeType == DecodeType {
    typealias CodingType = EncodeType
}


// MARK: - Standard Wrapper Protocols
public protocol StandardEncoderWrapper: Encodable {
    associatedtype CustomEncoder: StandardEncoder
    
    var wrappedValue: CustomEncoder.EncodeType { get }
}

extension StandardEncoderWrapper {
    public func encode(to encoder: Encoder) throws {
        try CustomEncoder.encode(value: wrappedValue, to: encoder)
    }
}

public protocol StandardDecoderWrapper: Decodable {
    associatedtype CustomDecoder: StandardDecoder
    init(wrappedValue: CustomDecoder.DecodeType)
}

extension StandardDecoderWrapper {
    public init(from decoder: Decoder) throws {
        self.init(wrappedValue: try CustomDecoder.decode(from: decoder))
    }
}

public protocol StandardCoderWrapper: StandardEncoderWrapper & StandardDecoderWrapper where CustomEncoder.EncodeType == CustomDecoder.DecodeType {
    associatedtype CustomCoder: StandardCoder
}
