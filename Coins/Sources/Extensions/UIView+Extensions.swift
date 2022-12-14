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

extension UIImage {
    
    func blur(_ radius: Double) -> UIImage? {
        if let img = CIImage(image: self) {
            return UIImage(ciImage: img.applyingGaussianBlur(sigma: radius))
        }
        return nil
    }
}
