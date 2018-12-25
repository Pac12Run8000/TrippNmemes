//
//  MemeGeneraterControllerDelegate.swift
//  TrippNmemes
//
//  Created by Michelle Grover on 12/24/18.
//  Copyright © 2018 Norbert Grover. All rights reserved.
//

import Foundation


protocol MemeGeneratorViewControllerDelegate:class {
    
    func memeGeneratorViewControllerDidCancel(_ controller:MemeGeneratorViewController)
    func memeGeneratorViewController(_ controller:MemeGeneratorViewController, didFinishAdding item:(topText: String, bottomText: String, originalImage: NSData, memedImage: NSData))
    func memeGeneratorViewController(_ controller:MemeGeneratorViewController, didFinishEditing item:MemeObj)
    
}
