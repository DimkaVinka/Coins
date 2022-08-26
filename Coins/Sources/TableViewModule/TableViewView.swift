//
//  TableViewView.swift
//  Coins
//
//  Created by Дмитрий Виноградов on 26.08.2022.
//

import UIKit
import SnapKit
import Combine

class TableViewView: UIViewController {
    
    private let viewModel = TableViewViewModel()
    private var coinsObserver: AnyCancellable?
    private var coins: [Coin]?
    
    // MARK: - Outlets
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TableViewCustomCell.self, forCellReuseIdentifier: "customCell")
        tableView.backgroundColor = .clear
        tableView.layer.borderWidth = 1
        tableView.layer.borderColor = UIColor.black.cgColor
        return tableView
    }()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getData()
        viewModel.sortCoins(tableView: self.tableView, sortType: .startSorting)
        title = "Coins"
        view.backgroundColor = .systemYellow
        
        coinsObserver = viewModel.$coins.sink(receiveValue: { coinsArray in
            self.coins = coinsArray
        })
        
        setupHierarchy()
        setupLayout()
        setupNavigationBar()
    }
    
    // MARK: - Setup
    
    private func setupHierarchy() {
        view.addSubview(tableView)
    }
    
    private func setupLayout() {
        tableView.snp.makeConstraints { make in
            make.center.equalTo(view)
            make.top.right.bottom.height.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black, .font: UIFont.boldSystemFont(ofSize: 20)]

        let backButton = UIImage(systemName: "arrow.uturn.backward.square")
        navigationController?.navigationBar.backIndicatorImage = backButton
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = backButton
        navigationController?.navigationBar.backItem?.title = ""
        let backBarButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backBarButton

        let rightBarButtonMenu = UIMenu(title: "", children: [
            UIAction(title: NSLocalizedString("Sort by USD price Ascending", comment: ""), image: UIImage(systemName: "arrow.up.circle"), handler: { _ in
                self.viewModel.sortCoins(tableView: self.tableView, sortType: .ascendingByUSDPrice)
            }),
            UIAction(title: NSLocalizedString("Sort by USD Price Drop last 1 Hour", comment: ""), image: UIImage(systemName: "arrow.up.square"), handler: { _ in
                let temporaryArray = self.coins
                self.viewModel.sortCoins(tableView: self.tableView, sortType: .dropUSDPerTast1Hour)
                
                var temporaryArrayString = ""
                temporaryArray?.forEach { temporaryArrayString += $0.name }
                var temporaryCoinsString = ""
                self.coins?.forEach { temporaryCoinsString += $0.name }
                
                if temporaryArrayString == temporaryCoinsString {
                    self.showAlert(title: "Nothing has changed",
                                   message: "The data may not have been updated yet. It's worth the wait!")
                } else {
                    self.tableView.reloadData()
                }
            }),
            UIAction(title: NSLocalizedString("Sort by USD Price Drop last 24 Hours", comment: ""), image: UIImage(systemName: "arrow.down.square"), handler: { _ in
                self.viewModel.sortCoins(tableView: self.tableView, sortType: .dropUSDPerLast24Hours)
            })
        ])
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "", image: UIImage(systemName: "arrow.up.arrow.down.circle"), primaryAction: nil, menu: rightBarButtonMenu)
        
        let leftBarButtonMenu = UIMenu(title: "", children: [
            UIAction(title: NSLocalizedString("Reset and Update Table", comment: ""), image: UIImage(systemName: "arrow.up.circle"), handler: { _ in
                self.viewModel.sortCoins(tableView: self.tableView, sortType: .startSorting)
            }),
            UIAction(title: NSLocalizedString("Log Out", comment: ""), image: UIImage(systemName: "arrow.down.circle"), handler: { _ in
                UserDefaults.standard.set(false, forKey: "isLogged")
                SceneDelegate
                    .shared
                    .changeRootViewController(viewController: ModuleBuilder.moduleAuthorization(),
                                              animationOptions: .transitionFlipFromLeft)
            }),
        ])
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", image: UIImage(systemName: "rectangle.and.hand.point.up.left.filled"), primaryAction: nil, menu: leftBarButtonMenu)
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok",
                                        style: .destructive)
        alert.addAction(alertAction)
        present(alert, animated: true)
    }
}

extension TableViewView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.coins?.count ?? 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! TableViewCustomCell
        
        cell.mainTitle.text = coins?[indexPath.row].name
        cell.detailTitle.text = coins?[indexPath.row].symbol
        cell.image.image = UIImage(named: (coins?[indexPath.row])?.symbol ?? "")
        let costs = String(format: "%.3f", coins?[indexPath.row].marketData.priceUsd ?? 0) + "$"
        cell.costTitle.text = costs
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let viewController = DetailView()
        viewController.coin = coins?[indexPath.row]
        navigationController?.pushViewController(viewController, animated: true)
    }
}
