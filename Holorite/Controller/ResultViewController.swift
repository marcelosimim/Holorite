//
//  ResultViewController.swift
//  Holorite
//
//  Created by Marcelo Simim Santos on 11/21/22.
//

import UIKit

class ResultViewController: UIViewController, ResultViewDelegate {
    private var resultView: ResultViewProcotol
    var salary: Double?
    var discount: Double?

    init(resultView: ResultViewProcotol = ResultView()) {
        self.resultView = resultView
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        resultView.setupCells(salary: salary ?? 0, discount: discount ?? 0)
        resultView.delegate = self
    }

    override func loadView() {
        super.loadView()
        view = resultView as? UIView
    }

    func didTapClose() {
        dismiss(animated: true)
    }
}
