//
//  pushAddinfo.swift
//  SeeNow
//
//  Created by apple on 15/1/22.
//  Copyright (c) 2015年 apple. All rights reserved.
//

import UIKit

class pushAddinfo: UIViewController,UIScrollViewDelegate {

    //全局变量在此——————————
    var allhegiht:CGFloat = 0
    var alldata:NSArray = []
    var countall = 0
    var flag = 0
    var flag2 = 1
    var width:CGFloat = 0
    var height:CGFloat = 0
    var leftdata:NSArray = []
    let searchView:UIView = UIView(frame: CGRectMake(0, 0, 0, 0))
    let scrollView:UIScrollView = UIScrollView(frame: CGRectMake(0, 0, 0, 0))
    let picview = UIView(frame: CGRectMake(0, 0, 0, 0))
    let picview1 = UIView(frame: CGRectMake(0, 0, 0, 0))
    let picview2 = UIView(frame: CGRectMake(0, 0, 0, 0))
    let sitiaoView = UIView(frame: CGRectMake(0, 0, 0, 0))
    let smallview1 = UIView(frame: CGRectMake(0, 0, 0, 0))
    let smallview2 = UIView(frame: CGRectMake(0, 0, 0, 0))
    let smallview3 = UIView(frame: CGRectMake(0, 0, 0, 0))
    let smallview4 = UIView(frame: CGRectMake(0, 0, 0, 0))
    let daohangView = UIView(frame: CGRectMake(0, 0, 0, 0))
    let daohangscroll = UIScrollView(frame: CGRectMake(0, 0, 0, 0))
    let jingpingView = UIView(frame: CGRectMake(0, 0, 0, 0))
    let jingpindaohangview = UIView(frame: CGRectMake(0, 0, 0, 0))
    let jingpinletview = UIView(frame: CGRectMake(0, 0, 0, 0))
    let jingpinrighttop = UIView(frame: CGRectMake(0, 0, 0, 0))
    let jingpinrightbotleft = UIView(frame: CGRectMake(0, 0, 0, 0))
    let jingpinrightbotright = UIView(frame: CGRectMake(0, 0, 0, 0))
    let jhsView = UIView(frame: CGRectMake(0, 0, 0, 0))
    let tianqiViewdid = UIView(frame: CGRectMake(-100, -100, 100, 100))
    let topbarView = UIView(frame: CGRectMake(0, 0, 0, 0))
    let barview1 = UIView(frame: CGRectMake(0, 0, 0, 0))
    let barview2 = UIView(frame: CGRectMake(0, 0, 0, 0))
    let barview3 = UIView(frame: CGRectMake(0, 0, 0, 0))
    let barview4 = UIView(frame: CGRectMake(0, 0, 0, 0))
    //全局变量结束——————————
    
