//
//  TweetTableViewCell.swift
//  Smashag
//
//  Created by Chen Cen on 10/15/16.
//  Copyright © 2016 Chen Cen. All rights reserved.
//

import UIKit
import Twitter

class TweetTableViewCell: UITableViewCell {
    @IBOutlet weak var tweetProfileImageView: UIImageView!

    @IBOutlet weak var tweetTextLabel: UILabel!
    
    @IBOutlet weak var tweetCreatedLabel: UILabel!
    
    @IBOutlet weak var tweetScreenNameTable: UILabel!
    
    var tweet:Tweet? {
        didSet {
            updateUI()
        }
    }
    
    private func updateUI() {
        tweetTextLabel?.attributedText = nil
        tweetScreenNameTable?.text = nil
        tweetProfileImageView?.image = nil
        tweetCreatedLabel?.text = nil
        
        if let tweet = self.tweet {
            tweetTextLabel?.text = tweet.text
            
            if tweetTextLabel?.text != nil {
                for _ in tweet.media {
                    tweetTextLabel.text! += " 📸"
                }
            }
            tweetScreenNameTable?.text = "\(tweet.user)"
            
            if let profileImageUrl = tweet.user.profileImageURL {
                // blocks main thread
//                if let imageData = NSData(contentsOf: profileImageUrl as URL) {
//                    self.tweetProfileImageView?.image = UIImage(data: imageData as Data)
//                }
                // pics comes later
                DispatchQueue.global(qos: .userInteractive).async {
                    if let imageData = NSData(contentsOf: profileImageUrl as URL) {
                        self.tweetProfileImageView?.image = UIImage(data: imageData as Data)
                    }
                }
            }
            
            let formatter = DateFormatter()
            if NSDate().timeIntervalSince(tweet.created as Date) > 24 * 60 * 60 {
                formatter.dateStyle = DateFormatter.Style.short
            } else  {
                formatter.timeStyle = DateFormatter.Style.short
            }
            tweetCreatedLabel?.text = formatter.string(from: tweet.created as Date)
        }
    }
}
