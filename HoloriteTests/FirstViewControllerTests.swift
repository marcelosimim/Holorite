//
//  FirstViewControllerTests.swift
//  HoloriteTests
//
//  Created by Marcelo Simim Santos on 11/22/22.
//

@testable import Holorite
import XCTest

final class FirstViewControllerTests: XCTestCase {
    private var sut: FirstViewController!

    override func setUp() {
        super.setUp()
        sut = FirstViewController()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_loadView() {
        sut.loadView()
        XCTAssertTrue(sut.view is FirstView)
    }

    func test_viewDidLoad() {
        let view = sut.view as? FirstView
        sut.viewDidLoad()
        XCTAssertNotNil(view?.delegate)
        XCTAssertEqual(sut.title, "Holerite")
    }

//    func test_didTapCalculate() {
//        let salary = Salary(value: 5000)
//        let discount = Discount(value: 50)
//
//        sut.didTapCalculate(salary, discount)
//    }
}
