//
//  NetworkManager.swift
//  Coins
//
//  Created by Дмитрий Виноградов on 26.08.2022.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    var coins: [Coin] = []
    
    private func getURL(coin: String) -> String {
        return "https://data.messari.io/api/v1/assets/" + coin + "/metrics"
    }

    func getData(coin: String, completion: @escaping () -> Void) {
        let url = getURL(coin: coin)
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                print("ERROR")
            } else if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                guard let data = data else { return }
                
                do {
                    let json = try JSONDecoder().decode(CoinModel.self, from: data)
                    self.coins.append(json.data)
                    completion()
                } catch let jsonError {
                    print(jsonError)
                }
            }
        }.resume()
    }
}
