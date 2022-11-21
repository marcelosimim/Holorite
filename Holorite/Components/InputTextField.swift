//
//  InputTextField.swift
//  Holorite
//
//  Created by Marcelo Simim Santos on 11/21/22.
//

import UIKit

class InputTextField: UITextField {
    private let padding = UIEdgeInsets(top: 0, left: 11, bottom: 0, right: 11)

    func setupView() {
        setupLayer()
        setupColors()
    }

    func configure(_ placeholder: String) {
        attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.placeholder]
        )
    }

    private func setupLayer() {
        layer.cornerRadius = 8
        layer.borderWidth = 1
    }

    private func setupColors() {
        backgroundColor = .white
        layer.borderColor = UIColor.border.cgColor
    }

}

extension InputTextField {
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
