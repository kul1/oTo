//
//  SecondViewController.swift
//  oTo
//
//  Created by Kul on 9/29/2557 BE.
//  Copyright (c) 2557 Kul.com. All rights reserved.
//

import UIKit
import CoreData

class SecondViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var txtName: UITextField! = UITextField()
    
    @IBOutlet weak var txtDesc: UITextField! = UITextField()
    
    @IBOutlet weak var txtAmount: UITextField! = UITextField()
    
    @IBOutlet weak var myImage: UIImageView! = UIImageView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let tapGestureRecognizer:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "chooseImage:")
        tapGestureRecognizer.numberOfTapsRequired = 1
        myImage.addGestureRecognizer(tapGestureRecognizer)
        myImage.userInteractionEnabled = true
    }
    
    func chooseImage(recognizer: UITapGestureRecognizer){
        let imagePicker:UIImagePickerController = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(imagePicker, animated: true , completion: nil)
    }
    
    func scaleImageWith(image:UIImage, newSize:CGSize)->UIImage{
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.drawInRect(CGRectMake(0, 0, newSize.width, newSize.height))
        
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: NSDictionary!){
        let pickedImage:UIImage = info.objectForKey(UIImagePickerControllerOriginalImage) as UIImage
        // smapp picture
        let smallPicture = scaleImageWith(pickedImage, newSize: CGSizeMake(300, 300))
        
        var sizeOfImageView:CGRect = myImage.frame
        sizeOfImageView.size = smallPicture.size
        myImage.frame = sizeOfImageView
        
        myImage.image = smallPicture
        picker.dismissViewControllerAnimated(true , completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true , completion: nil)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func add_Button(sender: AnyObject) {
        println("Add Button Clicked")
//        // Prepare to access TaskData through TaskManager
//        let appDel:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
//        let context:NSManagedObjectContext = appDel.managedObjectContext!
//        let ent = NSEntityDescription.entityForName("TaskData", inManagedObjectContext: context)
//        
//        var newTaskData = TaskData(entity: ent!, insertIntoManagedObjectContext: context)
//        
        let moc:NSManagedObjectContext = SwiftCoreDataHelper.managedObjectContext()
        var newTaskData:TaskData = SwiftCoreDataHelper.insertManagedObject(NSStringFromClass(TaskData), managedObjectConect: moc)
         as TaskData
        
        
        
        let myImagedata:NSData = UIImagePNGRepresentation(myImage.image)

        
        newTaskData.identifier = "\(NSDate())"
        newTaskData.taskName = txtName.text
        newTaskData.taskDesc = txtDesc.text
        newTaskData.taskAmnt = txtAmount.text
        newTaskData.taskImage = myImagedata
        
//        context.save(nil)
        SwiftCoreDataHelper.saveManagedObjectContext(moc)
        
        // Clear Text Field
        
        txtName.text = ""
        txtDesc.text = ""
        txtAmount.text = ""
        
        // Clear Image ??
        myImage.image   = UIImage(named: "Image.jpg")
        
        self.navigationController?.popViewControllerAnimated(true)
     
    }

}

