//
//  CoreDataStack.swift
//  TrippNmemes
//
//  Created by Michelle Grover on 7/31/18.
//  Copyright © 2018 Norbert Grover. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    let persistentContainer:NSPersistentContainer
    
    var viewContext:NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    init(modelName:String) {
        persistentContainer = NSPersistentContainer(name: modelName)
    }
    
    func load(completion:(() -> ())? = nil) {
        
        persistentContainer.loadPersistentStores { storeDescription, error in
            guard error == nil else {
                fatalError(error!.localizedDescription)
            }

            completion?()
        }
    }
    
    var memeObjArray = [MemeObj]()
    
    class func sharedInstance() -> CoreDataStack {
        struct Singleton {
            static var sharedInstance = CoreDataStack(modelName: "Model")
        }
        return Singleton.sharedInstance
    }
}
