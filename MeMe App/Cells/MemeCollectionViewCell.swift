//
//  MemeCollectionViewCell.swift
//  MeMe App
//
//  Created by Gerardo Tarazona Caceres on 4/9/20.
//  Copyright © 2020 udacity. All rights reserved.
//

import UIKit

class MemeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var memedImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func set(image: UIImage) {
        memedImage.image = image
        memedImage.contentMode = .scaleAspectFit
        memedImage.layer.cornerRadius = 10
        memedImage.layer.borderColor = UIColor.black.cgColor
        memedImage.layer.borderWidth = 5
    }
}
