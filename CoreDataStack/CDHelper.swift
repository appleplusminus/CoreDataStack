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
    
}
