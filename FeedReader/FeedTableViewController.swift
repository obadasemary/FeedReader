//
//  FeedTableViewController.swift
//  FeedReader
//
//  Created by Abdelrahman Mohamed on 5/18/16.
//  Copyright © 2016 Abdelrahman Mohamed. All rights reserved.
//

import UIKit
import MWFeedParser
import SafariServices

class FeedTableViewController: UITableViewController, MWFeedParserDelegate {
    
    var feedItems = [MWFeedItem]()
    
    // MARK: - sharedContext
    
    func requset() {
        
        let url = NSURL(string: "http://feeds.nytimes.com/nyt/rss/Technology")
        let feedParser = MWFeedParser(feedURL: url)
        feedParser.delegate = self
        feedParser.parse()
    }
    
    // MARK: - FEED PARSER DELEGATE
    
    func feedParserDidStart(parser: MWFeedParser!) {
        feedItems = [MWFeedItem]()
    }
    
    func feedParserDidFinish(parser: MWFeedParser!) {
        self.tableView.reloadData()
    }
    
    func feedParser(parser: MWFeedParser!, didParseFeedInfo info: MWFeedInfo!) {
        self.title = info.title
    }
    
    func feedParser(parser: MWFeedParser!, didParseFeedItem item: MWFeedItem!) {
        feedItems.append(item)
    }
    
    // MARK: - SIDEBAR DELEGATE
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        requset()
    }

    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedItems.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        let item = feedItems[indexPath.row] as MWFeedItem
        cell.textLabel?.text = item.title

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let item = feedItems[indexPath.row] as MWFeedItem
        
        let url = NSURL(string: item.link)
        
        let safariController = SFSafariViewController(URL: url!, entersReaderIfAvailable: true)
        presentViewController(safariController, animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
