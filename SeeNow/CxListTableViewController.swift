

import UIKit

class CxListTableViewController: UITableViewController,HttpProtocol {

    let frame1 = CGRectMake(1024, 0, 600, 768)
    let frame2 = CGRectMake( 633, 0, 391, 768)
    var testView = UIView(frame: CGRectMake(1024, 0, 600, 768))
    
    //评审组ID
    var PszId:Int = 279
    //数组For列表
    var CxList:NSArray = NSArray()
    
    var eHttp:HttpController = HttpController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let CxListUrl = GetService + "which=CxList&PszId=\(PszId)"
        eHttp.delegate = self
        eHttp.onSearch(CxListUrl)

    }
    //接收返回的数据
    func didReceiveResult(result: NSDictionary) {
        if(result.allKeys[0] as NSString == "CxList"){
            if result["CxList"] != nil{
            self.CxList = result["CxList"] as NSArray
           self.tableView.reloadData()
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Potentially incomplete method implementation.
//        // Return the number of sections.
//        return CxList.count
//    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.

        return CxList.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CCell", forIndexPath: indexPath) as UITableViewCell
        let rowData = CxList[indexPath.row] as NSDictionary
        cell.textLabel?.text = rowData["Xm_zw"] as NSString
        cell.detailTextLabel?.text = rowData["Gwdw"] as NSString

//        // Configure the cell...
//
        return cell
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        UITableViewCell.animateWithDuration(1, animations: {
            self.testView.frame = self.frame2
        })
        
    }
    
//    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        let cell = tableView.dequeueReusableCellWithIdentifier("CCell", forIndexPath: indexPath) as UITableViewCell
//        
//    }

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
