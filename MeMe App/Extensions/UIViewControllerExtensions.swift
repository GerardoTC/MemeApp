//
//  UIViewControllerExtension.swift
//  MeMe App
//
//  Created by Gerardo Tarazona Caceres on 2/23/20.
//  Copyright © 2020 udacity. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showAlert(title: String,
                   message: String = String(),
                   okButton: UIAlertAction = UIAlertAction(title: Constants.Alert.ok, style: .default,handler: nil),
                   cancelButton: UIAlertAction? = nil,
                   completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(okButton)
        if let cancelAction = cancelButton {
            alert.addAction(cancelAction)
        }
        present(alert, animated: true, completion: completion)
    }
}
