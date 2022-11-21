//
//  AmountCellTableViewCell.swift
//  Holorite
//
//  Created by Marcelo Simim Santos on 11/21/22.
//

import UIKit

class AmountCellTableViewCell: UITableViewCell {
    static let identifier = "\(AmountCellTableViewCell.self)"
    private var amount: AmountCell?

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.textColor = .black
        return label
    }()

    private lazy var percentageLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textColor = .cellGrayLabel
        return label
    }()

    private lazy var leftStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel, percentageLabel])
        stack.spacing = 2
        stack.axis = .vertical
        return stack
    }()

    private let valueLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .bold)
        return label
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        addViews()
    }

    func configure(_ amount: AmountCell) {
        self.amount = amount
        self.titleLabel.text = amount.title
        setupValueLabel()
        setupPercentageLabel()
    }

    private func addViews() {
        addSubviews([leftStack, valueLabel])
        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            leftStack.centerYAnchor.constraint(equalTo: centerYAnchor),
            leftStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            leftStack.trailingAnchor.constraint(equalTo: valueLabel.trailingAnchor, constant: -10),

            valueLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            valueLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }

    private func setupValueLabel() {
        switch amount?.type {
        case .salary:
            setupSalary()
        case .discount:
            setupDiscount()
        case .none:
            break
        }
    }

    private func setupSalary() {
        valueLabel.text = "R$ \(String(format: "%.2f", amount?.value ?? 0))".replacingOccurrences(of: ".", with: ",")
        valueLabel.textColor = .salary
    }

    private func setupDiscount() {
        guard let value = amount?.value else { return }
        if value.isZero {
            let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: "R$ \(String(format: "%.2f", value ))".replacingOccurrences(of: ".", with: ","))
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSRange(location: 0, length: attributeString.length))
            valueLabel.attributedText = attributeString
            valueLabel.textColor = .cellGrayLabel
        } else {
            valueLabel.text = "R$ \(String(format: "%.2f", value ))".replacingOccurrences(of: ".", with: ",")
            valueLabel.textColor = .discountRed
        }
    }

    private func setupPercentageLabel() {
        guard let percentageDiscount = amount?.discountPercentage else { return }
        if !percentageDiscount.isZero {
            percentageLabel.text = "\(String(format: "%.1f", percentageDiscount))%".replacingOccurrences(of: ".", with: ",")
        }
    }
}
