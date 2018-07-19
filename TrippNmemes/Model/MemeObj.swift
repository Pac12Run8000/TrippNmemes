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
    
    init(_ topText:String,_ bottomText:String, originalImage:UIImage, memedImage:UIImage) {
        self.topText = topText
        self.bottomText = bottomText
        self.originalImage = originalImage
        self.memedImage = memedImage
    }
    
    
    
    // MARK: This static function creates the memed image
    static func generateMemedImage(_ controller:UIViewController) -> UIImage {
        UIGraphicsBeginImageContext(controller.view.frame.size)
        controller.view.drawHierarchy(in: controller.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        return memedImage
    }
}