    override func viewDidLoad() {
        super.viewDidLoad()
        width = self.view.bounds.width
        height = self.view.bounds.height
        scrollView.delegate = self
        self.view.addSubview(tianqiViewdid)
        loaddata()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //func  jia加载数据
    func loaddata(){
        var url = "http://qlgg.net:8888/PhoneAPI/PhoneAPI.asmx/FindTypes?mParams={\"CT_nParentID\":0}"
        url = url.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        let NSUrl:NSURL = NSURL(string: url)!
        let request:NSURLRequest = NSURLRequest(URL: NSUrl)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response,data,error)->Void in
            var result = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
            if result["result"] != nil{
                self.leftdata = result["result"] as NSArray
                println(self.leftdata.count)
                self.alldata = self.alldata.arrayByAddingObjectsFromArray(self.leftdata)
                self.countall = self.alldata.count
                println(self.countall)
            }
        })
    }
    
    //这里加载信息
    override func viewDidAppear(animated: Bool) {
        searchViewSetting()
        scrollViewSetting()
        botViewbar()
    }
    
    //searchVIew的设置方法
    func searchViewSetting() {
        var framesearch = CGRectMake(0, 0, width, 25)
        self.searchView.frame = framesearch
        self.searchView.backgroundColor = UIColor.redColor()
        self.view.addSubview(searchView)
    }
    //scrollview设置方法
    func scrollViewSetting() {
        var framescroll = CGRectMake(0, 25, width, height-75)
        self.scrollView.frame = framescroll
        self.scrollView.backgroundColor = UIColor.grayColor()
        self.view.addSubview(scrollView)
        //添加新的VIEW方法
        picviewSetting()
        self.scrollView.contentSize = CGSize(width: width, height: 1000)
        self.allhegiht = scrollView.contentSize.height
        self.scrollView.scrollEnabled = true
        
    }
    //添加新的VIEW方法
    func picviewSetting(){
        var framescroll = CGRectMake(0, 0, width, 150)
        self.picview.frame = framescroll
        self.picview.backgroundColor = UIColor.blueColor()
        self.scrollView.addSubview(picview)
        
    }

    //SCROLLVIEW到顶部的事件
    func scrollViewDidScroll(scrollView: UIScrollView){
        //初始
        if(flag == 0){
            var offset = scrollView.contentOffset;
            //上
            if(offset.y == 0.0){
                flag = -1
            }else if(offset.y > 0.0){
                flag = 1
                //在这里写消退的代码
                tianqiDel()
            }
        }else if(flag == 1)
        {
            var offset = scrollView.contentOffset;
            //上
            if(offset.y == 0.0){
                flag = 0
            }
            //下
            if(offset.y != 0.0 ){
                flag = 1
            }
        }else{
            var offset = scrollView.contentOffset;
            if(offset.y > 0.0){
                flag = 0
                println("xiaotui")
            }
        }
        var offset = scrollView.contentOffset;
        if(flag == -1&&offset.y == 0.0){
            //这里写需要展示的天气情况信息
            tianqiSet()
        }
        
        //判定加载数据
        println(offset.y)
        println(",,,\(allhegiht)")
        if(offset.y%500 == 0){
            println("jiazai .....")
            loaddata()
            self.scrollView.contentSize.height = allhegiht + 1000
            self.allhegiht = scrollView.contentSize.height
        }
        
    }
    
    //天气VIEW 出现
    func tianqiSet(){
        flag2 = 0
        var frame = CGRectMake(0, 25, width, 250)
        UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.tianqiViewdid.frame = frame
            }, completion: nil)
        var frame2 = CGRectMake(0, 275, width, height-325)
        UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.scrollView.frame = frame2
            }, completion: nil)
        scrollView.contentOffset = CGPoint(x: 0, y: 0)
        println(flag2)
    }
    
    //天气VIEW 消退(有可能在下滑的过程中这个方法执行多次）
    func tianqiDel(){
        println("xiaotui\(flag2)")
        var frame = CGRectMake(0, 0, 0, 0)
        UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.tianqiViewdid.frame = frame
            }, completion: nil)
        var framescroll = CGRectMake(0, 25, width, height-75)
        UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.scrollView.frame = framescroll
            }, completion: nil)
        //消亡的时候防止SCROLLVIEW滚动到下面去。
        if(flag2 == 0) {
            scrollView.contentOffset = CGPoint(x: 0, y: 0)
            flag2 = 1
        }
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
        barview1.backgroundColor = UIColor.yellowColor()
        barview2.frame = frame2
        barview2.backgroundColor = UIColor.blueColor()
        barview3.frame = frame3
        barview3.backgroundColor = UIColor.blackColor()
        barview4.frame = frame4
        barview4.backgroundColor = UIColor.purpleColor()
        
        self.topbarView.addSubview(barview1)
        self.topbarView.addSubview(barview2)
        self.topbarView.addSubview(barview3)
        self.topbarView.addSubview(barview4)
        
        var button1 = UIButton(frame: CGRectMake(0, 0, width/4, 50))
        button1.addTarget(self, action: "but1press:", forControlEvents: UIControlEvents.TouchUpInside)
        button1.setTitle("home", forState: UIControlState.Normal)
        self.barview1.addSubview(button1)
        
        var button2 = UIButton(frame: CGRectMake(0, 0, width/4, 50))
        button2.addTarget(self, action: "but2press:", forControlEvents: UIControlEvents.TouchUpInside)
        button2.setTitle("list", forState: UIControlState.Normal)
        self.barview2.addSubview(button2)
        
    }
    
    //导航按钮事件 a
    func but1press(sender:UIButton){
        println("press1")
    }
    //导航按钮事件 b
    func but2press(sender:UIButton){
        println("press2")
        var contro = adlistView()
        self.presentViewController(contro, animated: true) { () -> Void in
            
        }
    }
    
}
