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

protocol ResultViewProcotol {
    var delegate: ResultViewDelegate? { get set }
    func updateTableView(_ cells: [AmountCell])
}

class ResultView: UIView, ResultViewProcotol {
    private var cells: [AmountCell] = []
    weak var delegate: ResultViewDelegate?

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

    func updateTableView(_ cells: [AmountCell]) {
        self.cells = cells
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
