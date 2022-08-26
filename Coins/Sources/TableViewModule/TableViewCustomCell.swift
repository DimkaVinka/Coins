//
//  TableViewCustomCell.swift
//  Coins
//
//  Created by Дмитрий Виноградов on 26.08.2022.
//

import UIKit
import SnapKit

class TableViewCustomCell: UITableViewCell {
    
    // MARK: - Outlets
    
    let mainTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    let detailTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    let costTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    let image: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading
        stack.distribution = .fill
        return stack
    }()
    
    // MARK: Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setupHierarchy() {
        addSubviews([
        image, stack, costTitle
        ])
        
        stack.addArrangedSubviews([
        mainTitle, detailTitle
        ])
    }
    
    private func setupLayout() {
        image.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.height.width.equalTo(50)
            make.left.equalTo(contentView.safeAreaLayoutGuide).offset(20)
        }
        
        stack.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.left.equalTo(image.snp.right).offset(10)
        }
        
        costTitle.snp.makeConstraints { make in
            make.centerY.equalTo(image)
            make.right.equalTo(contentView.safeAreaLayoutGuide).inset(30)
        }
    }
    
    override func prepareForReuse() {
        self.mainTitle.text = nil
        self.detailTitle.text = nil
        self.costTitle.text = nil
        self.image.image = nil
        self.accessoryType = .none
    }
}
