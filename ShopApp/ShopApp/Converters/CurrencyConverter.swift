//
//  CurrencyConverter.swift
//  ShopApp
//
//  Created by Jakub Gac on 19/09/2025.
//

import RxSwift

class CurrencyConverter {
    
    private var exchangeRates: [String: Double] = [:]
    
    var availableCurrencies: [String] {
        return exchangeRates.keys.sorted()
    }
    
    private struct ExchangeRateResponse: Codable {
        let success: Bool
        let timestamp: Int
        let source: String
        let quotes: [String: Double]
    }

    init() {
        loadExchangeRates()
    }

    private func loadExchangeRates() {
        guard let url = Bundle.main.url(forResource: "response", withExtension: "json") else {
            print("Error: response.json not found in the main bundle.")
            return
        }

        do {
            let data = try Data(contentsOf: url)
            let response = try JSONDecoder().decode(ExchangeRateResponse.self, from: data)
            
            for (key, value) in response.quotes {
                let currencyCode = key.replacingOccurrences(of: "USD", with: "")
                exchangeRates[currencyCode] = value
            }
            
            exchangeRates["USD"] = 1.0
        } catch {
            print("Error loading or decoding exchange rates: \(error)")
        }
    }
    
    func convert(amount: Double, to currencyCode: String) -> Observable<Double> {
        return Observable.create { [weak self] observer in
            // Handle the case where the currency code is "USD"
            guard let self = self, let rate = self.exchangeRates[currencyCode] ?? (currencyCode == "USD" ? 1.0 : nil) else {
                print("Error: Currency code \(currencyCode) not found.")
                observer.onCompleted()
                return Disposables.create()
            }
            
            let convertedAmount = amount * rate
            
            observer.onNext(convertedAmount)
            observer.onCompleted()
            
            return Disposables.create()
        }
    }
}
