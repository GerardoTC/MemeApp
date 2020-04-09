//
//  MemeTableViewCell.swift
//  MeMe App
//
//  Created by Gerardo Tarazona Caceres on 4/9/20.
//  Copyright © 2020 udacity. All rights reserved.
//

import UIKit

class MemeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var memedImage: UIImageView!
    @IBOutlet weak var topText: UILabel!
    @IBOutlet weak var bottomText: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupCellWith(meme: Meme) {
        topText.text = meme.topText
        bottomText.text = meme.bottomText
        memedImage.contentMode = .scaleAspectFit
        memedImage.layer.cornerRadius = 10
        memedImage.layer.borderColor = UIColor.black.cgColor
        memedImage.layer.borderWidth = 5
        memedImage.image = meme.memedImage
    }
    
}
