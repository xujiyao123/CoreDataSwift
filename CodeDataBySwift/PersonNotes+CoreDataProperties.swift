//
//  PersonNotes+CoreDataProperties.swift
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

extension PersonNotes {

    @NSManaged var content: String?
    @NSManaged var time: String?
    @NSManaged var maker: LogIn?

}
