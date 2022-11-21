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
    static var background2 = colorBuilder("background2")
    static var border = colorBuilder("border")
    static var cellGrayLabel = colorBuilder("cellGrayLabel")
    static var discountRed = colorBuilder("discountRed")
    static var mainButton = colorBuilder("mainButton")
    static var placeholder = colorBuilder("placeholder")
    static var salary = colorBuilder("salary")
}
