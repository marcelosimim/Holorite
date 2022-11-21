//
//  ResultView.swift
//  Holorite
//
//  Created by Marcelo Simim Santos on 11/21/22.
//

import UIKit

class ResultView: UIView {
    let closeButton: UIButton = {
        let button = UIButton()
        button.setTitle("FECHAR", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
        return button
    }()

    let tableView: UITableView = {
        let tableView = UITableView()
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
}
