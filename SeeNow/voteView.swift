//
//  voteView.swift
//  SeeNow
//
//  Created by apple on 15/1/13.
//  Copyright (c) 2015年 apple. All rights reserved.
//

import UIKit

class voteView: UIViewController,HttpProtocol {
    let  scrollviewnew = UIScrollView(frame: CGRectMake(0, 35, 1024, 700))
    var ehttp:HttpController = HttpController()
    var leftdata:NSArray = []
    let color4 = UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1)
    let scrollview = UIScrollView(frame: CGRect(x:32,y:4,width:960,height:152))
    let botView = UIView(frame: CGRect(x:0,y:100,width:1024,height:153))
    let topview = UIView(frame: CGRect(x:0,y:0,width:1024,height:35))
    let top1view = UIView(frame: CGRect(x:0,y:0,width:1024,height:100))
    //288
    let sikuaiView = UIView(frame: CGRect(x:0,y:255,width:1024,height:200))
    override func viewDidLoad() {
        super.viewDidLoad()
        var url = "http://qlgg.net:8888/PhoneAPI/PhoneAPI.asmx/FindTypes?mParams={\"CT_nParentID\":-1}"
        url = url.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        ehttp.delegate  = self
        ehttp.onSearch(url)
        //
        self.view.backgroundColor = UIColor.whiteColor()
        self.scrollviewnew.addSubview(botView)
        topviewSetting()
        botviewSetting()
        topview1Setting()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func didReceiveResult(result:NSDictionary){
        if(result.allKeys[0] as String != "CyList"){
            if (result["result"] != nil){
                self.leftdata = result["result"] as NSArray
            }
        }
       botviewSetting()
    }
    //顶部VIEW的各种设置
    func topviewSetting(){
        self.topview.backgroundColor = UIColor.redColor()
        let label = UILabel(frame: CGRectMake(100, 6, 500, 20))
        label.text = "XXXXXXXXXX"
        label.textColor = UIColor.blackColor()
        self.topview.addSubview(label)
        self.view.addSubview(topview)
        //scrollview
        self.view.addSubview(scrollviewnew)
    }
    //中部的一个view图片（霜11）
    func topview1Setting(){
        self.top1view.backgroundColor = UIColor.redColor()
        let label = UILabel(frame: CGRectMake(100, 6, 500, 20))
        label.text = "shuang11"
        label.textColor = UIColor.yellowColor()
        self.top1view.addSubview(label)
        self.scrollviewnew.addSubview(top1view)
        sikuaiViewSetting()
    }
    //底部view的各种设置
    func botviewSetting(){
        scrollview.backgroundColor = self.color4
        scrollview.layer.cornerRadius = 10
        scrollview.layer.masksToBounds = true
        scrollview.showsHorizontalScrollIndicator = false
        scrollview.pagingEnabled = true
        scrollview.alpha = 1
        var count = leftdata.count
        var width = 140
        var view3:UIView
        //给TU图片赋值
        for(var k = 0;k<count;k++){
            var rowdata = leftdata[k] as NSDictionary
            var m = 20
            if(k == 0 ){
                m = 0
            }else{
                m = 20
            }
            var imageview5 = UILabel(frame: CGRect(x:0,y:0,width:140,height:130))
            imageview5.layer.cornerRadius = 10
            imageview5.layer.masksToBounds = true
            //在每个图片上添加一个按钮，为了记录是哪个图片被点击
            var butm = UIButton(frame: CGRect(x:0,y:0,width:140,height:130))
            butm.tag = k
            butm.alpha = 0.1
            butm.backgroundColor = UIColor.blackColor()
            butm.layer.cornerRadius = 10
            
            butm.addTarget(self, action: "pressmeaction:", forControlEvents: UIControlEvents.TouchUpInside)
            //显示姓名的label
            var xmlabel = UILabel(frame: CGRect(x:0,y:131,width:140,height:15))
            xmlabel.text = rowdata["CT_strDescription"] as? String
            xmlabel.backgroundColor = UIColor(red: 97/255, green: 181/255, blue: 248/255, alpha: 1)
            xmlabel.textAlignment = NSTextAlignment.Center
            xmlabel.alpha = 0.8
            xmlabel.layer.cornerRadius = 10
            xmlabel.layer.masksToBounds = true
            xmlabel.font = UIFont(name: "Arial-BoldItalicMT", size: 17)
            view3 = UIView(frame: CGRect(x:width*k+m*k,y:0,width:width,height:100))
            view3.layer.cornerRadius = 10
            view3.backgroundColor = UIColor.clearColor()
            view3.addSubview(imageview5)
            view3.addSubview(butm)
            view3.addSubview(xmlabel)
            self.scrollview.addSubview(view3)
            
            imageview5.text = (String)(k+1)
            imageview5.textAlignment = NSTextAlignment.Center
            imageview5.font = UIFont(name: "Arial-BoldItalicMT", size: 45)
        }
        //添加内容
        scrollview.contentSize = CGSize(width: 160*count, height: 133)
        scrollview.scrollEnabled = true
        self.botView.addSubview(scrollview)
    }
    
    //中间四块信息
    func sikuaiViewSetting(){
        var view1 = UIView(frame: CGRectMake(1, 0, 510, 98))
        view1.backgroundColor = UIColor.blackColor()
        sikuaiView.addSubview(view1)
        var view2 = UIView(frame: CGRectMake(513, 0, 510, 98))
        view2.backgroundColor = UIColor.blueColor()
        sikuaiView.addSubview(view2)
        var view3 = UIView(frame: CGRectMake(1, 101, 510, 98))
        view3.backgroundColor = UIColor.redColor()
        sikuaiView.addSubview(view3)
        var view4 = UIView(frame: CGRectMake(513, 101, 510, 98))
        view4.backgroundColor = UIColor.yellowColor()
        sikuaiView.addSubview(view4)
        self.scrollviewnew.addSubview(sikuaiView)
    }
    
    //图片上按钮点击事件（需要执行动画)
    func pressmeaction(sender:UIButton){
//        var tag = sender.tag
//        println(tag)
//        flag = tag
//        addinfomidFunc()
//        //给添加上动画效果
//        self.midsmallview.frame = CGRect(x:512,y:615,width:0,height:0)
//        UIView.animateWithDuration(2, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
//            self.midsmallview.frame = self.framemid
//            }, completion: nil)
        println("...");
    }

}
