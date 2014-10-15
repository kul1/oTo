//
//  SecondViewController.swift
//  oTo
//
//  Created by Kul on 9/29/2557 BE.
//  Copyright (c) 2557 Kul.com. All rights reserved.
//

import UIKit
import CoreData

class SecondViewController: UIViewController {

    @IBOutlet weak var txtName: UITextField!
    
    @IBOutlet weak var txtDesc: UITextField!
    
    @IBOutlet weak var txtAmount: UITextField!
    
    @IBOutlet weak var myImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func add_Button(sender: AnyObject) {
        println("Add Button Clicked")
        // Prepare to access TaskData through TaskManager
        let appDel:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let context:NSManagedObjectContext = appDel.managedObjectContext!
        let ent = NSEntityDescription.entityForName("TaskData", inManagedObjectContext: context)
        
        var newTaskData = TaskData(entity: ent!, insertIntoManagedObjectContext: context)
        
        newTaskData.taskName = txtName.text
        newTaskData.taskDesc = txtDesc.text
        newTaskData.taskAmnt = txtAmount.text
        //newTaskData.taskImage = myImage.image
        context.save(nil)
        
        // Clear Text Field
        
        txtName.text = ""
        txtDesc.text = ""
        txtAmount.text = ""

        
        
        
    }

}

