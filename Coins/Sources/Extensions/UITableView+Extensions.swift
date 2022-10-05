//
//  UITableView+Extensions.swift
//  Coins
//
//  Created by Дмитрий Виноградов on 05.10.2022.
//

import UIKit

extension UITableView {
    func isLastVisibleCell(at indexPath: IndexPath) -> Bool {
        guard let lastIndexPath = indexPathsForVisibleRows?.last else {
            return false
        }

        return lastIndexPath == indexPath
    }
}
