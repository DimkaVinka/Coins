//
//  TableViewModel.swift
//  Coins
//
//  Created by Дмитрий Виноградов on 26.08.2022.
//

import Foundation
import UIKit

struct MainCoinModel {
    var coin: [Coin]
    var coinImage: [UIImage]
}

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
    var priceBtc: Double?
    var priceEth: Double?
    var percentChangeUsdLast1_Hour, percentChangeBtcLast1_Hour, percentChangeEthLast1_Hour: Double?
    var percentChangeUsdLast24_Hours, percentChangeBtcLast24_Hours, percentChangeEthLast24_Hours: Double?
    
    enum CodingKeys: String, CodingKey {
        case priceUsd = "price_usd"
        case priceBtc = "price_btc"
        case priceEth = "price_eth"
        case percentChangeUsdLast1_Hour = "percent_change_usd_last_1_hour"
        case percentChangeBtcLast1_Hour = "percent_change_btc_last_1_hour"
        case percentChangeEthLast1_Hour = "percent_change_eth_last_1_hour"
        case percentChangeUsdLast24_Hours = "percent_change_usd_last_24_hours"
        case percentChangeBtcLast24_Hours = "percent_change_btc_last_24_hours"
        case percentChangeEthLast24_Hours = "percent_change_eth_last_24_hours"
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
