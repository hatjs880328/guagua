//
//  adlistView.swift
//  SeeNow
//
//  Created by apple on 15/1/22.
//  Copyright (c) 2015年 apple. All rights reserved.
//

import UIKit

var adlistChildparentId:AnyObject?

class adlistView: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    //全局变量开始了
    var leftdata:NSArray = []
    var leftdata2:NSArray = []
    var width:CGFloat = 0.0
    var height:CGFloat = 0.0
    let bigtop = UIView(frame: CGRectMake(0, 0, 0, 0))
    let bigtableview = UITableView(frame: CGRectMake(0, 0, 0, 0))
    let topbarView = UIView(frame: CGRectMake(0, 0, 0, 0))
        let barview1 = UIView(frame: CGRectMake(0, 0, 0, 0))
        let barview2 = UIView(frame: CGRectMake(0, 0, 0, 0))
        let barview3 = UIView(frame: CGRectMake(0, 0, 0, 0))
        let barview4 = UIView(frame: CGRectMake(0, 0, 0, 0))
    let twotableview = UITableView(frame: CGRectMake(0, 0, 0, 0))
    var uifont1 = UIFont(name: "Arial-BoldItalicMT", size: 14)
    var colorall = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
    var bgcolorall = UIColor(red: 85/255, green: 169/255, blue: 254/255, alpha: 1)
    //全局变量结束了
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //加载数据方法
        getData()
    }

    override func viewDidAppear(animated: Bool) {
        bigtableview.delegate = self
        bigtableview.dataSource = self
        twotableview.delegate = self
        twotableview.dataSource = self
        width = self.view.bounds.width
        height = self.view.bounds.height
        //
        topviewSetting()
        //
        midviewSetting()
        //
        botViewbar()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //顶部VIEW
    func topviewSetting(){
        var frame = CGRectMake(0, 0, width, 50)
        self.bigtop.frame = frame
        self.bigtop.backgroundColor = colorall
        self.view.addSubview(bigtop)
        var button = UIButton(frame: CGRectMake(5, 5, 100, 45))
        button.setTitle("map", forState: UIControlState.Normal)
        button.addTarget(self, action: "pressmap:", forControlEvents: UIControlEvents.TouchUpInside)
        self.bigtop.addSubview(button)
        var toplabel = UILabel(frame: CGRectMake(width/2-100, 10, 200, 45))
        toplabel.text = "栏目分类"
        toplabel.textAlignment = NSTextAlignment.Center
        toplabel.font = uifont1
        self.bigtop.addSubview(toplabel)
        
    }
    //map anniu按钮
    func pressmap(sender:UIButton){
        var con = ggmap()
        self.presentViewController(con, animated: true, completion: nil)
    }
    
    //中间tableview
    func midviewSetting(){
        bigtableview.frame = CGRectMake(0, 50, width, height-100)
        self.view.addSubview(bigtableview)
        bigtableview.backgroundColor = colorall
        bigtableview.tag = 1
        //隐藏的tableview
        twotableview.frame = CGRectMake(width, 0, width/2, height/5*4)
        twotableview.backgroundColor = colorall
        twotableview.layer.cornerRadius = 10
        self.view.addSubview(twotableview)
        twotableview.tag = 2
        
        //向左滑动是为了退回到上一步
        var tag = UISwipeGestureRecognizer(target: self, action: "webviewgoback:")
        tag.direction = UISwipeGestureRecognizerDirection.Right
        twotableview.addGestureRecognizer(tag)
    }
    
    //隐藏的TABLE如果需要隐藏，只需要向左滑动
    func webviewgoback(sender:UISwipeGestureRecognizer){
        //println("left")
        var frame = CGRectMake(width, 0, 0, 0)
        UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.twotableview.frame = frame
            self.twotableview.alpha = 0
            }, completion: nil)
