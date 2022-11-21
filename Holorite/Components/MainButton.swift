//
//  MainButton.swift
//  Holorite
//
//  Created by Marcelo Simim Santos on 11/21/22.
//

import UIKit

class MainButton: UIButton {
    func setupView() {
        setupLayer()
        setupColors()
        setupFonts()
    }

    func configure(title: String) {
        setTitle(title, for: .normal)
    }

    private func setupLayer() {
        layer.cornerRadius = 8
    }

    private func setupColors() {
        backgroundColor = .mainButton
    }

    private func setupFonts() {
        titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
    }
}
