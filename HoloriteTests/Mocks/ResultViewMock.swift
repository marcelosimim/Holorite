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

    var updateTableViewWasCalled = false
    func updateTableView(_ cells: [Holorite.AmountCell]) {
        updateTableViewWasCalled = true
    }
}
