//
//  adlistViewChild.swift
//  SeeNow
//
//  Created by apple on 15/1/27.
//  Copyright (c) 2015年 apple. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class adlistViewChild: UIViewController,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate {
    
    //全局变量开始
    var countall = 0
    var pagenow = 1
    var width:CGFloat = 0
    var height:CGFloat = 0
    var nowdata:NSArray = []
    var alldata:NSArray = []
    var aditemId = [AnyObject]()
    let topsearchview = UIView(frame: CGRectZero)
        var serchlabel = UITextField(frame: CGRectZero)
    let tableview = UITableView(frame: CGRectZero)
    let uiimageview = UIImageView(frame: CGRectZero)
    var colorall = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
    var bgcolorall = UIColor(red: 85/255, green: 169/255, blue: 254/255, alpha: 1)
    //全局变量结束
    override func viewDidLoad() {
        super.viewDidLoad()
        var hud:MBProgressHUD = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        hud.labelText = "正在加载";
        hud.dimBackground = true;
        
        width = self.view.bounds.width
        height = self.view.bounds.height
        //数据加载中，请稍后界面
//        self.view.backgroundColor = colorall
//        var label = UILabel(frame:CGRectMake(width/2-100, height/2-100, 200, 60))
//        label.text = "数据加载中，请稍后"
//        label.font = UIFont(name: "Arial-BoldItalicMT", size: 15)
//        label.textAlignment = NSTextAlignment.Center
//        label.textColor = UIColor.blackColor()
//        self.view.addSubview(label)
//        var ac = UIActivityIndicatorView(frame: CGRectMake(self.width/2-20, height/2-20, 40, 40))
//        ac.backgroundColor = colorall
//        self.view.addSubview(ac)
//        ac.startAnimating()
        //加载数据
        getData()
    }
    
    override func viewDidAppear(animated: Bool) {
        //sleep(2)
        //隐藏加载图片
        //self.uiimageview.alpha = 0
        searchSetting()
        midtableSetting()
        MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
    }
    //get data func
    func getData(){
        let Parameters = [
            "mparams":"{\"CurrPage\":\"\(pagenow)\",\"PageSize\":\"10\",\"AI_nAdCategoryID\":\"\(adlistChildparentId!)\",\"KeyWords\":\"\",\"AI_nAdTypeID\":\"8\"}"
        ]
        Alamofire.request(.POST,
            "http://qlgg.net:8888/PhoneAPI/PhoneAPI.asmx/FindAdDocumentByConditions",
            parameters: Parameters)
            .responseString{(request,response,string4,error) in
                var nsdata = string4?.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
                if(nsdata != nil){
                var result = NSJSONSerialization.JSONObjectWithData(nsdata!, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
                if (result["result"]?.count >= 1) {
                    //println(result["result"])
                    if(self.alldata.count != 0){
                        //非第一次加载信息
                        self.nowdata = result["result"] as NSArray
                        if(!self.alldata.containsObject(self.nowdata[0])){
                            self.alldata = self.alldata.arrayByAddingObjectsFromArray(self.nowdata)
                            self.countall = self.alldata.count
                            self.pagenow = self.pagenow + 1
                            //重新加载数据
                            self.tableview.reloadData()
                        }else{
                            //已经包含了就不需要在向ALLdata上加数据
                        }
                    }else{
                        //第一次加载信息
                        self.nowdata = result["result"] as NSArray
                        self.alldata = self.alldata.arrayByAddingObjectsFromArray(self.nowdata)
                        self.countall = self.alldata.count
                        self.pagenow = self.pagenow + 1
                        //重新加载数据
                        self.tableview.reloadData()
                    }
                }else{
                    var alert = UIAlertView(title: "提醒", message: "此处没有信息了！", delegate: self, cancelButtonTitle: "好")
                    alert.show()
                    if(self.countall == 0){
                        var con = adlistView()
                        self.presentViewController(con, animated: false, completion: nil)
                    }
                }
                }else{
                    
                }
        }
    }
    
    //searchview
    func searchSetting(){
        let frame = CGRectMake(0, 0, width, 50)
        self.topsearchview.frame = frame
        self.topsearchview.backgroundColor = colorall
        self.view.addSubview(topsearchview)
        var returnbut = UIButton(frame: CGRectMake(5, 12, 37, 37))
        returnbut.backgroundColor = UIColor(patternImage: UIImage(named: "ocrBack.png")!)
        //returnbut.setTitle("back", forState: UIControlState.Normal)
        returnbut.addTarget(self, action: "goback:", forControlEvents: UIControlEvents.TouchUpInside)
        self.topsearchview.addSubview(returnbut)
        
        serchlabel = UITextField(frame: CGRectMake(width/2-100, 25, 200, 20))
        serchlabel.layer.cornerRadius = 10
        serchlabel.layer.masksToBounds = true
        serchlabel.textAlignment = NSTextAlignment.Center
        serchlabel.text = "请输入要查找的信息"
        serchlabel.font = UIFont(name: "Arial-BoldItalicMT", size: 14)
        serchlabel.backgroundColor = UIColor.whiteColor()
        self.topsearchview.addSubview(serchlabel)
        serchlabel.delegate = self
    }
    
    //返回按钮
    func goback(sender:UIButton){
        var con = adlistView()
        self.presentViewController(con, animated: false, completion: nil)
    }
    
    //mid   tableview
    func midtableSetting(){
        self.tableview.delegate = self
        self.tableview.dataSource = self
        var frame = CGRectMake(0, 50, width, height-50)
        self.tableview.frame = frame
        self.tableview.backgroundColor = colorall
        self.view.addSubview(tableview)
    }
    
    //mid   tableview delegate1
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return alldata.count
    }
    
    //mid   tableview delegate2
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        if(indexPath.row == countall-1){
            if(self.countall < 10){
            }
            else{
                getData()
            }
        }
        var cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "mrshanchild") as UITableViewCell
        var rowdatak = self.alldata[indexPath.row] as NSDictionary
        //标题
        var lable = UILabel(frame: CGRectMake(5, 5, width/5*4, 30))
        lable.backgroundColor = bgcolorall
        lable.text = rowdatak["AD_strTitleContent"] as? String
        lable.font = UIFont(name: "Arial-BoldItalicMT", size: 15)
        cell.contentView.addSubview(lable)
        //内容
        var label1 = UITextView(frame: CGRectMake(0, 30, width/5*4, 70))
        label1.text = rowdatak["AD_strBodyContent"] as? String
        label1.font = UIFont(name: "Arial-BoldItalicMT", size: 12)
        label1.backgroundColor = bgcolorall
        label1.editable = false
        cell.contentView.addSubview(label1)
        //报名称
        var label23 = UILabel(frame: CGRectMake(5, 100, width/3, 20))
        label23.text = "人民日报"
        label23.font = UIFont(name: "Arial-BoldItalicMT", size: 12)
        cell.contentView.addSubview(label23)
        //time
        var label2 = UILabel(frame: CGRectMake(width/3*2, 100, width/3, 20))
        var textcontent = rowdatak["AI_dtPublishTime"] as String
        var xm = (textcontent as NSString).substringToIndex(10)
        label2.text = xm
        label2.font = UIFont(name: "Arial-BoldItalicMT", size: 12)
        cell.contentView.addSubview(label2)
        //拨打电话小图标(小图标上要加一个小按钮）
        var image5 = UIImageView(frame:CGRectMake(width-40, 5, 30, 30))
        image5.image = UIImage(named: "phone1.png")
        image5.layer.cornerRadius = 7
        cell.contentView.addSubview(image5)
        var phonebutton = UIButton(frame: CGRectMake(width-40, 5, 30, 30))
        phonebutton.alpha = 0.1
        phonebutton.addTarget(self, action: "pressphoneiocn:", forControlEvents: UIControlEvents.TouchUpInside)
        phonebutton.tag = indexPath.row
        phonebutton.layer.cornerRadius = 7
        cell.contentView.addSubview(phonebutton)
        //添加收藏的图片和按钮
        var image56 = UIImageView(frame:CGRectMake(width-40, 50, 26, 26))
        image56.image = UIImage(named: "shoucang1.png")
        image56.layer.cornerRadius = 7
        cell.contentView.addSubview(image56)
        var phonebutton1 = UIButton(frame: CGRectMake(width-40, 50, 26, 26))
        phonebutton1.alpha = 0.1
        phonebutton1.addTarget(self, action: "pressphoneiocn1:", forControlEvents: UIControlEvents.TouchUpInside)
        phonebutton1.tag = indexPath.row
        phonebutton1.layer.cornerRadius = 7
        cell.contentView.addSubview(phonebutton1)
        //tableView.separatorStyle = .None
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        cell.backgroundColor = bgcolorall
        //cell.layer.cornerRadius = 4
        return cell
    }
    //拨打电话的问题。
    func pressphoneiocn(sender:UIButton){
        if(sender.tag == 0){
            println("0")
            var numb = "18763994432"
            UIApplication.sharedApplication().openURL(NSURL(string: "tel://\(numb)")!)
        }
        if(sender.tag == 1){
            println("1")
            var numb = "18763994432"
            UIApplication.sharedApplication().openURL(NSURL(string: "tel://\(numb)")!)
        }
    }
    //收藏它的问题
    func pressphoneiocn1(sender:UIButton){
        if(sender.tag == 0){
            var alertview = UIAlertView(title: "提醒", message: "收藏成功!", delegate: self, cancelButtonTitle: "好")
            alertview.show()
        }
        else{
            var alertview = UIAlertView(title: "提醒", message: "收藏成功!", delegate: self, cancelButtonTitle: "好")
            alertview.show()
        }
    }
    //mid   tableview delegate3
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 120
    }
    
    //mid   tableview delegate4
//    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
//        cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1)
//        UIView.animateWithDuration(0.4, animations: { () -> Void in
//            cell.layer.transform = CATransform3DMakeScale(1, 1, 1)
//        })
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
