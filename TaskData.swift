//
//  TaskData.swift
//  oTo
//
//  Created by Kul on 10/13/2557 BE.
//  Copyright (c) 2557 Kul.com. All rights reserved.
//

import Foundation
import CoreData

class TaskData: NSManagedObject {

    @NSManaged var taskAmnt: String
    @NSManaged var taskDesc: String
    @NSManaged var taskName: String
    @NSManaged var taskImge: NSData

}
