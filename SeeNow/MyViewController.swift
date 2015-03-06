//
//  MyViewController.swift
//  SeeNow
//
//  Created by apple on 14/12/5.
//  Copyright (c) 2014年 apple. All rights reserved.
//

import UIKit

class MyViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,HttpProtocol {

    //图片缓存
    var imageCache = Dictionary<String,UIImage>()
    //头部
    var topView:UIView = UIView(frame: CGRectMake(0, 0, 1024, 68))
    //底部
   // var endView:UIView = UIView(frame: CGRectMake(0, 700, 1024, 68))
    
    var MainTableView:UITableView = UITableView(frame: CGRectMake(0,68, 1024, 768), style: UITableViewStyle.Plain)
    //子页面
    var childView:UIView = UIView(frame: CGRectMake(1024, 0, 391, 768))
    //申报书页面
    var SbsView:UIView = UIView(frame: CGRectMake(-633, 0, 633, 768))
    let SbsHeader:UIView = UIView(frame:CGRectMake(0, 0, 633, 68))
    let SbsMainView:UIWebView = UIWebView(frame: CGRectMake(0, 68, 633, 768))
    let lblForName = UILabel(frame: CGRectMake(10, 10, 200, 25))
    //测试按钮
    let btnSee = UIButton(frame: CGRectMake(50, 50, 50, 35))
    //接收数据
    var CyList:NSArray = NSArray()
    //评审组ID
    var PszId = 280
    
    var eHttp:HttpController = HttpController()
    
    let frame1 = CGRectMake(1024, 0, 391, 768)
    let frame2 = CGRectMake( 633, 0, 391, 768)
    let frame3 = CGRectMake(0, 0, 633, 768)
    let frame4 = CGRectMake(-633, 0, 633, 768)
    
    override func viewDidLoad() {
        super.viewDidLoad()
         MainTableView.delegate = self
        MainTableView.dataSource = self
        //加背景
        topView.backgroundColor = UIColor(patternImage: UIImage(named: "topng.jpg")!)
        MainTableView.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(topView)
        self.view.addSubview(MainTableView)
        //子视图添加控件
         childView.addSubview(lblForName)
        childView.addSubview(btnSee)
        childView.backgroundColor = UIColor.whiteColor()
        
        SbsView.backgroundColor = UIColor.whiteColor()
        
        //添加手势
        let wisSbsView = UISwipeGestureRecognizer(target: self, action: "HideSbsView:")
        let wis = UISwipeGestureRecognizer(target: self, action: "HideChild:")
        wisSbsView.direction = UISwipeGestureRecognizerDirection.Left
        wis.direction = UISwipeGestureRecognizerDirection.Right
        SbsView.addGestureRecognizer(wisSbsView)
        childView.addGestureRecognizer(wis)
        self.view.addSubview(SbsView)
        self.view.addSubview(childView)
        
        let CyListUrl = GetService + "which=CyList&PszId=\(PszId)"
        eHttp.delegate = self
        eHttp.onSearch(CyListUrl)
        // Do any additional setup after loading the view.
    }
    //接收返回的数据
    func didReceiveResult(result: NSDictionary) {
        if(result.allKeys[0] as NSString == "CyList"){
            if result["CyList"] != nil{
                self.CyList = result["CyList"] as NSArray
                dispatch_async(dispatch_get_main_queue(), {self.MainTableView.reloadData()})
                
            }
        }
    }
    
    func HideChild(sender:UISwipeGestureRecognizer){
        
        UIView.animateWithDuration(0.5, animations: {
            self.childView.frame = self.frame1
        })
    }
    
    func HideSbsView(sender:UISwipeGestureRecognizer){
        UIView.animateWithDuration(0.5, animations: {
            self.SbsView.frame = self.frame4
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return CyList.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CyCell", forIndexPath: indexPath) as PerCell
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        let rowData = CyList[indexPath.row] as NSDictionary
        cell.lblName.text = rowData["Xm_zw"] as NSString
        cell.DetailLabel.text = rowData["Qymc"] as NSString
        //照片路径
        if rowData["Fjlj"] == nil{
            //cell.perImageView.image = UIImage(named: "grayicon.png")
        }else
        {
            let picRelative = rowData["Fjlj"] as NSString
            let image = imageCache[picRelative]
            if image != nil{
                //cell.perImageView.image = image!
            }else{
                //个人照片地址
                let pic = FjUrl + picRelative
                let imgUrl = NSURL(string: pic)!
                let request:NSURLRequest = NSURLRequest(URL: imgUrl)
                NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response,data,error)->Void in
                    let img = UIImage(data: data)
                    //cell.perImageView.image = img!
                    self.imageCache[picRelative] = img
                })
            }
        }
        return cell
    }
    //计数器
    var selNum:Int=0
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        let nowframe = childView.frame
//        if nowframe == frame1{
//            selNum = indexPath.row
//            UITableViewCell.animateWithDuration(0.5, animations: {
//                self.drawView(indexPath.row)
//                self.childView.frame = self.frame2
//            })
//        }else if nowframe == frame2 {
//            if indexPath.row == selNum {
//                UITableViewCell.animateWithDuration(0.5, animations: {
//                    self.childView.frame = self.frame1
//                      })
//                }else {
//
//                UITableViewCell.animateWithDuration(0.5, animations: {self.childView.frame = self.frame1}, completion: {(bool)->Void in
//                    UITableViewCell.animateWithDuration(0.5, animations: {
//                        self.drawView(indexPath.row)
//                        self.childView.frame = self.frame2
//                        
//                    })
//                })
//
//                selNum = Int(indexPath.row)
//           }
//        }
        var gotoController = CardViewController()
        gotoController.InfoList = CyList
        gotoController.count = indexPath.row
        self.presentViewController(gotoController, animated: true, completion: nil)
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    //画子视图
    func drawView(indexRow:Int){
        
        let rowData = CyList[indexRow] as NSDictionary
      
        let Xm = rowData["Xm_zw"]! as NSString
        btnSee.backgroundColor = UIColor.blueColor()
        btnSee.setTitle("测试", forState: UIControlState.Normal)
        addUrl(rowData["Sbsid"] as NSString)
        btnSee.addTarget(self, action: "btnSeeClick:", forControlEvents: UIControlEvents.TouchUpInside)
        lblForName.text = "姓 名：      \(Xm)"
        //self.childView.reloadInputViews()
    }
    
    func btnSeeClick(sender:UIButton){

        let nowFrame = SbsView.frame
        if nowFrame == frame4 {
            UIButton.animateWithDuration(0.5, animations: {
                self.SbsView.addSubview(self.SbsHeader)
                self.SbsView.addSubview(self.SbsMainView)
                self.SbsView.frame = self.frame3
            })
        }else{
            UIButton.animateWithDuration(0.5, animations: {
                self.SbsView.frame = self.frame4
            })
        }
    }
    func addUrl(Sbbh:NSString){
        let SbsUrl = HWZPUrl + "CySbs/CySbs.aspx?Sbbh=" + Sbbh
        let url = NSURL(string: SbsUrl)!
        let request = NSURLRequest(URL: url)
        SbsMainView.loadRequest(request)
    }
    
    func drowTable(indexRow:Int){
        
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
