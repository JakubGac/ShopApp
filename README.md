Simple Shopping App
This is a simple shopping application developed for an iOS Developer Home Assignment. The project demonstrates the use of Swift and RxSwift for building a reactive, clean, and maintainable application.

Features
Product Catalog: Displays a list of pre-defined products with their prices.

Shopping Basket: Allows users to add and remove items from a shopping basket.

Dynamic Currency Conversion: Calculates the total cost of the basket and can convert it to various currencies, with rates loaded from a local JSON file.

Reactive UI: The entire user interface is driven by a reactive data flow using RxSwift and RxCocoa.

Technical Stack
Language: Swift

Frameworks:

RxSwift: For implementing reactive programming patterns.

RxCocoa: For providing reactive extensions to UIKit components.

Project Structure
The project is structured with a focus on separation of concerns and maintainability:

Product.swift: Defines the Product model.

CurrencyConverter.swift: Handles currency conversion logic and loads exchange rates from a JSON file.

BasketManager.swift: Manages the state of the shopping basket.

ShoppingListViewModel.swift: The ViewModel layer, which contains the core business logic and exposes observables for the UI to bind to.

ShoppingListViewController.swift: The View layer, which programmatically builds the UI and binds it to the ViewModel using RxSwift.

ShoppingListTableViewCell.Swift: Part of the View layer, contains programatically build cell view for products.

SceneDelegate.swift: The application's coordinators set up.

response.json: A JSON file that simulates an API response for currency exchange rates.

UIViewController+Extension.swift: Contains simple extension to keep displaying UIAlertController under reactive flow.

AppCoordinator.Swift: Main coordinator protocol

ShoppingListCoordinator.swift: Main app coordinator class that handles creating of main view.

Setup and Operation
To run this project, you will need Xcode. Follow these steps:

Clone the Repository:

git clone [https://github.com/JakubGac/ShopApp.git]

Install Dependencies:
This project uses CocoaPods for dependency management. Navigate to the project directory in your terminal and run:

pod install

Open the Project:
Open the generated .xcworkspace file in Xcode.

Run the App:
Select a simulator from the device list in Xcode and click the Run button. The app should compile and launch, displaying the shopping interface.

Notes
The UI is built programmatically without using storyboards or .xib files.

Currency rates are sourced from the local response.json file.

The application demonstrates a simple implementation of the MVVM + Coordinators (Model-View-ViewModel plus coordinators for navigation) architectural pattern with a reactive approach and coordinators pattern for navigation.