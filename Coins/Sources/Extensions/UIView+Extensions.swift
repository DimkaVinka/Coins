//
//  UIView+Extensions.swift
//  Coins
//
//  Created by Дмитрий Виноградов on 25.08.2022.
//

import UIKit

extension UIView {
    func addSubviews(_ subViews: [UIView]) {
        subviews.forEach { addSubview($0) }
    }
}
