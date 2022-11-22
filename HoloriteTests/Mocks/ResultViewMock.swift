//
//  ResultViewMock.swift
//  HoloriteTests
//
//  Created by Marcelo Simim Santos on 11/22/22.
//

@testable import Holorite
import Foundation
import UIKit

class ResultViewMock: UIView, ResultViewProcotol {
    var delegate: ResultViewDelegate? = nil

    var setupCellsWasCalled = false
    func setupCells(salary: Double, discount: Double) {
        setupCellsWasCalled = true
    }
}
