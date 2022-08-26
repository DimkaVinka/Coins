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
    private var coinsImagesIbserver: AnyCancellable?
    private var coins: [Coin]?
    private var coinsImages: [UIImage]?
    
    // MARK: - Outlets
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TableViewCustomCell.self, forCellReuseIdentifier: "customCell")
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getData()
        title = "Coins"
        view.backgroundColor = .systemYellow
        coinsObserver = viewModel.$coins.sink(receiveValue: { coinsArray in
            self.coins = coinsArray
        })
        coinsImagesIbserver = viewModel.$coinsImages.sink(receiveValue: { imagesArray in
            self.coinsImages = imagesArray
        })
        setupHierarchy()
        setupLayout()
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
}

extension TableViewView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.coins?.count ?? 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! TableViewCustomCell
        cell.mainTitle.text = coins?[indexPath.row].name
        cell.detailTitle.text = coins?[indexPath.row].symbol
        cell.image.image = coinsImages?[indexPath.row]
        let costs = String(format: "%.1f", coins?[indexPath.row].marketData.priceUsd ?? 0)
        cell.costTitle.text = costs
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
    
    
}
