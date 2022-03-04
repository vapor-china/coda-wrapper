//
//  File.swift
//  
//
//  Created by 楠 on 2022/3/4.
//

import Foundation
import Quick
import Coda


struct FuzzyNameModel: Codable {
    
    @FuzzyName<String>(wrappedValue: "", name: "abc")
    var str: String
}

let fuzzyNameModelMock = FuzzyNameModel(str: "123")
class FuzzyNameEncodingTests: QuickSpec, EncodingTestSpec {
    override func spec() {
        describe("FuzzyNameEncoding") {
            context("JSONEncoder") {
                describe("Rename") {
                   let data = try? jsonEncoder.encode(fuzzyNameModelMock)
                    print(">>>>\n\n \(String(data: data!, encoding: .utf8)) \n\n>>>>")
                }
            }
        }
    }
}

struct DemoCoder: StandardCoder {
    
    static func decode(from decoder: Decoder) throws -> some Decodable {
        <#code#>
    }
}




