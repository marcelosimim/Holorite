//
//  FirstViewController.swift
//  Holorite
//
//  Created by Marcelo Simim Santos on 11/21/22.
//

import UIKit

class FirstViewController: UIViewController, FirstViewDelegate {
    private let firstView = FirstView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func loadView() {
        super.loadView()
        setupView()
    }

    private func setupView() {
        title = "Holerite"
        view = firstView
        firstView.delegate = self

        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor.white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }

    func didTapCalculate(_ salary: Salary, _ discount: Discount) {
        if salary.isValid() && discount.isValid() {
            let resultViewController = ResultViewController()
            resultViewController.salary = salary.value
            resultViewController.discount = discount.value
            present(resultViewController, animated: true)
        }
    }
}
