//
//  AuthorizationView.swift
//  Coins
//
//  Created by Дмитрий Виноградов on 25.08.2022.
//

import UIKit
import SnapKit
import Combine

class AuthorizationView: UIViewController {
    
    private var viewModel = AuthorizationViewModel()
    private var loginObserver, passwordObserver: AnyCancellable?
    private var login, password: String?
    
    // MARK: MainView Outlets
    
    private lazy var mainImage: UIImageView = {
        let image = UIImage(named: "launchImage")?.blur(10)
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        imageView.alpha = 0.2
        return imageView
    }()
    
    private lazy var mainView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var mainDivider: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    // MARK: - LoginView Outlets
    
    private lazy var loginStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.alignment = .leading
        return stack
    }()
    
    private lazy var loginDivider: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    private lazy var loginLabel: UILabel = {
        let label = UILabel()
        label.text = "Login"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private lazy var loginTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Type your login here (111)"
        textField.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        textField.addTarget(self, action: #selector(buttonPressed), for: UIControl.Event.primaryActionTriggered)
        return textField
    }()
    
    // MARK: - PasswordView Outlets
    
    private lazy var passwordStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.alignment = .leading
        return stack
    }()
    
    private lazy var passwordDivider: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    private lazy var passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "Password"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Type your password here (111)"
        textField.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        textField.addTarget(self, action: #selector(buttonPressed), for: UIControl.Event.primaryActionTriggered)
        return textField
    }()
    
    // MARK: - Button Outlets
    
    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        button.layer.cornerRadius = 20
        button.tintColor = .black
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.3
        button.layer.shadowOffset = .zero
        button.layer.shadowRadius = 10
        button.layer.shouldRasterize = true
        button.layer.rasterizationScale = UIScreen.main.scale
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemYellow
        viewModel.getUser()
        loginObserver = viewModel.$login.sink(receiveValue: { login in
            self.login = login
        })
        passwordObserver = viewModel.$password.sink(receiveValue: { password in
            self.password = password
        })
        setupHierarchy()
        setupLayout()
        setupKeyboard()
    }
    
    // MARK: SetupHierarchy
    
    private func setupHierarchy() {
        view.addSubviews([
            mainImage, mainView, mainDivider
        ])
        
        mainView.addSubviews([
        loginStack, passwordStack, button
        ])
        
        loginStack.addArrangedSubviews([
        loginLabel, loginTextField, loginDivider
        ])
        
        passwordStack.addArrangedSubviews([
        passwordLabel, passwordTextField, passwordDivider
        ])
    }
    
    // MARK: - SetupLayout
    
    private func setupLayout() {
        
        mainImage.snp.makeConstraints { make in
            make.left.top.right.bottom.equalTo(view)
            make.center.equalTo(view)
        }
        
        mainView.snp.makeConstraints { make in
            make.center.equalTo(view)
            make.top.equalTo(view)
            make.right.bottom.left.equalTo(view)
        }
        
        mainDivider.snp.makeConstraints { make in
            make.left.right.equalTo(view)
            make.height.equalTo(1)
            make.top.equalTo(mainImage.snp.bottom)
        }
        
        loginStack.snp.makeConstraints { make in
            make.centerX.equalTo(mainView)
            make.left.equalTo(mainView).offset(50)
            make.right.equalTo(mainView).inset(50)
            make.centerY.equalTo(view)
            make.height.equalTo(70)
        }
        
        passwordStack.snp.makeConstraints { make in
            make.centerX.equalTo(mainView)
            make.left.equalTo(mainView).offset(50)
            make.right.equalTo(mainView).inset(50)
            make.top.equalTo(loginStack.snp.bottom).offset(30)
            make.height.equalTo(70)
        }
        
        loginDivider.snp.makeConstraints { make in
            make.width.equalTo(loginStack.snp.width)
            make.height.equalTo(1)
        }
        
        passwordDivider.snp.makeConstraints { make in
            make.width.equalTo(passwordStack.snp.width)
            make.height.equalTo(1)
        }
        
        button.snp.makeConstraints { make in
            make.centerX.equalTo(mainView)
            make.left.equalTo(mainView).offset(50)
            make.right.equalTo(mainView).inset(50)
            make.top.equalTo(passwordStack.snp.bottom).offset(50)
            make.height.equalTo(40)
        }
    }
    
    // MARK: - Actions
    
    @objc private func buttonPressed() {
        
        if loginTextField.text == login && passwordTextField.text == password {
            UserDefaults.standard.set(true, forKey: "isLogged")
            let viewController = ModuleBuilder.moduleTableView()
            let navigationController = UINavigationController(rootViewController: viewController)
            SceneDelegate
                .shared
                .changeRootViewController(viewController: navigationController,
                                          animationOptions: .transitionFlipFromRight)
        } else if loginTextField.text == "" && passwordTextField.text == "" {
            showAlert(title: "Nothing was entered",
                      message: "Please write your login and password!")
        } else {
            showAlert(title: "Wrong Login or Password!",
                      message: "Please write a correct login or password and try again!")
        }
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok",
                                        style: .destructive) { _ in
            self.loginTextField.text = ""
            self.passwordTextField.text = ""
        }
        alert.addAction(alertAction)
        present(alert, animated: true)
    }
    
    private func setupKeyboard() {
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func hideKeyboard() {
        self.view.endEditing(true)
    }
    
    @objc private func keyboardWillShow() {
        if self.view.frame.origin.y == 0 {
            self.view.frame.origin.y -= 80
        }
    }
    
    @objc private func keyboardWillHide() {
        self.view.frame.origin.y = 0
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}
