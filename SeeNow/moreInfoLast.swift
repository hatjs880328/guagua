//
//  moreInfoLast.swift
//  SeeNow
//
//  Created by apple on 15/1/22.
//  Copyright (c) 2015年 apple. All rights reserved.
//

import UIKit

class moreInfoLast: UITableViewController {

    //全局开始
    var width:CGFloat = 0.0
    var height:CGFloat = 0.0
    var DataSource:NSArray = NSArray()
    //全局结束
    
    override func viewDidLoad() {
        super.viewDidLoad()
        width = self.view.bounds.width
        height = self.view.bounds.height
        
        
        let refleshControl = UIRefreshControl()
        refleshControl.attributedTitle = NSAttributedString(string:"松开加载数据")
        refleshControl.addTarget(self, action: "loadDataSource", forControlEvents: UIControlEvents.ValueChanged)
        self.refreshControl = refleshControl
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(animated: Bool) {
        
        var view3 = UIView(frame: CGRectMake(0, 0, width, 50))
        view3.backgroundColor = UIColor.yellowColor()
        self.view.bounds = CGRectMake(0, 50, width, height-100)
        self.view.addSubview(view3)
    }

    //数据加载
    func loadDataSource()
    {
        println("开始刷新数据了")
//        refreshControl?.beginRefreshing()
//        let NURL = NSURL(string:lUrl)
//        let request = NSURLRequest(URL: NURL!)
//        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response,data,error)->Void in
//            
//            var jsonData = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
//            let newsList = jsonData["item"] as NSArray
//            let HeaderNews = newsList[0] as NSDictionary
//            let headerImgURL = NSURL(string:HeaderNews["thumb"] as NSString)!
//            let request = NSURLRequest(URL: headerImgURL)
//            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response,data,error)->Void in
//                //self.imgHeader.image = UIImage(data: data)
//            })
//            //self.lblTitle.text = HeaderNews["title"] as NSString
//            self.DataSource = newsList
//            dispatch_async(dispatch_get_main_queue(), {self.tableView.reloadData()})
//        })
        refreshControl?.endRefreshing()
//        
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 6
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "mrshannew")

        // Configure the cell...

        return cell
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
