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
    @IBOutlet weak var tweetFavoriteCount: UILabel!
    @IBOutlet weak var tweetFavButton: UIButton!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBOutlet weak var tweetRetweetCount: UILabel!
    @IBOutlet weak var tweetRetweetButton: UIButton!
    var tweet:Tweet!{
        didSet{
            refreshData()
        }
    }
  
    func refreshData() {
        tweetText.text = tweet.text
        tweetCreatedAt.text = tweet.createdAtString
        tweetUsername.text = tweet.user.name
        tweetScreenName.text = "@" + tweet.user.screenName!
        tweetPicture.af_setImage(withURL: tweet.user.profilepic!)
        tweetRetweetCount.text = String(tweet.retweetCount)
        tweetFavoriteCount.text = String(tweet.favoriteCount!)
        
        if tweet.favorited! {
            tweetFavButton.setImage(#imageLiteral(resourceName: "favor-icon-red"), for: .normal)
        }
        else{
            tweetFavButton.setImage(#imageLiteral(resourceName: "favor-icon"), for: .normal)
        }
        if tweet.retweeted {
            tweetRetweetButton.setImage(#imageLiteral(resourceName: "retweet-icon-green"), for: .normal)
        }
        else{
             tweetRetweetButton.setImage(#imageLiteral(resourceName: "retweet-icon"), for: .normal)
        }
    }
    
    @IBAction func didTapFavorite(_ sender: Any) {
        if tweet.favorited! {
            APIManager.shared.unfavorite(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully unfavorited the following Tweet: \n\(tweet.text)")
                    tweet.favorited = false
                    tweet.favoriteCount! -= 1
                    self.tweet = tweet
                    //self.tweetFavButton.setImage(#imageLiteral(resourceName: "favor-icon"), for: .normal)
                   // self.tweetFavoriteCount.text = String(tweet.favoriteCount!)
                }
            }
        }
        else{
            APIManager.shared.favorite(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully favorited the following Tweet: \n\(tweet.text)")
                    tweet.favorited = true
                    tweet.favoriteCount! += 1
                    self.tweet = tweet
                   // self.tweetFavButton.setImage(#imageLiteral(resourceName: "favor-icon-red"), for: .normal)
                   // self.tweetFavoriteCount.text = String(tweet.favoriteCount!)
                }
            }
        }
        
        //self.refreshData()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
