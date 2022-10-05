//
//  ModuleBuilder.swift
//  Coins
//
//  Created by Дмитрий Виноградов on 26.08.2022.
//

import Foundation
import UIKit

protocol ModuleBuilderProtocol {
    static func moduleAuthorization() -> UIViewController
    static func moduleTableView() -> UIViewController
    static func moduleDetailView() -> UIViewController
}

struct ModuleBuilder: ModuleBuilderProtocol {
    
    static func moduleAuthorization() -> UIViewController {
        let viewController = AuthorizationView()
        return viewController
    }
    
    static func moduleTableView() -> UIViewController {
        let viewController = TableViewView()
        return viewController
    }
    
    static func moduleDetailView() -> UIViewController {
        let viewController = DetailView()
        return viewController
    }
}
