//
//  ResultViewController.swift
//  Holorite
//
//  Created by Marcelo Simim Santos on 11/21/22.
//

import UIKit

protocol ResultViewControllerDelegate: AnyObject {
    func didTapClose()
}

class ResultViewController: UIViewController {
    private let resultView = ResultView()
    private var cells: [AmountCell] = []
    weak var delegate: ResultViewControllerDelegate?
    var salary: Double?
    var discount: Double?

    override func viewDidLoad() {
        super.viewDidLoad()
        view = resultView
        setupTableView()
        setupButtons()
        setupCells()
    }

    private func setupTableView() {
        resultView.tableView.delegate = self
        resultView.tableView.dataSource = self
    }

    private func setupButtons() {
        resultView.closeButton.addTarget(self, action: #selector(didTapClose), for: .touchUpInside)
    }

    private func setupCells() {
        guard let salary = salary else { return }
        cells.append(AmountCell(discountPercentage: 0, value: salary, title: "Salário Bruto", type: .salary))
        cells.append(AmountCell(discountPercentage: 0, value: discount ?? 0, title: "Descontos", type: .discount))
        calculateINSS()
    }

    private func calculateINSS() {
        guard let salary = salary else { return }
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
        guard let salary = salary else { return }
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
        guard let salary = salary else { return }
        let finalSalary = salary - (cells[1].value) - (cells[2].value) - (cells[3].value)
        cells.append(AmountCell(discountPercentage: 0, value: finalSalary, title: "Salário Liquido", type: .salary))

        resultView.tableView.reloadData()
    }

    @objc private func didTapClose() {
        delegate?.didTapClose()
    }
}

extension ResultViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cells.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AmountCellTableViewCell.identifier, for: indexPath) as? AmountCellTableViewCell else { fatalError() }
        let amount = cells[indexPath.row]

        cell.configure(amount)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
}
