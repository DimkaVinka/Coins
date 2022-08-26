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
    
    // API-Key -> 07101c86-c534-4d4d-a817-deb5ad7fbd56
    
    private func getURL(coin: String) -> String {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "data.messari.io"
        components.path = "/api/v1/assets/" + coin + "/metrics"
        return components.url?.absoluteString ?? "ERROR"
    }

    func getData(coin: String, completion: @escaping () -> Void) {
        let url = getURL(coin: coin)
        guard let url = URL(string: url) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("x-messari-api-key", forHTTPHeaderField: "07101c86-c534-4d4d-a817-deb5ad7fbd56")
        URLSession.shared.dataTask(with: request) { data, response, error in
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
