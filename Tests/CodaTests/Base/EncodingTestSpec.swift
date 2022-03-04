//
//  File.swift
//  
//
//  Created by 楠 on 2022/3/4.
//

import Foundation

protocol EncodingTestSpec: CodingTestSpec {
    var jsonEncoder: JSONEncoder { get }
    var plistEncoder: PropertyListEncoder { get }
}

extension EncodingTestSpec {
    var jsonEncoder: JSONEncoder {
            let encoder = JSONEncoder()
    //        if #available(OSX 10.13, *) {
    //            encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
    //        } else {
                encoder.outputFormatting = [.prettyPrinted]
    //        }
            return encoder
        }

    var plistEncoder: PropertyListEncoder {
        let encoder = PropertyListEncoder()
        encoder.outputFormat = .xml
        return encoder
    }
}
