//
//  UIView+Extensions.swift
//  Coins
//
//  Created by Дмитрий Виноградов on 25.08.2022.
//

import UIKit

extension UIView {
    func addSubviews(_ subViews: [UIView]) {
        subViews.forEach { addSubview($0) }
    }
}

extension UIStackView {
    func addArrangedSubviews(_ subView: [UIView]) {
        subView.forEach { addArrangedSubview($0) }
    }
}
