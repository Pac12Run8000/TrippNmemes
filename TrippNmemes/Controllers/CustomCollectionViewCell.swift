//
//  CustomCollectionViewCell.swift
//  TrippNmemes
//
//  Created by Michelle Grover on 7/11/18.
//  Copyright © 2018 Norbert Grover. All rights reserved.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.layer.borderWidth = 3
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 6
    }
    
    var memeObj:Meme! {
        didSet {
            imageView.image = UIImage(named: memeObj.image)
        }
    }
    
}
