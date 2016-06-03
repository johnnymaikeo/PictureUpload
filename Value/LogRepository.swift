//
//  LogRepository.swift
//  Value
//
//  Created by Johnny on 6/2/16.
//  Copyright © 2016 ExxonMobil. All rights reserved.
//

import Foundation
import CoreData

class LogRepository {

    var context: NSManagedObjectContext
    
    init () {
        self.context = DataController().managedObjectContext
    }
    
    func newLog() -> Log {
        let log:Log = NSEntityDescription.insertNewObjectForEntityForName("Log", inManagedObjectContext: self.context) as! Log
        return log
    }
    
    func save() -> Void {
        do {
            try self.context.save()
        } catch _ {
        
        }
    }
    
    func list() -> Array<Log> {
        let request = NSFetchRequest(entityName: "Log")
        
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        
        var history:[Log]
        
        do {
            history = try self.context.executeFetchRequest(request) as! [Log]
        } catch _ {
            history = []
        }
        return history
    }
    
}
