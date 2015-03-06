//
//  moreInfo.swift
//  SeeNow
//
//  Created by apple on 15/1/22.
//  Copyright (c) 2015年 apple. All rights reserved.
//

import UIKit

class moreInfo: UITableViewController {

    var width:CGFloat = 0.0
    var height:CGFloat = 0.0
    var DataSource:NSArray = NSArray()
    let lUrl:NSString = "http://qingbin.sinaapp.com/api/lists?ntype=%E5%9B%BE%E7%89%87&pageNo=1&pagePer=10&list.htm"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        width = self.view.bounds.width
        height = self.view.bounds.height
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        let refleshControl = UIRefreshControl()
        refleshControl.attributedTitle = NSAttributedString(string:"松开加载数据")
        refleshControl.addTarget(self, action: "loadDataSource", forControlEvents: UIControlEvents.ValueChanged)
        self.refreshControl = refleshControl
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    func loadDataSource()
    {
        refreshControl?.beginRefreshing()
        let NURL = NSURL(string:lUrl)
        let request = NSURLRequest(URL: NURL!)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response,data,error)->Void in
            
            var jsonData = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
            let newsList = jsonData["item"] as NSArray
            let HeaderNews = newsList[0] as NSDictionary
            let headerImgURL = NSURL(string:HeaderNews["thumb"] as NSString)!
            let request = NSURLRequest(URL: headerImgURL)
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response,data,error)->Void in
                //self.imgHeader.image = UIImage(data: data)
            })
            //self.lblTitle.text = HeaderNews["title"] as NSString
            self.DataSource = newsList
            dispatch_async(dispatch_get_main_queue(), {self.tableView.reloadData()})
        })
        refreshControl?.endRefreshing()
        
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return DataSource.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataSource.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "mashan5")
        let rowdatak = DataSource[indexPath.row] as NSDictionary
//        cell.textLabel?.text = rowData["title"] as NSString
//        cell.detailTextLabel?.text = rowData["id"] as NSString
        //获取图片
//        let imageURL = rowData["thumb"] as NSString
//        let imgURL = NSURL(string:imageURL)!
//        let request = NSURLRequest(URL: imgURL)
//        cell.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
//        cell.imageView?.image = UIImage(named: "1.png")
        //异步加载图片
//        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response,data,error)->Void in
//            dispatch_async(dispatch_get_main_queue(), {cell.imageView!.image = UIImage(data: data) })
//            })
        
        var lable = UILabel(frame: CGRectMake(15, 5, width/3, 30))
        lable.backgroundColor = UIColor.clearColor()
        lable.text = rowdatak["title"] as? String
        cell.contentView.addSubview(lable)
        let image = UIImageView(frame: CGRectMake(width/3*2, 5, 20, 20))
        image.image = UIImage(named: "ocrBack.png")
        cell.contentView.addSubview(image)
        cell.selectionStyle = UITableViewCellSelectionStyle.None

        return cell
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
