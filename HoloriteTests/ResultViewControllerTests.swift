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
        sut = ResultViewController(resultView: ResultViewMock())
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
        XCTAssertTrue(view.setupCellsWasCalled)
    }
}
