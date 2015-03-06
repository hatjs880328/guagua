//
//  allInfopush.swift
//  SeeNow
//
//  Created by apple on 15/1/23.
//  Copyright (c) 2015年 apple. All rights reserved.
//

import UIKit
import Alamofire
var k = 0

class allInfopush: UIViewController,UITableViewDataSource,UITableViewDelegate {
    //全局变量开始
    var flag = 0
    var flag2 = 1
    var width:CGFloat = 0.0
    var height:CGFloat = 0.0
    var dataArray:NSArray = []
    var alldataArray:NSArray = []
    var countall = 0
    let topBar = UIView(frame: CGRectZero)
    let midTableview = UITableView(frame: CGRectZero)
    let topbarView = UIView(frame: CGRectMake(0, 0, 0, 0))
        let barview1 = UIView(frame: CGRectMake(0, 0, 0, 0))
        let barview2 = UIView(frame: CGRectMake(0, 0, 0, 0))
        let barview3 = UIView(frame: CGRectMake(0, 0, 0, 0))
        let barview4 = UIView(frame: CGRectMake(0, 0, 0, 0))
    let tianqiViewdid = UIView(frame: CGRectMake(-100, -100, 100, 100))
    //var button  = UIButton(frame: CGRectZero)
    var buttonlist = [UIButton]()
    var uifont1 = UIFont(name: "Arial-BoldItalicMT", size: 14)
    var colorall = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
    var bgcolorall = UIColor(red: 85/255, green: 169/255, blue: 254/255, alpha: 1)
    var whitecolor = UIColor.whiteColor()
    //全局变量结束
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var hud:MBProgressHUD = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        hud.labelText = "正在加载";
        hud.dimBackground = true;
        
        self.view.backgroundColor = UIColor.whiteColor()
        self.midTableview.delegate = self
        self.midTableview.dataSource = self
        self.midTableview.backgroundColor = colorall
        loaddata()
        settingNsuser()
        setupRefresh()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(animated: Bool) {
        width = self.view.bounds.width
        height = self.view.bounds.height
        //
        topviewSetting()
        //
        midtableviewSetting()
        //
        botViewbar()
        //
        refreshSetting()
        //加载完毕 隐藏这个图层
        MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
    }
    
    //数据加载方法
    func loaddata(){
        var url = "http://qlgg.net:8888/PhoneAPI/PhoneAPI.asmx/FindTypes?mParams={\"CT_nParentID\":0}"
        url = url.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        let NSUrl:NSURL = NSURL(string: url)!
        let request:NSURLRequest = NSURLRequest(URL: NSUrl)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response,data,error)->Void in
            if(data != nil){
            var result = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
            if result["result"] != nil{
                self.dataArray = result["result"] as NSArray
                self.alldataArray = self.alldataArray.arrayByAddingObjectsFromArray(self.dataArray)
                self.countall = self.alldataArray.count
                self.midTableview.reloadData()
            }
            }
        })
    }
    
    //加载数据的刷新的VIEW
    func refreshSetting(){
        self.view.addSubview(tianqiViewdid)
        self.tianqiViewdid.backgroundColor = UIColor.whiteColor()
        var imageview = UIImageView(frame: CGRectMake(-0, 0, width, 30))
        imageview.image = UIImage(named: "rocket.png")
        tianqiViewdid.addSubview(imageview)
    }
    
    //顶部view的添加
    func topviewSetting(){
        var frame = CGRectMake(0, 0, width, 50)
        self.topBar.frame = frame
        self.topBar.backgroundColor = colorall
        self.view.addSubview(topBar)
        var title = UILabel(frame: CGRectMake(0, 0, width, 20))
        title.textAlignment = NSTextAlignment.Center
        title.text = ""
        self.topBar.addSubview(title)
        
        var view = UIScrollView(frame: CGRectMake(0, 20, width, 30))
        view.contentSize = CGSize(width: width/3*10, height: 30)
        self.topBar.addSubview(view)
        for var i:CGFloat = 0 ;i < 10;i++ {
            var button  = UIButton(frame: CGRectMake(width/3*i, 0, width/3, 30))
            button.tag = Int(i)
            button.backgroundColor = UIColor.clearColor()
            button.setTitle("第\(Int(i+1))个", forState: UIControlState.Normal)
            button.addTarget(self, action: "presseach:", forControlEvents: UIControlEvents.TouchUpInside)
            self.buttonlist.append(button)
            view.addSubview(button)
        }
        
    }
    
    //导航中按钮的点击事件
    func presseach(sender:UIButton){
        for var i = 0;i<10;i++ {
            if(sender.tag == i){
                sender.backgroundColor = UIColor.whiteColor()
            }
        }
        var tag = sender.tag
        var count = buttonlist.count
        println(count)
        for var m = 0;m<count;m++ {
            var a = buttonlist[m] as UIButton
            if(m != tag){
            a.backgroundColor = colorall
            a.setTitleColor(UIColor.redColor(), forState: UIControlState.Highlighted)
            }
        }
    }
    
    //中部的tableview
    func midtableviewSetting(){
        var frame = CGRectMake(0, 50, width, height-100)
        self.midTableview.frame = frame
        self.view.addSubview(midTableview)
        
    }
    
    // tableview delegate 1
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return alldataArray.count;
    }
    
    // tableview delegate 2
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        println(indexPath.row)
        //这里下上啦加载数据的逻辑
        if(indexPath.row == countall-1){
            loaddata()
        }
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "guagua1") as UITableViewCell
        let rowdata = alldataArray[indexPath.row] as NSDictionary
        var name = UILabel(frame: CGRectMake(width/3*2, 10, width/3, 30))
        name.text = "$100.00"
        name.textAlignment = NSTextAlignment.Center
        cell.contentView.addSubview(name)
        var sp = UILabel(frame: CGRectMake(width/3, 10, width/3, 30))
        sp.text = "商品\(indexPath.row+1)"
        sp.textAlignment = NSTextAlignment.Right
        cell.contentView.addSubview(sp)
        var image = UIImageView(frame: CGRectMake(3, 3, width/3, 59))
        image.image = UIImage(named: "jingpinshangpin-1.png")
        image.layer.cornerRadius = 10
        image.layer.masksToBounds = true
        cell.contentView.addSubview(image)
        //不要边框和点击背景颜色
        //tableView.separatorStyle = .None
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        cell.backgroundColor = bgcolorall
        //cell.layer.cornerRadius = 4
        return cell
    }
    
    //tableview delegate 3 
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println(indexPath.row)
        var alert = UIAlertView(title: "警示", message: "商品未上架", delegate: self, cancelButtonTitle: "好")
        alert.show()
    }
    
    //tableview delegate 4
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 65
    }
    
    //tableview delegate 5 (scrollviewdidscroll)
