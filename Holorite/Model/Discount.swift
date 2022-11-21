//
//  Discount.swift
//  Holorite
//
//  Created by Marcelo Simim Santos on 11/21/22.
//

import Foundation

struct Discount {
    var value: Double?

    func isValid() -> Bool {
        guard let value = value else { return true }
        return value.isGreaterThanOrEqualTo(0)
    }
}
