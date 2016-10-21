//
//  Tweet+CoreDataClass.swift
//  Smashag
//
//  Created by Chen Cen on 10/20/16.
//  Copyright © 2016 Chen Cen. All rights reserved.
//

import Foundation
import CoreData
import Twitter

public class Tweet: NSManagedObject {
    class func tweetWithTwitterInfo(twitterInfo: Twitter.Tweet, inManagedObjectContext context:NSManagedObjectContext) -> Tweet {
        // query data, this is genereated
        // swift 3 way to create a NSFetchRequest
        let request:NSFetchRequest<Tweet> = Tweet.fetchRequest()
        
        // 'reflection' way to create a fetchrequest
        //let _:NSFetchRequest<Tweet> = NSFetchRequest(entityName: "Tweet")
        
        request.predicate = NSPredicate(format:"unique = %@", twitterInfo.id!)
        
        
        // first search it, if not found, insert it
        if let tweet = (try? context.fetch(request))?.first {
            return tweet
        }
        // 'reflection' way to create an NSEntityDescription, NSManagedObject and down cast to Tweet
        // else if let tweet = NSEntityDescription.insertNewObject(forEntityName: "Tweet", into: context) as? Tweet {
        //    add values to tweet
        // }
        //
        else {
            // swift 3 way
            let tweet:Tweet = Tweet(entity: Tweet.entity(), insertInto: context)
            tweet.posted = twitterInfo.created
            tweet.unique = twitterInfo.id
            tweet.text = twitterInfo.description
            // build up the relationship, note you only need to do it in one direction
            tweet.tweeter = TwitterUser.TwitterUserWithTwitterInfo(twitterInfo: twitterInfo.user, managedObjectContext: context)
            return tweet
            
        }
        
        // if we declare return a option we do the nil return here
        // return nil
        
        // long version for search
//        do {
//            let queryResults = try context.fetch(request)
//            if let tweet = queryResults.first {
//                return tweet
//            }
//            
//        } catch _ {
//            // ignore
//            
//        }
        
        
    }
}
