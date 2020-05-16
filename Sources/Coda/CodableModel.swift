//
//  File.swift
//  
//
//  Created by xj on 2020/5/16.
//

import Foundation
public protocol CodableModel {
    init(from decoder: Decoder) throws
}

extension CodableModel where Self: Codable {
    public func deco(decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodaKey.self)
        for child in Mirror(reflecting: self).children {
            guard let flag = child.value as? CodableProtocol else {
                continue
            }
            try flag.decodeValue(from: container)
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodaKey.self)

        for child in Mirror(reflecting: self).children {

            guard let flag = child.value as? CodableProtocol else {
                continue
            }
            try flag.encodeValue(from: &container)
        }
    }
}
