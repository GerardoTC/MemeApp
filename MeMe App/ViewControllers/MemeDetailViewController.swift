//
//  MemeDetailViewController.swift
//  MeMe App
//
//  Created by Gerardo Tarazona Caceres on 4/9/20.
//  Copyright © 2020 udacity. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {
    @IBOutlet weak var memedImage: UIImageView!
    var meme: Meme?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        memedImage.image = meme?.memedImage
    }
}
