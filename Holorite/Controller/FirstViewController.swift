//
//  FirstViewController.swift
//  Holorite
//
//  Created by Marcelo Simim Santos on 11/21/22.
//

import UIKit

class FirstViewController: UIViewController, ResultViewControllerDelegate  {
    private let firstView = FirstView()
    private var salaryTypedString = ""
    private var discountTypedString = ""


    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTextFields()
        setupButtons()
    }

    func didTapClose() {
        dismiss(animated: true)
    }

    private func setupView() {
        title = "Holerite"
        view = firstView

        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor.white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }

    private func setupTextFields() {
        firstView.salaryTextField.delegate = self
        firstView.discountTextField.delegate = self

        let closeKeyboard = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(closeKeyboard)
    }

    private func setupButtons() {
        firstView.calculateButton.addTarget(self, action: #selector(didTapCalculate), for: .touchUpInside)
    }

    @objc private func didTapCalculate() {
        let salary = Salary(value: getAmount(firstView.salaryTextField.text))
        let discount = Discount(value: getAmount(firstView.discountTextField.text))

        if salary.isValid() && discount.isValid() {
            let resultViewController = ResultViewController()
            resultViewController.salary = salary.value
            resultViewController.discount = discount.value
            resultViewController.delegate = self
            present(resultViewController, animated: true)
        }
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }

    private func getAmount(_ stringAmount: String?) -> Double? {
        guard let stringAmount = stringAmount else { return 0 }
        let decimalValue = stringAmount.replacingOccurrences(of: ",", with: ".").replacingOccurrences(of: "R$", with: "")

        return Double(decimalValue)
    }
}

extension FirstViewController: UITextFieldDelegate {
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
