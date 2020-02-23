//
//  MemeTextFieldDelegate.swift
//  MeMe App 1.0
//
//  Created by Gerardo Tarazona Caceres on 2/21/20.
//  Copyright © 2020 udacity. All rights reserved.
//

import Foundation
import UIKit

class MemeTextFieldDelegate: NSObject, UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if let text = textField.text,
            text == Constants.TextFields.defaultTopText || text == Constants.TextFields.defaultBottomText {
            textField.text = String()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}
