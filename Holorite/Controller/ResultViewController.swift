//
//  ResultViewController.swift
//  Holorite
//
//  Created by Marcelo Simim Santos on 11/21/22.
//

import UIKit

class ResultViewController: UIViewController, ResultViewDelegate {
    private var resultView: ResultViewProcotol
    private var cells: [AmountCell] = []
    private let salary: Double
    private let discount: Double

    init(resultView: ResultViewProcotol = ResultView(), salary: Double, discount: Double) {
        self.resultView = resultView
        self.salary = salary
        self.discount = discount
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        resultView.delegate = self
        setupCells()
    }

    override func loadView() {
        super.loadView()
        view = resultView as? UIView
    }

    func didTapClose() {
        dismiss(animated: true)
    }

    private func setupCells() {
        cells.append(AmountCell(discountPercentage: 0, value: salary, title: "Salário Bruto", type: .salary))
        cells.append(AmountCell(discountPercentage: 0, value: discount, title: "Descontos", type: .discount))
        calculateINSS()
    }

    private func calculateINSS() {
        var inssDiscount = 0.0

        if salary.isLess(than: 1212) {
            inssDiscount = 0.075
        } else if salary.isLess(than: 2427.35) {
            inssDiscount = 0.09
        } else if salary.isLess(than: 3641.03) {
            inssDiscount = 0.12
        } else {
            inssDiscount = 0.14
        }

        cells.append(AmountCell(discountPercentage: inssDiscount*100, value: salary*inssDiscount, title: "Desconto INSS", type: .discount))
        calculateIRRF()
    }

    private func calculateIRRF() {
        var irrfDiscount = 0.0

        if salary.isGreater(than: 1903.98) && salary.isLess(than: 2826.65) {
            irrfDiscount = 0.075
        } else if salary.isLess(than: 3751.06) {
            irrfDiscount = 0.15
        } else if salary.isLess(than: 4664.68) {
            irrfDiscount = 0.225
        } else {
            irrfDiscount = 0.275
        }

        cells.append(AmountCell(discountPercentage: irrfDiscount*100, value: salary*irrfDiscount, title: "Desconto IRRF", type: .discount))
        deductedSalary()
    }

    private func deductedSalary() {
        let finalSalary = salary - (cells[1].value) - (cells[2].value) - (cells[3].value)
        cells.append(AmountCell(discountPercentage: 0, value: finalSalary, title: "Salário Liquido", type: .salary))

        resultView.updateTableView(cells)
    }
}
