//
//  AuthorizationViewModel.swift
//  Coins
//
//  Created by Дмитрий Виноградов on 25.08.2022.
//

import Foundation
import Combine

class AuthorizationViewModel {
    
    // MARK: - Login and Password variables
    
    @Published private(set) var login: String = ""
    @Published private(set) var password: String = ""
    
    // MARK: - Methods
    
    func getUser() {
        let userData = UserDefaults.standard.object(forKey: "user") as? [String: String] ?? ["": ""]
        login = userData.keys.first ?? ""
        password = userData.values.first ?? ""
    }
}
