//
//  ShoppingListViewController.swift
//  ShopApp
//
//  Created by Jakub Gac on 18/09/2025.
//

import UIKit
import RxSwift
import RxRelay
import RxCocoa

class ShoppingListViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    
    private let viewModel: ShoppingListViewModel
    
    private let basketLabel = UILabel()
    private let productsLabel = UILabel()
    private let totalCostLabel = UILabel()
    private let basketTableView = UITableView()
    private let productsTableView = UITableView()
    private let currencyPickerView = UIPickerView()
    private let checkoutButton = UIButton(type: .system)
    
    init(viewModel: ShoppingListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        bind()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        productsLabel.text = "Available Products"
        productsLabel.font = .preferredFont(forTextStyle: .title2)
        
        productsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "ProductCell")
        
        basketLabel.text = "Shopping Basket"
        basketLabel.font = .preferredFont(forTextStyle: .title2)
        
        basketTableView.register(UITableViewCell.self, forCellReuseIdentifier: "BasketCell")
        
        totalCostLabel.font = .preferredFont(forTextStyle: .headline)
        
        checkoutButton.setTitle("Checkout", for: .normal)
        checkoutButton.titleLabel?.font = .boldSystemFont(ofSize: 18)
        checkoutButton.backgroundColor = .systemBlue
        checkoutButton.setTitleColor(.white, for: .normal)
        checkoutButton.layer.cornerRadius = 8
        
        let stackView = UIStackView(arrangedSubviews: [productsLabel, productsTableView, basketLabel, basketTableView, totalCostLabel, currencyPickerView, checkoutButton])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            checkoutButton.heightAnchor.constraint(equalToConstant: 50),
            basketTableView.heightAnchor.constraint(equalToConstant: 200),
            productsTableView.heightAnchor.constraint(equalToConstant: 200),
            currencyPickerView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    private func bind() {
        viewModel.availableProducts
            .bind(to: productsTableView.rx.items(cellIdentifier: "ProductCell")) { _, product, cell in
                cell.textLabel?.text = "\(product.name) - $\(String(format: "%.2f", product.price))"
            }
            .disposed(by: disposeBag)
        
        productsTableView.rx.modelSelected(Product.self)
            .bind(to: viewModel.addProduct)
            .disposed(by: disposeBag)
        
        viewModel.basketItems
            .bind(to: basketTableView.rx.items(cellIdentifier: "BasketCell")) { _, product, cell in
                cell.textLabel?.text = "\(product.name) - $\(String(format: "%.2f", product.price))"
            }
            .disposed(by: disposeBag)
        
        basketTableView.rx.modelSelected(Product.self)
            .bind(to: viewModel.removeProduct)
            .disposed(by: disposeBag)
        
        viewModel.availableCurrencies
            .bind(to: currencyPickerView.rx.itemTitles) { (row, element) in
                return element
            }
            .disposed(by: disposeBag)
        
        currencyPickerView.rx.itemSelected
            .map { (row, _) in self.viewModel.availableCurrencies.value[row] }
            .bind(to: viewModel.selectedCurrency)
            .disposed(by: disposeBag)
        
        viewModel.availableCurrencies
            .subscribe(onNext: { [weak self] currencies in
                if let usdIndex = currencies.firstIndex(of: "USD") {
                    self?.currencyPickerView.selectRow(usdIndex, inComponent: 0, animated: false)
                    self?.viewModel.selectedCurrency.accept("USD")
                }
            })
            .disposed(by: disposeBag)
        
        viewModel.convertedTotalCost
            .bind(to: totalCostLabel.rx.text)
            .disposed(by: disposeBag)
        
        checkoutButton.rx.tap
            .bind(to: viewModel.checkout)
            .disposed(by: disposeBag)
        
        checkoutButton.rx.tap
            .withLatestFrom(viewModel.checkoutMessage)
            .flatMapLatest { [weak self] message -> Observable<Void> in
                guard let self = self else { return .empty() }
                return self.showAlert(title: "Checkout", message: message)
            }
            .subscribe()
            .disposed(by: disposeBag)
    }
}
