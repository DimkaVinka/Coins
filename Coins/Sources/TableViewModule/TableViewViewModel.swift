//
//  TableViewViewModel.swift
//  Coins
//
//  Created by Дмитрий Виноградов on 26.08.2022.
//

import Foundation
import Combine
import UIKit

class TableViewViewModel {
    @Published private(set) var coins: [Coin] = []
    @Published private(set) var coinsImages: [UIImage] = []
    
    private let networkManager = NetworkManager.shared
    
    func getData() {
        self.coins = networkManager.coins
        self.coinsImages = Coin.images
    }
}
