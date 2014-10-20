//
//  FirstViewController.swift
//  oTo
//
//  Created by Kul on 9/29/2557 BE.
//  Copyright (c) 2557 Kul.com. All rights reserved.
//

import UIKit
import CoreData

class FirstViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var toDoItems:NSMutableArray = NSMutableArray()


    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        println(taskMgr.taskLoad().count)
        return taskMgr.taskLoad().count
    }
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: CustomCell = tableView.dequeueReusableCellWithIdentifier("Cell") as CustomCell
        
        let appDel:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let context:NSManagedObjectContext = appDel.managedObjectContext!
        let ent = NSEntityDescription.entityForName("TaskData", inManagedObjectContext: context)
        let request = NSFetchRequest(entityName: "TaskData")
        var taskArray:NSArray = context.executeFetchRequest(request, error: nil)!
        
        let task:TaskData = taskArray[indexPath.row] as TaskData
        println("let task:TaskData = .....")
      //        cell.setCell(task.taskName, rightLabelText: task.taskDesc, imageName: "Image.jpg")
        cell.setCell(task.taskName, rightLabelText: task.taskDesc, centerLabelText: task.taskAmnt, imageName: task.taskImage)
        
        toDoItems.addObject(TaskData)

        
        
        
        




        
        
        
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
        println("Deleted")
        
        
    }
    
    
    
    // Data manipulation - reorder / moving support
    
    func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath){
        
    }


        
        

    

}

