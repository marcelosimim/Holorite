//
//  ResultViewControllerTests.swift
//  HoloriteTests
//
//  Created by Marcelo Simim Santos on 11/22/22.
//

@testable import Holorite
import XCTest

final class ResultViewControllerTests: XCTestCase {
    private var sut: ResultViewController!

    override func setUp() {
        super.setUp()
        sut = ResultViewController(resultView: ResultViewMock(), salary: 5000, discount: 50)
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_loadView() {
        sut.loadView()
        XCTAssertTrue(sut.view is ResultViewMock)
    }

    func test_viewDidLoad() {
        guard let view = sut.view as? ResultViewMock else {
            XCTFail()
            return
        }
        sut.viewDidLoad()

        XCTAssertNotNil(view.delegate)
    }

    func test_setupCellForFirstRange() {
        guard let view = sut.view as? ResultViewMock else {
            XCTFail()
            return
        }
        sut = ResultViewController(resultView: ResultViewMock(), salary: 1000, discount: 50)
        sut.viewDidLoad()

        XCTAssertTrue(view.updateTableViewWasCalled)
    }

    func test_setupCellForSecondRange() {
        guard let view = sut.view as? ResultViewMock else {
            XCTFail()
            return
        }
        sut = ResultViewController(resultView: ResultViewMock(), salary: 2000, discount: 50)
        sut.viewDidLoad()

        XCTAssertTrue(view.updateTableViewWasCalled)
    }

    func test_setupCellForThirdRange() {
        guard let view = sut.view as? ResultViewMock else {
            XCTFail()
            return
        }
        sut = ResultViewController(resultView: ResultViewMock(), salary: 3000, discount: 50)
        sut.viewDidLoad()

        XCTAssertTrue(view.updateTableViewWasCalled)
    }

    func test_setupCellForFourthRange() {
        guard let view = sut.view as? ResultViewMock else {
            XCTFail()
            return
        }
        sut = ResultViewController(resultView: ResultViewMock(), salary: 4000, discount: 50)
        sut.viewDidLoad()

        XCTAssertTrue(view.updateTableViewWasCalled)
    }
}
