//
//  TaskData.swift
//  oTo
//
//  Created by Kul on 10/15/2557 BE.
//  Copyright (c) 2557 Kul.com. All rights reserved.
//

import Foundation
import CoreData
@objc (TaskData)

class TaskData: NSManagedObject {
    @NSManaged var identifier: String
    @NSManaged var taskName: String
    @NSManaged var taskDesc: String
    @NSManaged var taskAmnt: String
    @NSManaged var taskImage: NSData
    @NSManaged var photoThumbURL: String
    @NSManaged var photoFullURL: String
}
