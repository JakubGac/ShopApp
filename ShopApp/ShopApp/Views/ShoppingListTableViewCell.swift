//
//  ShoppingListTableViewCell.swift
//  ShopApp
//
//  Created by Jakub Gac on 19/09/2025.
//

import UIKit
import RxSwift
import RxCocoa

class ShoppingListTableViewCell: UITableViewCell {
    
    let priceLabel = UILabel()
    let productNameLabel = UILabel()
    let productImageView = UIImageView()
    let addButton = UIButton(type: .system)

    var disposeBag = DisposeBag()
    
    private let containerView = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    private func setupViews() {
        selectionStyle = .none
        backgroundColor = .clear
        
        containerView.backgroundColor = .secondarySystemBackground
        containerView.layer.cornerRadius = 10
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.1
        containerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        containerView.layer.shadowRadius = 4
        containerView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(containerView)
        
        productImageView.contentMode = .scaleAspectFit
        productImageView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(productImageView)

        productNameLabel.font = .systemFont(ofSize: 16, weight: .regular)
        productNameLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(productNameLabel)
        
        priceLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(priceLabel)
        
        addButton.setTitle("Add", for: .normal)
        addButton.backgroundColor = .systemGreen
        addButton.setTitleColor(.white, for: .normal)
        addButton.layer.cornerRadius = 5
        addButton.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(addButton)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),

            productImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            productImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            productImageView.widthAnchor.constraint(equalToConstant: 40),
            productImageView.heightAnchor.constraint(equalToConstant: 40),

            productNameLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 16),
            productNameLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            
            priceLabel.leadingAnchor.constraint(equalTo: productNameLabel.trailingAnchor, constant: 16),
            priceLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            
            addButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            addButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            addButton.widthAnchor.constraint(equalToConstant: 80),
            addButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
}
