//
//  FirstViewController.swift
//  oTo
//
//  Created by Kul on 9/29/2557 BE.
//  Copyright (c) 2557 Kul.com. All rights reserved.
//

import UIKit
import CoreData

// Global name for our local png photo
let noPhotoPNG = "Image.jpg"

class FirstViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var tasks:NSMutableArray = NSMutableArray()
    
    @IBOutlet weak var FirstView: UITableView!
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()  
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    // Prepare for Segue FullViewSeque
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "FullViewSeque"){
            //Pass the data to the new viewController
            let controller: FullViewController = segue.destinationViewController as FullViewController
            

            
            
            let indexPath: NSIndexPath = self.FirstView.indexPathForCell(sender as UITableViewCell)!
            
            if (self.tasks.count > 0){
                println("Deleted  ")
                println(" self.tasks.count before seleted= \(self.tasks.count)")
                let infoDict:NSDictionary = self.tasks.objectAtIndex(indexPath.row) as NSDictionary

//                let identifier:NSString = infoDict.objectForKey("identifier") as NSString
////                println ("identifier before predicate delete == '\(identifier)'")
//                let predicate:NSPredicate = NSPredicate(format: "identifier == '\(identifier)'")!
//                let appDel:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
//                let moc:NSManagedObjectContext = appDel.managedObjectContext!
//                let request = NSFetchRequest(entityName: "TaskData")
//                request.returnsObjectsAsFaults = false
//                let results:NSArray = appDel.fetchEntities(NSStringFromClass(TaskData), withPredicate: predicate, managedObjectContext: moc)
                
////
                let moc:NSManagedObjectContext = SwiftCoreDataHelper.managedObjectContext()
                let identifier:NSString = infoDict.objectForKey("identifier") as NSString
                let predicate:NSPredicate = NSPredicate(format: "identifier == '\(identifier)'")!
                let results:NSArray = appDel.fetchEntities(NSStringFromClass(TaskData), withPredicate: predicate, managedObjectContext: moc)
////
                let taskToSelect:TaskData = results.lastObject as TaskData!
                
// Pass the data to the next view controller
               controller.photoFullURL  = taskToSelect.photoFullURL
                
                println("tasks count after show photoFull = \(tasks.count)")
                println("fetch results =  \(results.count)")

            }
           
        }
    }
    
    
    
    
    

    // Add to follow ContactU
    
    override func viewDidAppear(animated: Bool){
        super.viewDidAppear(animated)
        loadData()
        self.FirstView.reloadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return tasks.count
    }
    
    func loadData(){
        tasks.removeAllObjects()
        println("There area \(tasks.count) tasks.count at begin loadData ")


        let moc:NSManagedObjectContext = SwiftCoreDataHelper.managedObjectContext()
        let results:NSArray = SwiftCoreDataHelper.fetchEntities(NSStringFromClass(TaskData), withPredicate: nil, managedObjectContext: moc)
       
        
//        let appDel:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
//        let moc:NSManagedObjectContext = appDel.managedObjectContext!
//        let ent = NSEntityDescription.entityForName("TaskData", inManagedObjectContext: moc)
//        let request = NSFetchRequest(entityName: "TaskData")
//        request.returnsObjectsAsFaults = false
//        var results:NSArray = moc.executeFetchRequest(request, error: nil)!
        
        if results.count > 0 {
            for task  in results{
                
                let singleTask:TaskData = task as TaskData
                let identifier = singleTask.identifier
                let name = singleTask.taskName
                let photoFullURL = singleTask.photoFullURL
                let photoThumbURL = singleTask.photoThumbURL
                let desc = singleTask.taskDesc
                let amnt = singleTask.taskAmnt
                let image:UIImage = UIImage()
                if (UIImage(data: singleTask.taskImage) != nil) {
                    let image:UIImage = UIImage(data: singleTask.taskImage)!
                } else {
                    let image:UIImage = UIImage(named:"Image.jpg")!
                }
                
                let taskDict:NSDictionary = ["name":name,"desc":desc, "amount":amnt, "image":image, "identifier":identifier, "photoFullURL": photoFullURL, "photoThumbURL": photoThumbURL]

                tasks.addObject(taskDict)
            }
            
            let dateDescriptor:NSSortDescriptor = NSSortDescriptor(key: "name", ascending: true)
            var sortedArray:NSArray = tasks.sortedArrayUsingDescriptors([dateDescriptor])
            tasks = NSMutableArray(array: sortedArray)
            
            println("There are \(tasks.count) tasks.count at end loadData")
            
            
//            reloadInputViews()
            
        }
        
    }
    
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:CustomCell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as CustomCell
        
        let infoDict:NSDictionary = tasks.objectAtIndex(indexPath.row) as NSDictionary
