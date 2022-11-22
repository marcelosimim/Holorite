//
//  ResultViewController.swift
//  Holorite
//
//  Created by Marcelo Simim Santos on 11/21/22.
//

import UIKit

class ResultViewController: UIViewController, ResultViewDelegate {
    private let resultView = ResultView()
    var salary: Double?
    var discount: Double?

    override func viewDidLoad() {
        super.viewDidLoad()
        resultView.setupCells(salary: salary ?? 0, discount: discount ?? 0)
        resultView.delegate = self
    }

    override func loadView() {
        super.loadView()
        view = resultView
    }

    func didTapClose() {
        dismiss(animated: true)
    }
}
