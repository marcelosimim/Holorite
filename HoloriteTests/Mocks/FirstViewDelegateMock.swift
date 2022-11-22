//
//  FirstViewDelegateMock.swift
//  HoloriteTests
//
//  Created by Marcelo Simim Santos on 11/22/22.
//

@testable import Holorite
import Foundation

class FirstViewDelegateMock: FirstViewDelegate {

    var didTapCalculateWasCalled = false
    func didTapCalculate(_ salary: Holorite.Salary, _ discount: Holorite.Discount) {
        didTapCalculateWasCalled = true
    }
}
