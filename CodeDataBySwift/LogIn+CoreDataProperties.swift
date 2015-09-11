//
//  LogIn+CoreDataProperties.swift
//  CodeDataBySwift
//
//  Created by 徐继垚 on 15/9/10.
//  Copyright © 2015年 徐继垚. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension LogIn {

    @NSManaged var password: String?
    @NSManaged var photo: NSData?
    @NSManaged var user: String?
    @NSManaged var notes: NSMutableArray?

}
