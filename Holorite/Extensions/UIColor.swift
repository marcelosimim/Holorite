//
//  UIColor.swift
//  Holorite
//
//  Created by Marcelo Simim Santos on 11/21/22.
//

import UIKit

extension UIColor {
    static func colorBuilder(_ colorName: String) -> UIColor {
        UIColor(named: colorName) ?? .clear
    }
}

extension UIColor {
    static var background = colorBuilder("background")
}
