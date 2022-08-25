//
//  AuthorizationModel.swift
//  Coins
//
//  Created by Дмитрий Виноградов on 25.08.2022.
//

import Foundation

struct User {
    var login: String
    var password: String
}

extension User {
    static var user = User(login: "111", password: "111")
}
