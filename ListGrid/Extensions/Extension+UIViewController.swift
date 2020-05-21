//
//  Extension+UIViewController.swift
//  ListGrid
//
//  Created by Admin on 09.05.2020.
//  Copyright © 2020 Mykola Korotun. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showAlert(title: String, message: String, completion: @escaping () -> Void = {}) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            completion()
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
}
