//
//  File.swift
//  
//
//  Created by Spec on 2020/5/17.
//

import Foundation

protocol CodableProtocol {
    typealias DecodeContainer = KeyedDecodingContainer<CodaKey>
    typealias EncodeContainer = KeyedEncodingContainer<CodaKey>
    func decodeValue(from container: DecodeContainer) throws
    func encodeValue(from container: inout EncodeContainer) throws
}

extension Coda: CodableProtocol where Value: Codable {
    
    func decodeValue(from container: DecodeContainer) throws {
        let key = CodaKey(name: name)
        if let value = try container.decodeIfPresent(Value.self, forKey: key) {
            wrappedValue = value
        }
    }
    
    func encodeValue(from container: inout EncodeContainer) throws {
        
        let key = CodaKey(name: name)
        
        try container.encode(wrappedValue, forKey: key)
    }
}
