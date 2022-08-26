//
//  AppDelegate.swift
//  Coins
//
//  Created by Дмитрий Виноградов on 25.08.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        saveUser()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        
    }
    
    private func saveUser() {
        UserDefaults.standard.register(defaults: ["login": "111"])
        UserDefaults.standard.register(defaults: ["password": "111"])
        UserDefaults.standard.register(defaults: ["isLogged": false])
        
        let coins = ["btc", "eth", "tron", "luna", "polkadot", "dogecoin", "tether", "stellar", "cardano", "xrp"]
        let group = DispatchGroup()
        for coin in coins {
            group.enter()
                NetworkManager.shared.getData(coin: coin) {
                group.leave()
            }
        }
        group.notify(queue: .main) {
            print("Done!")
        }
    }

}

