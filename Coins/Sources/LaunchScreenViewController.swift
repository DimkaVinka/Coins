//
//  ViewController.swift
//  Coins
//
//  Created by Дмитрий Виноградов on 25.08.2022.
//

import UIKit
import SnapKit

class LaunchScreenViewController: UIViewController {
    
    // MARK: - Outlets
    
    private lazy var image: UIImageView = {
        let image = UIImage(named: "launchImage")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        imageView.alpha = 0.2
        return imageView
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Coins App"
        label.font = UIFont.systemFont(ofSize: 40, weight: .black)
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowOpacity = 0.3
        label.layer.shadowOffset = .zero
        label.layer.shadowRadius = 10
        label.layer.shouldRasterize = true
        label.layer.rasterizationScale = UIScreen.main.scale
        return label
    }()
    
    // MARK: - Lifycycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemYellow
        setupHierarchy()
        setupLayout()
        
        // Задержка Запуска
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            if UserDefaults.standard.bool(forKey: "isLogged") == true {
                let viewController = ModuleBuilder.moduleTableView()
                let navigationController = UINavigationController(rootViewController: viewController)
                SceneDelegate
                    .shared
                    .changeRootViewController(viewController: navigationController,
                                              animationOptions: .transitionCrossDissolve)
            } else {
                SceneDelegate
                    .shared
                    .changeRootViewController(viewController: ModuleBuilder.moduleAuthorization(),
                                              animationOptions: .transitionCrossDissolve)
            }
        }
    }
    
    // MARK: - Setup
    
    private func setupHierarchy() {
        view.addSubviews([
        image, label
        ])
    }
    
    private func setupLayout() {
        image.snp.makeConstraints { make in
            make.left.top.right.bottom.equalTo(view)
            make.center.equalTo(view)
        }
        
        label.snp.makeConstraints { make in
            make.center.equalTo(view)
        }
    }
}

