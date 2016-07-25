//
//  CDHelper.swift
//  CoreDataStack
//
//  Created by kengo hiwatashi on 7/17/16.
//  Copyright © 2016 appleplusminus. All rights reserved.
//

import Foundation
import CoreData

class CDHelper {
    
    static let sharedInstance = CDHelper()
    
    lazy var storesDirectory: NSURL = {
        
        let fm = NSFileManager.defaultManager()
        
        let urls = fm.URLsForDirectory(NSSearchPathDirectory.DocumentDirectory, inDomains: NSSearchPathDomainMask.UserDomainMask)
        
        return urls[urls.count - 1] as NSURL
        
    }()
    
    lazy var localStoreURL: NSURL = {
        
        let url = self.storesDirectory.URLByAppendingPathComponent("CoreDataStack.sqlite")
        
        return url
        
    }()
    
    lazy var modelURL: NSURL = {
        
        let bundle = NSBundle.mainBundle()
        
        if let url = bundle.URLForResource("Model", withExtension: "momd") {
            return url
        }
        
        print("CRITICAL - Managed Object Model file not found")
        
        abort()
        
    }()
    
    lazy var model: NSManagedObjectModel = {
       
        return NSManagedObjectModel(contentsOfURL: self.modelURL)!
    }()
    
    lazy var coordinator: NSPersistentStoreCoordinator = {
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.model)
        
        do {
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: self.localStoreURL, options: nil)
        } catch {
            print("Could not add the persistent store")
            abort()
        }
        
        return coordinator
    }()
    
}