//        var task:NSArray = tasks(indexPath.row) as NSArray
        
        
        let identifier = infoDict.objectForKey("identifier") as String
        let taskName = infoDict.objectForKey("name")! as String
        let taskDesc = infoDict.objectForKey("desc")! as String
        let taskAmnt = infoDict.objectForKey("amount") as String
        
//        let imageData = infoDict.objectForKey("image") as NSData
        let photoFullURL = infoDict.objectForKey("photoFullURL") as String
        let photoThumbURL = infoDict.objectForKey("photoThumbURL") as String

        // 
        //get contents and put into cell

        
        
        let noPhotoStr = NSURL(fileURLWithPath: noPhotoPNG)?.absoluteString!
        
        if(photoFullURL != noPhotoStr){
            let paths: NSArray = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
            let documentsDir: NSString = paths.objectAtIndex(0) as NSString
            
            let path: NSString = documentsDir.stringByAppendingString(photoFullURL)
            cell.cellImage.image = UIImage(contentsOfFile: path)
            println(" photoFullURL = \(path)")
        }else{
            cell.cellImage.image = UIImage(named: "Image.jpg")
        }

    
        

        //Prepare imageFrame
        var taskImageFrame:CGRect = cell.cellImage.frame
        taskImageFrame.size = CGSize(width: 75,height: 75)
        cell.cellImage.frame = taskImageFrame


    
        cell.setCell(taskName, rightLabelText: taskDesc, centerLabelText: taskAmnt)

        
        
                if indexPath.row % 2 == 0
        {
            cell.backgroundColor = UIColor.purpleColor()
        }
        else
        {
            cell.backgroundColor = UIColor.orangeColor()
        }

        return cell
        
    }
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath){
        



//
//            moc.deleteObject(tasks.objectAtIndex(indexPath.row) as NSManagedObject)
//            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            


            

        
        

        if (self.tasks.count > 0){
            println("Deleted  ")
            println(" self.tasks.count before deleted= \(self.tasks.count)")
            let infoDict:NSDictionary = self.tasks.objectAtIndex(indexPath.row) as NSDictionary
            
            
            let moc:NSManagedObjectContext = SwiftCoreDataHelper.managedObjectContext()
            let identifier:NSString = infoDict.objectForKey("identifier") as NSString
            let predicate:NSPredicate = NSPredicate(format: "identifier == '\(identifier)'")!
            let results:NSArray = appDel.fetchEntities(NSStringFromClass(TaskData), withPredicate: predicate, managedObjectContext: moc)

//
//            let identifier:NSString = infoDict.objectForKey("identifier") as NSString
//            
//            println ("identifier before predicate delete == '\(identifier)'")
//
//            let predicate:NSPredicate = NSPredicate(format: "identifier == '\(identifier)'")!
//
//            let appDel:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
//            let moc:NSManagedObjectContext = appDel.managedObjectContext!
//            
//            let request = NSFetchRequest(entityName: "TaskData")
//            request.returnsObjectsAsFaults = false
////            var results:NSArray = moc.executeFetchRequest(request, error: nil)!
//            let results:NSArray = appDel.fetchEntities(NSStringFromClass(TaskData), withPredicate: predicate, managedObjectContext: moc)
            
            
            let taskToDelete:TaskData = results.lastObject as TaskData!
            
            println("taskToDelete \(taskToDelete.identifier)")

            
            taskToDelete.managedObjectContext?.deleteObject(taskToDelete)

            println("after delete tasks = \(tasks.count)")
            println("after delete results =  \(results.count)")
            
            // Save


            SwiftCoreDataHelper.saveManagedObjectContext(moc)
//            moc.save(nil)
            
            self.loadData()
            self.FirstView.reloadData()

//        }
            println("after delete \(tasks.count)")
        }

        
        self.FirstView.reloadData()
    
    }



    // Data manipulation - reorder / moving support

    func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath){
        
    }


        

}
    


