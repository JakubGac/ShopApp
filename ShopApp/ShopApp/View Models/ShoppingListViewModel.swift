//
//  ShoppingListViewModel.swift
//  ShopApp
//
//  Created by Jakub Gac on 18/09/2025.
//

import RxSwift
import RxCocoa

class ShoppingListViewModel {
    
    let checkout = PublishRelay<Void>()
    let addProduct = PublishRelay<Product>()
    let removeProduct = PublishRelay<Product>()
    let selectedCurrency = BehaviorRelay<String>(value: "USD")
    
    let basketTotal: Observable<Double>
    let basketItems: Observable<[Product]>
    let availableProducts: Observable<[Product]>
    let availableCurrencies: BehaviorRelay<[String]>
    var checkoutMessage: Observable<String> = Observable.just("")
    var convertedTotalCost: Observable<String> = Observable.just("")
    
    private let basketManager: BasketManager
    private let currencyConverter: CurrencyConverter
    
    private let disposeBag: DisposeBag = .init()

    init() {
        basketManager = .init()
        currencyConverter = .init()
        
        availableProducts = Observable.just(
            [
                .init(name: "Potato", price: 0.95, image: .init(named: "Potatoes")),
                .init(name: "Eggs", price: 2.10, image: .init(named: "Eggs")),
                .init(name: "Milk", price: 1.30, image: .init(named: "Milk")),
                .init(name: "Banana", price: 0.73, image: .init(named: "Banana"))
            ]
        )
        
        availableCurrencies = BehaviorRelay<[String]>(value: currencyConverter.availableCurrencies)
        
        basketItems = basketManager.basket
        
        basketTotal = basketItems
            .map { $0.reduce(0) { $0 + $1.price } }
            .startWith(0.0)
        
        convertedTotalCost = Observable.combineLatest(basketTotal, selectedCurrency.asObservable())
            .flatMapLatest { [weak self](total, currency) -> Observable<String> in
                guard let self = self else { return .empty() }
                
                return self.currencyConverter.convert(amount: total, to: currency)
                    .map { String(format: "%.2f %@", $0, currency) }
            }
            .startWith("0.00")
        
        checkoutMessage = checkout
            .withLatestFrom(convertedTotalCost)
            .map { "Total to pay: \($0)" }
        
        addProduct
            .subscribe(onNext: { [weak self] product in
                self?.basketManager.add(product: product)
            })
            .disposed(by: disposeBag)
        
        removeProduct
            .subscribe(onNext: { [weak self] product in
                self?.basketManager.remove(product: product)
            })
            .disposed(by: disposeBag)
    }
}