//    func scrollViewDidScroll(scrollView: UIScrollView) {
//        println(self.midTableview.contentOffset.y)
//        //初始
//        if(flag == 0){
//            var offset = scrollView.contentOffset;
//            //上
//            if(offset.y == 0.0){
//                flag = -1
//            }else if(offset.y > 0.0){
//                flag = 1
//                //在这里写消退的代码
//                //tianqiDel()
//            }
//        }else if(flag == 1)
//        {
//            var offset = scrollView.contentOffset;
//            //上
//            if(offset.y == 0.0){
//                flag = 0
//            }
//            //下
//            if(offset.y != 0.0 ){
//                flag = 1
//            }
//        }else{
//            var offset = scrollView.contentOffset;
//            if(offset.y > 0.0){
//                flag = 0
//                println("xiaotui")
//            }
//        }
//        var offset = scrollView.contentOffset;
//        if(flag == -1&&offset.y == 0.0){
//            //这里写需要展示的天气情况信息
//            tianqiSet()
//        }
//    }
    
    
    //下拉刷新事件
    func tianqiSet(){
        self.tianqiViewdid.alpha = 1
        var frame = CGRectMake(0, 50, width, 30)
        self.tianqiViewdid.frame = frame
        var frame2 = CGRectMake(1, 80, width, height-130)
        self.midTableview.frame = frame2
        var frame4 = CGRectMake(width, 50, width, 30)
//        UIView.animateWithDuration(2, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
//            
//            println(".....")
//        }, completion: nil)
        var framescroll = CGRectMake(0, 50, width, height-100)
        UIView.animateWithDuration(2, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.tianqiViewdid.frame = frame4
            self.tianqiViewdid.alpha = 0
            self.midTableview.frame = framescroll
            }, completion: nil)
        midTableview.reloadData()
        
    }
    
    
    //底部导航bar  view
    func botViewbar(){
        var framek = CGRectMake(0, height-50, width, 50)
        self.topbarView.frame = framek
        self.topbarView.backgroundColor = UIColor.purpleColor()
        self.view.addSubview(topbarView)
        
        var frame1 = CGRectMake(0, 0, width/4, 50)
        var frame2 = CGRectMake(width/4, 0, width/4, 50)
        var frame3 = CGRectMake(width/2, 0, width/4, 50)
        var frame4 = CGRectMake(width/4*3, 0, width/4, 50)
        
        barview1.frame = frame1
        barview1.backgroundColor = colorall
        barview2.frame = frame2
        barview2.backgroundColor = colorall
        barview3.frame = frame3
        barview3.backgroundColor = colorall
        barview4.frame = frame4
        barview4.backgroundColor = colorall
        
        self.topbarView.addSubview(barview1)
        self.topbarView.addSubview(barview2)
        self.topbarView.addSubview(barview3)
        self.topbarView.addSubview(barview4)
        
        var botimg1 = UIImageView(frame: CGRectMake(30, 5, width/4-60, 25))
        botimg1.image = UIImage(named: "sy.png")
        barview1.addSubview(botimg1)
        var botlabel1 = UILabel(frame: CGRectMake(0, 30, width/4, 19))
        botlabel1.text = "首页"
        botlabel1.font = uifont1
        botlabel1.textAlignment = NSTextAlignment.Center
        barview1.addSubview(botlabel1)
        var button1 = UIButton(frame: CGRectMake(0, 0, width/4, 50))
        button1.addTarget(self, action: "but1press:", forControlEvents: UIControlEvents.TouchUpInside)
        self.barview1.addSubview(button1)
        
        
        var botimg12 = UIImageView(frame: CGRectMake(30, 5, width/4-60, 25))
        botimg12.image = UIImage(named: "fl.png")
        barview2.addSubview(botimg12)
        var botlabel12 = UILabel(frame: CGRectMake(0, 30, width/4, 19))
        botlabel12.text = "栏目分类"
        botlabel12.font = uifont1
        botlabel12.textAlignment = NSTextAlignment.Center
        barview2.addSubview(botlabel12)
        var button2 = UIButton(frame: CGRectMake(0, 0, width/4, 50))
        button2.addTarget(self, action: "but2press:", forControlEvents: UIControlEvents.TouchUpInside)
        self.barview2.addSubview(button2)
        
        var botimg13 = UIImageView(frame: CGRectMake(30, 5, width/4-60, 25))
        botimg13.image = UIImage(named: "qt.png")
        barview3.addSubview(botimg13)
        var botlabel13 = UILabel(frame: CGRectMake(0, 30, width/4, 19))
        botlabel13.text = "分类商城"
        botlabel13.font = uifont1
        botlabel13.textAlignment = NSTextAlignment.Center
        barview3.addSubview(botlabel13)
        var button3 = UIButton(frame: CGRectMake(0, 0, width/4, 50))
        button3.addTarget(self, action: "but3press:", forControlEvents: UIControlEvents.TouchUpInside)
        self.barview3.addSubview(button3)
        
        var botimg134 = UIImageView(frame: CGRectMake(30, 5, width/4-60, 25))
        botimg134.image = UIImage(named: "yhzx.png")
        barview4.addSubview(botimg134)
        var botlabel134 = UILabel(frame: CGRectMake(0, 30, width/4, 19))
        botlabel134.text = "用户中心"
        botlabel134.font = uifont1
        botlabel134.textAlignment = NSTextAlignment.Center
        barview4.addSubview(botlabel134)
        var button34 = UIButton(frame: CGRectMake(0, 0, width/4, 50))
        button34.addTarget(self, action: "but4press:", forControlEvents: UIControlEvents.TouchUpInside)
        self.barview4.addSubview(button34)
        
    }
    
    //导航按钮事件 a
    func but1press(sender:UIButton){
        var con = ggview()
        picchange = 0
        self.presentViewController(con, animated: false) { () -> Void in
            println("Home")
        }
    }
    //导航按钮事件 b
    func but2press(sender:UIButton){
        var contro = adlistView()
        self.presentViewController(contro, animated: false) { () -> Void in
            
        }
    }
    //导航按钮事件 c
    func but3press(sender:UIButton){
        var contro = allInfopush()
        self.presentViewController(contro, animated: false) { () -> Void in
            println(".")
            //MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
        }
    }
    
    //导航按钮事件 d
    func but4press(sender:UIButton){
        var contro = userCenter()
        picchange = 1
        self.presentViewController(contro, animated: false) { () -> Void in
        }
    }
    
    //nsuserdefault setting
    func settingNsuser(){
        var s = NSUserDefaults.standardUserDefaults()
        s.setObject(77477, forKey: "myinterger")
    }
    
    
    
    //添加头刷新
    func setupRefresh(){
        self.midTableview.addHeaderWithCallback({
            let delayInSeconds:Int64 =  1000000000  * 2
            var popTime:dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW,delayInSeconds)
            dispatch_after(popTime, dispatch_get_main_queue(), {
                println("...top....")
                self.midTableview.headerEndRefreshing()
            })
        })
        //底部刷新不在这里写了
//        self.midTableview.addFooterWithCallback({
//            let delayInSeconds:Int64 = 1000000000 * 2
//            var popTime:dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW,delayInSeconds)
//            dispatch_after(popTime, dispatch_get_main_queue(), {
//                
//                println("....bot....")
//                self.midTableview.footerEndRefreshing()
//            })
//            
//        })
        
    }

}
