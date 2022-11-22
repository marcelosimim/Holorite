//
//  FirstViewTests.swift
//  HoloriteTests
//
//  Created by Marcelo Simim Santos on 11/22/22.
//

@testable import Holorite
import XCTest

final class FirstViewTests: XCTestCase {
    private var sut: FirstView!

    override func setUp() {
        super.setUp()
        sut = FirstView()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

//    func test_didTapCalculate() {
//        sut.delegate = FirstViewDelegateMock()
//    }
}
