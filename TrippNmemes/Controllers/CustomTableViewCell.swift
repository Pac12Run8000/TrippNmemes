//
//  CustomTableViewCell.swift
//  TrippNmemes
//
//  Created by Michelle Grover on 7/10/18.
//  Copyright © 2018 Norbert Grover. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var customImage: UIImageView!
    @IBOutlet weak var topText: UILabel!
    @IBOutlet weak var bottomText: UILabel!
    @IBOutlet weak var nameText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var memeObj:Meme! {
        didSet {
           customImage.image = UIImage(named: memeObj.originalImage)
            topText.text = memeObj.topText
            bottomText.text = memeObj.bottomText
            nameText.text = memeObj.memedImage
        }
    }
    


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
