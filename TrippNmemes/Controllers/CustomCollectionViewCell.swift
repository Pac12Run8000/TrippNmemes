//
//  CustomCollectionViewCell.swift
//  TrippNmemes
//
//  Created by Michelle Grover on 7/11/18.
//  Copyright © 2018 Norbert Grover. All rights reserved.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var backgroundTintImage: UIImageView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var selectionImageOutlet: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.layer.borderWidth = 3
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 6
        imageView.contentMode = .scaleAspectFill
    }
    
    var memeObj:MemeObj! {
        didSet {
            imageView.image = UIImage(data: memeObj.memedImage as Data)
        }
    }
    
    var isEditing:Bool = false {
        didSet {
            selectionImageOutlet.isHidden = !isEditing
            backgroundTintImage.isHidden = !isEditing
        }
    }
    
    override var isSelected: Bool {
        didSet {
            if isEditing {
                selectionImageOutlet.image = isSelected ? UIImage(named: "Checked") : UIImage(named: "Unchecked")
            }
        }
    }
    
}
