//
//  TableViewViewModel.swift
//  Coins
//
//  Created by Дмитрий Виноградов on 26.08.2022.
//

import Foundation
import Combine
import UIKit

enum Sorting {
    case ascendingByUSDPrice
    case dropUSDPerTast1Hour
    case dropUSDPerLast24Hours
}

class TableViewViewModel {
    @Published var coins: [Coin] = []
    var checkCoinsData: [Coin] = []
    @Published private(set) var coinsImages: [UIImage] = []
    
    private let networkManager = NetworkManager.shared
    
    func getData() {
        self.coins = networkManager.coins
        self.checkCoinsData = networkManager.coins
        self.coinsImages = Coin.images
    }
    
    func sortCoins(tableView: UITableView, sortType: Sorting) {
        switch sortType {
        case .ascendingByUSDPrice:
            self.coins.sort { $0.marketData.priceUsd ?? 0 < $1.marketData.priceUsd ?? 0 }
            tableView.reloadData()
        case .dropUSDPerTast1Hour:
            self.coins.sort { $0.marketData.percentChangeUsdLast1_Hour ?? 0 < $1.marketData.percentChangeUsdLast1_Hour ?? 0 }
            tableView.reloadData()
        case .dropUSDPerLast24Hours:
            self.coins.sort { $0.marketData.percentChangeUsdLast24_Hours ?? 0 < $1.marketData.percentChangeUsdLast24_Hours ?? 0 }
            tableView.reloadData()
        }
    }
}
