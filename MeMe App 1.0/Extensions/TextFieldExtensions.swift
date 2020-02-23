//
//  TextFieldExtension.swift
//  MeMe App 1.0
//
//  Created by Gerardo Tarazona Caceres on 2/21/20.
//  Copyright © 2020 udacity. All rights reserved.
//

import UIKit

extension UITextField {
    func setupMemeText(_ text: String = "") {
        let font = UIFont(name: "HelveticaNeue-CondensedBlack", size: 40) ?? UIFont.systemFont(ofSize: 40)
        let textAttributtes:[NSAttributedString.Key: Any] = [NSAttributedString.Key.strokeColor : UIColor.black,
                                                             NSAttributedString.Key.foregroundColor : UIColor.white,
                                                             NSAttributedString.Key.font : font,
                                                             NSAttributedString.Key.strokeWidth: -3.0]
        self.defaultTextAttributes = textAttributtes
        self.textAlignment = .center
        self.text = text
    }
}
