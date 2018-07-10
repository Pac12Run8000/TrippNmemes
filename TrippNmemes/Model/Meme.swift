//
//  MemeObj.swift
//  TrippNmemes
//
//  Created by Michelle Grover on 7/9/18.
//  Copyright © 2018 Norbert Grover. All rights reserved.
//

import Foundation

class Meme:NSObject {
    var image:String
    var name:String
    var bottomText:String
    var topText:String
    
    static let imageKey = "imageKey"
    static let nameKey = "nameKey"
    
    override init() {
        self.image = "Burley"
        self.name = ""
        self.bottomText = ""
        self.topText = ""
    }
    
    init(_ image:String,_ name:String,_ bottomText:String,_ topText:String) {
        self.image = image
        self.name = name
        self.bottomText = bottomText
        self.topText = topText
    }
    
    init(dictionary:[String:AnyObject]) {
        self.image = dictionary[Meme.imageKey] as! String
        self.name = dictionary[Meme.nameKey] as! String
        self.bottomText = dictionary[Meme.nameKey] as! String
        self.topText = dictionary[Meme.nameKey] as! String
    }
    
    static var MemesArray:[Meme] {
        var array = [Meme]()
        
        return array
    }
}
