//
//  Email+CoreDataProperties.swift
//  
//
//  Created by Mohammed on 6/26/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Email {

    @NSManaged var content: String?
    @NSManaged var from: String?
    @NSManaged var header: String?
    @NSManaged var isRead: NSNumber?
    @NSManaged var time: String?

}
