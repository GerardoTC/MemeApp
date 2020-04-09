//
//  KeyboardManagement.swift
//  MeMe App 1.0
//
//  Created by Gerardo Tarazona Caceres on 2/22/20.
//  Copyright © 2020 udacity. All rights reserved.
//

import Foundation
import UIKit

class KeyboardManagement {
    var view: UIView!

    func subscribeToKeyBoardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    func getKeyboardFrame(_ notification: Notification) -> CGRect {
         let userInfo = notification.userInfo
         let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
         return keyboardSize.cgRectValue
     }
    
    @objc func keyBoardWillHide(_ notification: Notification) {
        self.view.frame.origin.y = 0
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        guard let selectedTextField = view.selectedTextField,
            self.view.frame.origin.y == 0 else {
                return
        }
        let keyBoardFrame = getKeyboardFrame(notification)
        let relatedPosition = selectedTextField.convert(keyBoardFrame, from: nil)
        if relatedPosition.origin.y <= 0 {
            self.view.frame.origin.y += relatedPosition.origin.y - selectedTextField.frame.height
        }

    }
    
}
