//
//  TweetCell.swift
//  twitter_alamofire_demo
//
//  Created by Vidhu Appalaraju on 10/11/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit


class TweetCell: UITableViewCell {

    @IBOutlet weak var tweetText: UILabel!
    @IBOutlet weak var tweetCreatedAt: UILabel!
    @IBOutlet weak var tweetScreenName: UILabel!
    @IBOutlet weak var tweetUsername: UILabel!
    @IBOutlet weak var tweetPicture: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var tweet:Tweet!{
        didSet{
            tweetText.text = tweet.text
            tweetCreatedAt.text = tweet.createdAtString
            tweetUsername.text = tweet.user.name
            tweetScreenName.text = tweet.user.screenName
            tweetPicture.af_setImage(withURL: tweet.user.profilepic!)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
