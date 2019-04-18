//
//  Contacts+CoreDataProperties.swift
//  MachineTest
//
//  Created by Leo Elstin on 26/03/19.
//  Copyright © 2019 Leo Elstin. All rights reserved.
//
//

import Foundation
import CoreData


extension Contacts {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Contacts> {
        return NSFetchRequest<Contacts>(entityName: "Contacts")
    }

    @NSManaged public var name: String?
    @NSManaged public var phnumber: String?

}
