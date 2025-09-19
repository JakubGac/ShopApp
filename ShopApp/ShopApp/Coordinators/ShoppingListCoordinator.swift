//
//  ShoppingListCoordinator.swift
//  ShopApp
//
//  Created by Jakub Gac on 18/09/2025.
//

import UIKit

class ShoppinglistCoordinator: AppCoordinator {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel: ShoppingListViewModel = .init()
        let viewController: ShoppingListViewController = .init(viewModel: viewModel)
        
        navigationController.setNavigationBarHidden(true, animated: false)
        navigationController.pushViewController(viewController, animated: true)
    }
}
