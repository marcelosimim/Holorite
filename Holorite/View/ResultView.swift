//
//  ResultView.swift
//  Holorite
//
//  Created by Marcelo Simim Santos on 11/21/22.
//

import UIKit

protocol ResultViewDelegate: AnyObject {
    func didTapClose()
}

class ResultView: UIView {
    weak var delegate: ResultViewDelegate?
    private var cells: [AmountCell] = []
    private var salary: Double = 0
    private var discount: Double = 0

    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setTitle("FECHAR", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
        button.addTarget(self, action: #selector(didTapClose), for: .touchUpInside)
        return button
    }()

    private lazy var  tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AmountCellTableViewCell.self, forCellReuseIdentifier: AmountCellTableViewCell.identifier)
        return tableView
    }()

    override func layoutSubviews() {
        backgroundColor = .background2
        addViews()
    }

    private func addViews() {
        addSubviews([closeButton, tableView])
        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: topAnchor, constant: 22),
            closeButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 22),

            tableView.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 28),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }

    @objc private func didTapClose() {
        delegate?.didTapClose()
    }

    func setupCells(salary: Double, discount: Double) {
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

        tableView.reloadData()
    }
}

extension ResultView: UITableViewDelegate, UITableViewDataSource {
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
