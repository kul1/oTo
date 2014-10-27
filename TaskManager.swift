

import Foundation

import UIKit
import CoreData

// Global var
var taskMgr = TaskManager()
var dataArray = NSArray()
var tasksList = NSArray()





// Prepare to access TaskData through TaskManager
let appDel:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
let context:NSManagedObjectContext = appDel.managedObjectContext!
let ent = NSEntityDescription.entityForName("TaskData", inManagedObjectContext: context)

// Prepare to retrieve TaskData through TaskManager
let request = NSFetchRequest(entityName: "TaskData")


class TaskManager: NSObject {
    
    func loadData()->NSArray{
        request.returnsObjectsAsFaults = false
        var taskArray:NSArray = context.executeFetchRequest(request, error: nil)!
        if taskArray.count > 0 {
            println("Results found \(taskArray.count)")
        }else{
            println("No result from taskArray")
        }
        return taskArray
        
    }
    
    func save(){
        let appDel:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let context:NSManagedObjectContext = appDel.managedObjectContext!
        let ent = NSEntityDescription.entityForName("TaskData", inManagedObjectContext: context)
        context.save(nil)
    }
    
    

        
        
        
}


