//
//  SceneDelegate.swift
//  Coins
//
//  Created by Дмитрий Виноградов on 25.08.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let viewController = LaunchScreenViewController()
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
    }
    
    func changeRootViewController(viewController: UIViewController, animated: Bool = true, animationOptions: UIView.AnimationOptions) {
        guard let window = window else { return }
            
        window.rootViewController = viewController
        let options: UIView.AnimationOptions = [animationOptions]
            
        UIView.transition(with: window,
                          duration: 0.5,
                          options: options,
                          animations: nil,
                          completion: nil)
    }
}

