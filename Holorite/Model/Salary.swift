//
//  Salary.swift
//  Holorite
//
//  Created by Marcelo Simim Santos on 11/21/22.
//

import Foundation

struct Salary {
    var value: Double?

    func isValid() -> Bool {
        guard let value = value else { return false }
        return value.isGreater(than: 0)
    }
}
