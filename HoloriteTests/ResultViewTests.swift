//
//  ResultViewTests.swift
//  HoloriteTests
//
//  Created by Marcelo Simim Santos on 11/22/22.
//

@testable import Holorite
import XCTest

final class ResultViewTests: XCTestCase {
    private var sut: ResultViewProcotol!

    override func setUp() {
        super.setUp()
        sut = ResultView()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }
}
