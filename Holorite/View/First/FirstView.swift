//
//  FirstView.swift
//  Holorite
//
//  Created by Marcelo Simim Santos on 11/21/22.
//

import UIKit

class FirstView: UIView {
    let salaryTextField: InputTextField = {
        let textfield = InputTextField()
        textfield.setupView()
        textfield.configure("Salário bruto")
        textfield.keyboardType = .numberPad
        return textfield
    }()

    let discountTextField: InputTextField = {
        let textfield = InputTextField()
        textfield.setupView()
        textfield.configure("Descontos")
        textfield.keyboardType = .numberPad
        return textfield
    }()

    let calculateButton: MainButton = {
        let button = MainButton()
        button.setupView()
        button.configure(title: "CALCULAR")
        return button
    }()

    override func layoutSubviews() {
        backgroundColor = .background
        addViews()
    }

    private func addViews() {
        addSubviews([salaryTextField, discountTextField, calculateButton])
        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            salaryTextField.topAnchor.constraint(equalTo: topAnchor, constant: 137),
            salaryTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            salaryTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
            salaryTextField.heightAnchor.constraint(equalToConstant: 44),

            discountTextField.topAnchor.constraint(equalTo: salaryTextField.bottomAnchor, constant: 21),
            discountTextField.leadingAnchor.constraint(equalTo: salaryTextField.leadingAnchor),
            discountTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
            discountTextField.heightAnchor.constraint(equalToConstant: 44),

            calculateButton.topAnchor.constraint(equalTo: discountTextField.bottomAnchor, constant: 22),
            calculateButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 120),
            calculateButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            calculateButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
}
