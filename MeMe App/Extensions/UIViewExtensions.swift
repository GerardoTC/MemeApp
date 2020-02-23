//
//  UIViewExtension.swift
//  MeMe App 1.0
//
//  Created by Gerardo Tarazona Caceres on 2/22/20.
//  Copyright © 2020 udacity. All rights reserved.
//

import UIKit

extension UIView {
    var selectedTextField: UITextField? {
        guard !isFirstResponder else { return self as? UITextField}
        let textField: [UIView?] = getAllTextFields(fromView: self).filter { $0.isFirstResponder}
        return textField.first as? UITextField
    }
    
    var screehShot: UIImage? {
        
        UIGraphicsBeginImageContextWithOptions(self.frame.size, false, 0.0)
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        self.layer.render(in: context)
        guard let memedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext() else {
            return nil
        }
        UIGraphicsEndImageContext()
        return memedImage
    }
    
    func getAllTextFields(fromView view: UIView)-> [UITextField] {
        return view.subviews.compactMap { (view) -> [UITextField]? in
            if view is UITextField {
                return [(view as! UITextField)]
            } else {
                return getAllTextFields(fromView: view)
            }
        }.flatMap({$0})
    }
}
