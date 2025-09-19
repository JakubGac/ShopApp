//
//  AppCoordinator.swift
//  ShopApp
//
//  Created by Jakub Gac on 18/09/2025.
//

import UIKit

protocol AppCoordinator {
    var navigationController: UINavigationController { get set }
    
    func start()
}
