//
//  FirstView.swift
//  Holorite
//
//  Created by Marcelo Simim Santos on 11/21/22.
//

import UIKit

protocol FirstViewDelegate: AnyObject {
    func didTapCalculate(_ salary: Salary, _ discount: Discount)
}

class FirstView: UIView {
    weak var delegate: FirstViewDelegate?
    private var salaryTypedString = ""
    private var discountTypedString = ""

    private lazy var salaryTextField: InputTextField = {
        let textfield = InputTextField()
        textfield.setupView()
        textfield.configure("Salário bruto")
        textfield.keyboardType = .numberPad
        textfield.tag = 0
        textfield.delegate = self
        return textfield
    }()

    private lazy var discountTextField: InputTextField = {
        let textfield = InputTextField()
        textfield.setupView()
        textfield.configure("Descontos")
        textfield.keyboardType = .numberPad
        textfield.tag = 1
        textfield.delegate = self
        return textfield
    }()

    private lazy var calculateButton: MainButton = {
        let button = MainButton()
        button.setupView()
        button.configure(title: "CALCULAR")
        button.addTarget(self, action: #selector(didTapCalculate), for: .touchUpInside)
        return button
    }()

    override func layoutSubviews() {
        let closeKeyboard = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        addGestureRecognizer(closeKeyboard)
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

    @objc private func dismissKeyboard() {
        endEditing(true)
    }

    @objc private func didTapCalculate() {
        let salary = Salary(value: getAmount(salaryTextField.text))
        let discount = Discount(value: getAmount(discountTextField.text))
        delegate?.didTapCalculate(salary, discount)
    }

    private func getAmount(_ stringAmount: String?) -> Double? {
        guard let stringAmount = stringAmount else { return 0 }
        let decimalValue = stringAmount.replacingOccurrences(of: ",", with: ".").replacingOccurrences(of: "R$", with: "")

        return Double(decimalValue)
    }
}

extension FirstView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var amountTypedString = textField.tag == 0 ? salaryTypedString : discountTypedString
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        formatter.decimalSeparator = ","

        if string.count > 0 {
            amountTypedString += string
            let decNumber = NSDecimalNumber(string: amountTypedString).multiplying(by: 0.01)
            textField.text = "R$" + (formatter.string(from: decNumber) ?? "")
        } else {
            amountTypedString = String(amountTypedString.dropLast())
            if amountTypedString.count > 0 {
                let decNumber = NSDecimalNumber(string: amountTypedString).multiplying(by: 0.01)
                textField.text = "R$" + (formatter.string(from: decNumber) ?? "")
            } else {
                textField.text = "R$0,00"
            }
        }

        if textField.tag == 0 {
            salaryTypedString = amountTypedString
        } else {
            discountTypedString = amountTypedString
        }

        return false
    }

    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        if textField.tag == 0 {
            salaryTypedString = ""
        } else {
            discountTypedString = ""
        }
        return true
    }
}
