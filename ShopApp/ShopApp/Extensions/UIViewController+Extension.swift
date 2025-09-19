//
//  UIViewController+Extension.swift
//  ShopApp
//
//  Created by Jakub Gac on 19/09/2025.
//

import UIKit
import RxSwift

extension UIViewController {
    func showAlert(title: String, message: String) -> Observable<Void> {
        return Observable.create { [weak self] observer in
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                observer.onNext(())
                observer.onCompleted()
            }))
            
            self?.present(alertController, animated: true, completion: nil)
            
            return Disposables.create {
                alertController.dismiss(animated: true, completion: nil)
            }
        }
    }
}
