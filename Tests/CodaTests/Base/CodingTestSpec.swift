//
//  File.swift
//  
//
//  Created by 楠 on 2022/3/4.
//

import Foundation

protocol CodingTestSpec {

}
extension CodingTestSpec {

    static var emptyJSON: String { "{\n\n}" }
    static var emptyPList: String { """
        <?xml version="1.0" encoding="UTF-8"?>
        <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
        <plist version="1.0">
            <dict/>
        </plist>
        """
    }
}
