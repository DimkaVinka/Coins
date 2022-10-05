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
    @Published private(set) var isLogged: Bool = false
    
    // MARK: - Methods
    
    func getUser() {
        login = UserDefaults.standard.string(forKey: "login") ?? ""
        password = UserDefaults.standard.string(forKey: "password") ?? ""
        isLogged = UserDefaults.standard.bool(forKey: "isLogged")
    }
}
