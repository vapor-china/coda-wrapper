//
//  File.swift
//  
//
//  Created by 楠 on 2022/3/2.
//

import Foundation

// variable name convert
extension String {
    private var isSnake: Bool {
        return contains("_")
    }
    
    private func snakeToCamel() -> String {
        var words = components(separatedBy: "_").compactMap { $0.isEmpty ? nil : $0 }
        words = words.map {
            $0.capitalizingFirstLetter()
        }
        return words.joined()
    }
    private func camelToSnake() -> String {
        var vArr = Array(self)
        for (i,v) in vArr.enumerated().reversed() {
            if v.isUppercase {
                let r = v.lowercased()
                vArr[i] = String.Element("\(r)")
                if i > 0 {
                    vArr.insert("_", at: i)}
            }
        }
        return String(vArr)
    }
    
    func variableNameConvert() -> String {
        return isSnake ? snakeToCamel() : camelToSnake()
    }
}

// string ext
extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
