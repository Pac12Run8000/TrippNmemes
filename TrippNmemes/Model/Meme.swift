//
//  MemeObj.swift
//  TrippNmemes
//
//  Created by Michelle Grover on 7/9/18.
//  Copyright © 2018 Norbert Grover. All rights reserved.
//

import Foundation

class Meme:NSObject {
    var memedImage:String
    var originalImage:String
    var bottomText:String
    var topText:String
    

    
    static let originalImageKey = "originalImageKey"
    static let memedImageKey = "memedImageKey"
    static let bottomTextKey = "bottomTextKey"
    static let topTextKey = "topTextKey"
    
    override init() {
        self.originalImage = "Burley"
        self.memedImage = ""
        self.bottomText = ""
        self.topText = ""
    }
    
    init(_ originalImage:String,_ memedImage:String,_ bottomText:String,_ topText:String) {
        self.originalImage = originalImage
        self.memedImage = memedImage
        self.bottomText = bottomText
        self.topText = topText
    }
    
    init(dictionary:[String:AnyObject]) {
        self.originalImage = dictionary[Meme.originalImageKey] as! String
        self.memedImage = dictionary[Meme.memedImageKey] as! String
        self.bottomText = dictionary[Meme.bottomTextKey] as! String
        self.topText = dictionary[Meme.topTextKey] as! String
    }
    
    static var MemesArray:[Meme] {
        var array = [Meme]()
        for item in Meme.getAllMemes() {
            array.append(Meme(dictionary:item))
        }
        return array
    }
    
    
    static func getAllMemes() -> [[String:AnyObject]]{
        return [
            [Meme.originalImageKey:"Burley" as AnyObject, Meme.memedImageKey:"Roy Jones Jr" as AnyObject, Meme.bottomTextKey:"Can't be Touched" as AnyObject, Meme.topTextKey:"Y'all Musta Forget" as AnyObject],
            [Meme.originalImageKey:"Burley" as AnyObject, Meme.memedImageKey:"Mike McCallum" as AnyObject, Meme.bottomTextKey:"Can't be Touched" as AnyObject, Meme.topTextKey:"Y'all Musta Forget" as AnyObject],
            [Meme.originalImageKey:"Burley" as AnyObject, Meme.memedImageKey:"Sam Langford" as AnyObject, Meme.bottomTextKey:"Can't be Touched" as AnyObject, Meme.topTextKey:"Y'all Musta Forget" as AnyObject],
            [Meme.originalImageKey:"Burley" as AnyObject, Meme.memedImageKey:"Charley Burley" as AnyObject, Meme.bottomTextKey:"Black Muderers" as AnyObject, Meme.topTextKey:"Row" as AnyObject],
            [Meme.originalImageKey:"Burley" as AnyObject, Meme.memedImageKey:"Willie Pep" as AnyObject, Meme.bottomTextKey:"Can't be Touched" as AnyObject, Meme.topTextKey:"Y'all Musta Forget" as AnyObject],
            [Meme.originalImageKey:"Burley" as AnyObject, Meme.memedImageKey:"Eusebio Pedroza" as AnyObject, Meme.bottomTextKey:"Can't be Touched" as AnyObject, Meme.topTextKey:"Y'all Musta Forget" as AnyObject],
            [Meme.originalImageKey:"Burley" as AnyObject, Meme.memedImageKey:"Mike Tyson" as AnyObject, Meme.bottomTextKey:"Can't be Touched" as AnyObject, Meme.topTextKey:"Y'all Musta Forget" as AnyObject],
            [Meme.originalImageKey:"Burley" as AnyObject, Meme.memedImageKey:"George Foreman" as AnyObject, Meme.bottomTextKey:"Can't be Touched" as AnyObject, Meme.topTextKey:"Y'all Musta Forget" as AnyObject]
        ]
    }
}
