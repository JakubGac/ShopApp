//
//  BasketManager.swift
//  ShopApp
//
//  Created by Jakub Gac on 19/09/2025.
//

import RxSwift

class BasketManager {
    
    private let basketSubject = BehaviorSubject<[Product]>(value: [])
    
    var basket: Observable<[Product]> {
        return basketSubject.asObservable()
    }
    
    func add(product: Product) {
        do {
            var currentBasket = try basketSubject.value()
            currentBasket.append(product)
            basketSubject.onNext(currentBasket)
        } catch {
            print("Error adding product to basket: \(error)")
        }
    }
    
    func remove(product: Product) {
        do {
            var currentBasket = try basketSubject.value()
            if let index = currentBasket.firstIndex(where: { $0.id == product.id }) {
                currentBasket.remove(at: index)
                basketSubject.onNext(currentBasket)
            }
        } catch {
            print("Error removing product from basket: \(error)")
        }
    }
    
    func clearBasket() {
        basketSubject.onNext([])
    }
}
