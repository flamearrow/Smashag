//
//  TwitterUser+CoreDataClass.swift
//  Smashag
//
//  Created by Chen Cen on 10/20/16.
//  Copyright © 2016 Chen Cen. All rights reserved.
//

import Foundation
import CoreData
import Twitter


public class TwitterUser: NSManagedObject {
    class func TwitterUserWithTwitterInfo(twitterInfo: Twitter.User, managedObjectContext context: NSManagedObjectContext) -> TwitterUser {
        // search and fetch
        let fetchReq:NSFetchRequest<TwitterUser> = TwitterUser.fetchRequest()
        
        fetchReq.predicate = NSPredicate(format:"screenName = %@", twitterInfo.screenName)

        if let tUser = (try?context.fetch(fetchReq))?.first {
            return tUser
        } else {
            let tUser = TwitterUser(entity: TwitterUser.entity(), insertInto: context)
            tUser.screenName = twitterInfo.screenName
            tUser.name = twitterInfo.name
            return tUser
        }
    }

}
