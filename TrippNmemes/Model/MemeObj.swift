//
//  MemeObj.swift
//  TrippNmemes
//
//  Created by Michelle Grover on 7/17/18.
//  Copyright © 2018 Norbert Grover. All rights reserved.
//

import Foundation
import UIKit


class MemeObj: NSObject {
    var topText:String
    var bottomText:String
    var originalImage:UIImage
    var memedImage:UIImage
    
    init(topText:String, bottomText:String, originalImage:UIImage, memedImage:UIImage) {
        self.topText = topText
        self.bottomText = bottomText
        self.originalImage = originalImage
        self.memedImage = memedImage
    }
    
    
    
    
}
