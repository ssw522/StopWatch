//
//  String+.swift
//  Receive
//
//  Created by iOS신상우 on 7/27/24.
//

import Foundation

extension String {
    public var isNotEmpty: Bool {
        !isEmpty
    }
}

extension Substring {
    public var asString: String {
        String(self)
    }
}
