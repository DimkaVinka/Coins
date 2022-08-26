//
//  TableViewModel.swift
//  Coins
//
//  Created by Дмитрий Виноградов on 26.08.2022.
//

import Foundation
import UIKit

struct CoinModel: Decodable {
    var data: Coin
}

struct Coin: Decodable {
    var symbol, name: String
    var marketData: MarketData
    
    enum CodingKeys: String, CodingKey {
        case symbol, name
        case marketData = "market_data"
    }
}

struct MarketData: Decodable {
    var priceUsd: Double?
    
    enum CodingKeys: String, CodingKey {
        case priceUsd = "price_usd"
    }
}

// MARK: - Force Unwrapped оправдан тем, что изображения находятся в Assets и подразумевается, что оттуда они никуда не денутся!
// Список используемых монет - "btc", "eth", "tron", "luna", "polkadot", "dogecoin", "tether", "stellar", "cardano", "xrp"
extension Coin {
    static let images: [UIImage] = [
        UIImage(named: "btc")!,
        UIImage(named: "eth")!,
        UIImage(named: "tron")!,
        UIImage(named: "luna")!,
        UIImage(named: "polkadot")!,
        UIImage(named: "dogecoin")!,
        UIImage(named: "tether")!,
        UIImage(named: "stellar")!,
        UIImage(named: "cardano")!,
        UIImage(named: "xrp")!
    ]
}
