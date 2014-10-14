//
//  SecondViewController.swift
//  oTo
//
//  Created by Kul on 9/29/2557 BE.
//  Copyright (c) 2557 Kul.com. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var txtName: UITextField!
    
    @IBOutlet weak var txtDesc: UITextField!
    
    @IBOutlet weak var txtAmont: UITextField!
    
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
        
    }

}