//        self.twotableview.alpha = 1
    }
    
    //tableview delegate 1
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if(tableView.tag == 1){
            var count = self.leftdata.count
            return count
        }else{
            var count = self.leftdata2.count
            return count
        }
    }
    
    //tableview delegate 2
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        if(tableView.tag == 1){
            var rowdatak = self.leftdata[indexPath.row] as NSDictionary
            let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "shancell1") as UITableViewCell
            var lable = UILabel(frame: CGRectMake(15, 5, width/3, 30))
            lable.backgroundColor = UIColor.clearColor()
            lable.text = rowdatak["CT_strDescription"] as? String
            lable.font = UIFont(name: "Arial-BoldItalicMT", size: 15)
            cell.contentView.addSubview(lable)
            let image = UIImageView(frame: CGRectMake(width/3*2, 5, 20, 20))
            image.image = UIImage(named: "ocrBack.png")
            cell.contentView.addSubview(image)
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            //tableView.separatorStyle = .None
            cell.backgroundColor = bgcolorall
            //cell.layer.cornerRadius = 4
            cell.alpha = 0.6
            return cell
        }else if(tableView.tag == 2){
            var rowdatak = self.leftdata2[indexPath.row] as NSDictionary
            tableView.separatorStyle = .None
            let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "shancell2") as UITableViewCell
            var lable = UILabel(frame: CGRectMake(15, 5, width/3, 30))
            lable.backgroundColor = UIColor.clearColor()
            lable.text = rowdatak["CT_strDescription"] as? String
            lable.textAlignment = NSTextAlignment.Center
            lable.font = UIFont(name: "Arial-BoldItalicMT", size: 13)
            cell.contentView.addSubview(lable)
            cell.selectionStyle = UITableViewCellSelectionStyle.Blue
            cell.backgroundColor = bgcolorall
            cell.layer.cornerRadius = 4
            return cell
        }else{
            let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "shancell220") as UITableViewCell
            return cell
        }
    }
    
    //tableview delegata 3
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if(tableView.tag == 1){
            return 45
        }else{
            return 45
        }
    }
    
    //tableview delegata 4
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if(tableView.tag == 1){
            //点击滑出隐藏的TABLE并且给他赋值
            var frame = CGRectMake(width/2, 60, width/2, height-120)
            UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                self.twotableview.frame = frame
                self.twotableview.alpha = 1
                }, completion: nil)
            var datarow = leftdata[indexPath.row] as NSDictionary
            var nowId: AnyObject = datarow["CT_nCategoryID"]!
            var url = "http://qlgg.net:8888/PhoneAPI/PhoneAPI.asmx/FindTypes?mParams={\"CT_nParentID\":\(nowId)}"
            url = url.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
            let NSUrl:NSURL = NSURL(string: url)!
            let request:NSURLRequest = NSURLRequest(URL: NSUrl)
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response,data,error)->Void in
                if(data != nil){
                var result = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
                if result["result"] != nil{
                    self.leftdata2 = result["result"] as NSArray
                    //重新加载数据
                    self.twotableview.reloadData()
                }
                }
            })
        }else if(tableView.tag == 2){
            //隐藏VIEW的点击事件
            var datarow4 = leftdata2[indexPath.row] as NSDictionary
            adlistChildparentId = datarow4["CT_nCategoryID"]
            var contro = adlistViewChild()
            self.presentViewController(contro, animated: false, completion: nil)
        }
        
    }
    
    //tableview delegata 5(列表展示动画）
//    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
//        if(tableView.tag == 1){
//        cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1)
//        UIView.animateWithDuration(0.4, animations: { () -> Void in
//            cell.layer.transform = CATransform3DMakeScale(1, 1, 1)
//        })
//        }else{
//            cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1)
//            UIView.animateWithDuration(0.4, animations: { () -> Void in
//                cell.layer.transform = CATransform3DMakeScale(1, 1, 1)
//            })
//        }
//    }
    
    //获取数据TABLEVIEWCELL
    func getData(){
        var url = "http://qlgg.net:8888/PhoneAPI/PhoneAPI.asmx/FindTypes?mParams={\"CT_nParentID\":0}"
        url = url.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        let NSUrl:NSURL = NSURL(string: url)!
        let request:NSURLRequest = NSURLRequest(URL: NSUrl)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response,data,error)->Void in
            if(data != nil){
            var result = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
            if result["result"] != nil{
                self.leftdata = result["result"] as NSArray
                //重新加载数据
                self.bigtableview.reloadData()
            }
            }
        })
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
        println("press1")
        picchange = 0
        var con = ggview()
        self.presentViewController(con, animated: false) { () -> Void in
            println("Home")
        }
    }
    //导航按钮事件 b
    func but2press(sender:UIButton){
        println("press2")
    }
    
    //tableview滚动到顶部时候执行的方法
    func scrollViewDidScroll(scrollView: UIScrollView) {
        var y = bigtableview.contentOffset.y
        if(y == 0){
            println("....top now....")
        }
    }
    //导航按钮事件 c
    func but3press(sender:UIButton){
        var contro = allInfopush()
        self.presentViewController(contro, animated: false) { () -> Void in
            
        }
    }
    
    //导航按钮事件 d
    func but4press(sender:UIButton){
        var contro = userCenter()
        picchange = 1
        self.presentViewController(contro, animated: false) { () -> Void in
        }
    }

}
