//
//  DetailView.swift
//  Coins
//
//  Created by Дмитрий Виноградов on 26.08.2022.
//

import UIKit
import SnapKit

class DetailView: UIViewController {
    
    private let viewModel = DetailViewModel()
    var coin: Coin?
    var coinImage: UIImage?
    
    // MARK: - MainView Outlets
    
    private lazy var mainTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 75, weight: .black)
        return label
    }()
    
    private lazy var backgroundImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.layer.cornerRadius = 0
        image.alpha = 0.1
        return image
    }()
    
    // MARK: - USDRate Oulets
    
    private lazy var usdLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.text = "Price in USD"
        return label
    }()
    
    private lazy var usdStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.alignment = .leading
        stack.layer.cornerRadius = 20
        stack.layer.borderColor = UIColor.black.cgColor
        stack.layer.borderWidth = 1
        return stack
    }()
    
    private lazy var usdPriceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    private lazy var usdPercentChangeIn1Hour: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    private lazy var usdPercentChangeIn24Hours: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    // MARK: - BTCRate Outlets
    
    private lazy var btcLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.text = "Price in BTC"
        return label
    }()
    
    private lazy var btcStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.alignment = .leading
        stack.layer.cornerRadius = 20
        stack.layer.borderColor = UIColor.black.cgColor
        stack.layer.borderWidth = 1
        return stack
    }()
    
    private lazy var btcPriceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    private lazy var btcPercentChangeIn1Hour: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    private lazy var btcPercentChangeIn24Hours: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    // MARK: - ETHRate Outlets
    
    private lazy var ethLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.text = "Price in ETH "
        return label
    }()
    
    private lazy var ethStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.alignment = .leading
        stack.layer.cornerRadius = 20
        stack.layer.borderColor = UIColor.black.cgColor
        stack.layer.borderWidth = 1
        return stack
    }()
    
    private lazy var ethPriceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    private lazy var ethPercentChangeIn1Hour: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    private lazy var ethPercentChangeIn24Hours: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemYellow
        setupHierarchy()
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = coin?.name
        configureData()
    }
    
    // MARK: - Setup
    
    private func setupHierarchy() {
        view.addSubview(backgroundImage)
        view.addSubview(mainTitle)
        
        view.addSubview(usdLabel)
        view.addSubview(usdStack)
        usdStack.addArrangedSubviews([
        usdPriceLabel, usdPercentChangeIn1Hour, usdPercentChangeIn24Hours
        ])
        
        view.addSubview(btcLabel)
        view.addSubview(btcStack)
        btcStack.addArrangedSubviews([
        btcPriceLabel, btcPercentChangeIn1Hour, btcPercentChangeIn24Hours
        ])
        
        view.addSubview(ethLabel)
        view.addSubview(ethStack)
        ethStack.addArrangedSubviews([
            ethPriceLabel, ethPercentChangeIn1Hour, ethPercentChangeIn24Hours
        ])
    }
    
    private func setupLayout() {
        mainTitle.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            make.centerX.equalTo(view)
        }
        
        backgroundImage.snp.makeConstraints { make in
            make.left.top.right.bottom.equalTo(view.safeAreaLayoutGuide)
            make.center.equalTo(view)
            make.width.equalTo(view.snp.width)
        }
        
        // MARK: - USDLayout
        
        usdStack.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(mainTitle.snp.bottom).offset(50)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).inset(20)
            make.height.equalTo(100)
        }
        
        usdLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.bottom.equalTo(usdStack.snp.top)
        }
        
        usdPriceLabel.snp.makeConstraints { make in
            make.left.equalTo(usdStack).offset(10)
        }
        
        // MARK: - BTCLayout
        
        btcStack.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(usdStack.snp.bottom).offset(40)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).inset(20)
            make.height.equalTo(100)
        }
        
        btcLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.bottom.equalTo(btcStack.snp.top)
        }
        
        btcPriceLabel.snp.makeConstraints { make in
            make.left.equalTo(btcStack).offset(10)
        }
        
        // MARK: - ETHLayout
        
        ethStack.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(btcStack.snp.bottom).offset(40)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).inset(20)
            make.height.equalTo(100)
        }
        
        ethLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.bottom.equalTo(ethStack.snp.top)
        }
        
        ethPriceLabel.snp.makeConstraints { make in
            make.left.equalTo(ethStack).offset(10)
        }
    }
    
    private func configureData() {
        mainTitle.text = coin?.name
        backgroundImage.image = coinImage
        
        usdPriceLabel.text = "Price of this coin -> " + String(format: "%.2f", coin?.marketData.priceUsd ?? 0) + "$"
        usdPercentChangeIn1Hour.text = "Changes since 1 Hour in % -> " + String(format: "%.7f", coin?.marketData.percentChangeUsdLast1_Hour ?? 0) + "%"
        usdPercentChangeIn24Hours.text = "Changes since 24 Hours in % -> " + String(format: "%.7f", coin?.marketData.percentChangeUsdLast24_Hours ?? 0) + "%"
        
        btcPriceLabel.text = "Price of this coin -> " + String(format: "%.0f", coin?.marketData.priceBtc ?? 0) + " bitcoins"
        btcPercentChangeIn1Hour.text = "Changes since 1 Hour in % -> " + String(format: "%.7f", coin?.marketData.percentChangeBtcLast1_Hour ?? 0) + "%"
        btcPercentChangeIn24Hours.text = "Changes since 24 Hours in % -> " + String(format: "%.7f", coin?.marketData.percentChangeBtcLast24_Hours ?? 0) + "%"
        
        ethPriceLabel.text = "Price of this coin -> " + String(format: "%.4f", coin?.marketData.priceEth ?? 0) + " etheriums"
        ethPercentChangeIn1Hour.text = "Changes since 1 Hour in % -> " + String(format: "%.7f", coin?.marketData.percentChangeEthLast1_Hour ?? 0) + "%"
        ethPercentChangeIn24Hours.text = "Changes since 24 Hours in % -> " + String(format: "%.7f", coin?.marketData.percentChangeEthLast24_Hours ?? 0) + "%"
    }
}
