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
    static let bottomTextKey = "bottomTextKey"
    static let topTextKey = "topTextKey"
    
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
            [Meme.imageKey:"Burley" as AnyObject, Meme.nameKey:"Roy Jones Jr" as AnyObject, Meme.bottomTextKey:"Can't be Touched" as AnyObject, Meme.topTextKey:"Y'all Musta Forget" as AnyObject],
            [Meme.imageKey:"Burley" as AnyObject, Meme.nameKey:"Mike McCallum" as AnyObject, Meme.bottomTextKey:"Can't be Touched" as AnyObject, Meme.topTextKey:"Y'all Musta Forget" as AnyObject],
            [Meme.imageKey:"Burley" as AnyObject, Meme.nameKey:"Sam Langford" as AnyObject, Meme.bottomTextKey:"Can't be Touched" as AnyObject, Meme.topTextKey:"Y'all Musta Forget" as AnyObject],
            [Meme.imageKey:"Burley" as AnyObject, Meme.nameKey:"Charley Burley" as AnyObject, Meme.bottomTextKey:"Black Muderers" as AnyObject, Meme.topTextKey:"Row" as AnyObject],
            [Meme.imageKey:"Burley" as AnyObject, Meme.nameKey:"Willie Pep" as AnyObject, Meme.bottomTextKey:"Can't be Touched" as AnyObject, Meme.topTextKey:"Y'all Musta Forget" as AnyObject],
            [Meme.imageKey:"Burley" as AnyObject, Meme.nameKey:"Eusebio Pedroza" as AnyObject, Meme.bottomTextKey:"Can't be Touched" as AnyObject, Meme.topTextKey:"Y'all Musta Forget" as AnyObject],
            [Meme.imageKey:"Burley" as AnyObject, Meme.nameKey:"Mike Tyson" as AnyObject, Meme.bottomTextKey:"Can't be Touched" as AnyObject, Meme.topTextKey:"Y'all Musta Forget" as AnyObject],
            [Meme.imageKey:"Burley" as AnyObject, Meme.nameKey:"George Foreman" as AnyObject, Meme.bottomTextKey:"Can't be Touched" as AnyObject, Meme.topTextKey:"Y'all Musta Forget" as AnyObject]
        ]
    }
}
