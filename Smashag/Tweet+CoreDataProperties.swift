//
//  Tweet+CoreDataProperties.swift
//  Smashag
//
//  Created by Chen Cen on 10/20/16.
//  Copyright © 2016 Chen Cen. All rights reserved.
//

import Foundation
import CoreData

extension Tweet {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tweet> {
        return NSFetchRequest<Tweet>(entityName: "Tweet");
    }

    @NSManaged public var unique: String?
    @NSManaged public var text: String?
    @NSManaged public var posted: NSDate?
    @NSManaged public var tweeter: TwitterUser?

}
