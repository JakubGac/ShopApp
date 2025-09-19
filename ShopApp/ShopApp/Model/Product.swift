//
//  Product.swift
//  ShopApp
//
//  Created by Jakub Gac on 18/09/2025.
//

import UIKit

struct Product {
    let id = UUID()
    let name: String
    let price: Double // Default currency is USD
    let image: UIImage?
}
