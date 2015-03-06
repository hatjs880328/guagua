//
//  ggview.swift
//  SeeNow
//
//  Created by apple on 15/1/21.
//  Copyright (c) 2015年 apple. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


var firstLogin = 0
var picchange = 0
class ggview: UIViewController,UIScrollViewDelegate,UITextFieldDelegate,UIWebViewDelegate {

    //全局变量在此——————————
    var jpspflag = 0
    var flag = 0
    var flag2 = 1
    var width:CGFloat = 0
    var height:CGFloat = 0
    var leftdata:NSArray = []
    let searchView:UIView = UIView(frame: CGRectMake(0, 0, 0, 0))
        var serchlabel = UITextField(frame: CGRectZero)
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
                let leftlabel = UILabel(frame:CGRectZero)
                let leftimageview = UIImageView(frame:CGRectZero)
            let jingpinrighttop = UIView(frame: CGRectMake(0, 0, 0, 0))
                let leftlabel1 = UILabel(frame: CGRectZero)
                let leftimageview1 = UIImageView(frame: CGRectZero)
            let jingpinrightbotleft = UIView(frame: CGRectMake(0, 0, 0, 0))
                let leftlabel12 = UILabel(frame: CGRectZero)
                let leftimageview12 = UIImageView(frame:CGRectZero)
            let jingpinrightbotright = UIView(frame: CGRectMake(0, 0, 0, 0))
                let leftlabel123 = UILabel(frame: CGRectZero)
                let leftimageview13 = UIImageView(frame: CGRectZero)
        let jhsView = UIView(frame: CGRectMake(0, 0, 0, 0))
    let tianqiViewdid = UIView(frame: CGRectMake(-100, -100, 100, 100))
        let tianqi1 = UILabel(frame: CGRectMake(0, 0, 0, 0))
        let tianqi2 = UILabel(frame: CGRectZero)
        let tianqi3 = UILabel(frame: CGRectZero)
        let tianqi4 = UILabel(frame: CGRectZero)
    let topbarView = UIView(frame: CGRectMake(0, 0, 0, 0))
        let barview1 = UIView(frame: CGRectMake(0, 0, 0, 0))
        let barview2 = UIView(frame: CGRectMake(0, 0, 0, 0))
        let barview3 = UIView(frame: CGRectMake(0, 0, 0, 0))
        let barview4 = UIView(frame: CGRectMake(0, 0, 0, 0))
    var weatherdata:NSDictionary?
    var colorall = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
    var whitecolor = UIColor.whiteColor()
    var uifont1 = UIFont(name: "Arial-BoldItalicMT", size: 14)
    var wbwebview = UIWebView(frame: CGRectZero)
    //全局变量结束——————————
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        if(firstLogin == 0){
//            var image = UIImageView(frame: CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height))
//            image.image = UIImage(named: "more1.png")
//            self.view.addSubview(image)
//        }
    }
    
    func tianqi(){
        var frame1 = CGRectMake(0, 0, 200, 20)
        tianqi1.frame = frame1
        var frame2 = CGRectMake(0, 20, 200, 20)
        tianqi2.frame = frame2
        var frame3 = CGRectMake(0, 40, 200, 20)
        tianqi3.frame = frame3
        var frame4 = CGRectMake(0, 60, width-100, 20)
        tianqi4.frame = frame4
        
        self.tianqiViewdid.addSubview(tianqi1)
        self.tianqiViewdid.addSubview(tianqi2)
        self.tianqiViewdid.addSubview(tianqi3)
        self.tianqiViewdid.addSubview(tianqi4)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        wbwebview.delegate = self
    }
    
    //这里加载信息
    override func viewDidAppear(animated: Bool) {
//        if(firstLogin == 0 ){
//        sleep(3)
//        }
//        firstLogin = 1
        self.view.backgroundColor = UIColor(red: 87/255, green: 155/255, blue: 163/255, alpha: 0.8)
        width = self.view.bounds.width
        height = self.view.bounds.height
        scrollView.delegate = self
        serchlabel.delegate = self
        var imagetianqidid = UIImageView(frame: CGRectMake(-0, 0, width, 150))
        imagetianqidid.image = UIImage(named: "tianqi-1.png")
        tianqiViewdid.addSubview(imagetianqidid)
        self.view.addSubview(tianqiViewdid)
        //图片循环线程
        thread2()
        //getWeatherData()
        tianqi()
        getdefault()
        
        searchViewSetting()
        scrollViewSetting()
        botViewbar()
        zLastview()
    }
    
    //searchVIew的设置方法
    func searchViewSetting() {
        var framesearch = CGRectMake(0, 0, width, 50)
        self.searchView.frame = framesearch
        self.searchView.backgroundColor = colorall
        self.view.addSubview(searchView)
        serchlabel = UITextField(frame: CGRectMake(width/2-100, 25, 200, 20))
        serchlabel.layer.cornerRadius = 10
        serchlabel.layer.masksToBounds = true
        serchlabel.textAlignment = NSTextAlignment.Center
        serchlabel.text = "请输入要查找的信息"
        serchlabel.font = UIFont(name: "Arial-BoldItalicMT", size: 14)
        serchlabel.backgroundColor = UIColor.whiteColor()
        self.searchView.addSubview(serchlabel)
        serchlabel.delegate = self
        //扫描二维码功能按钮
        let buttonewm = UIButton(frame: CGRectMake(width-30, 25, 20, 20))
        buttonewm.backgroundColor = UIColor(patternImage: UIImage(named: "ewmTop-2.png")!)
        buttonewm.addTarget(self, action: "ewmpress:", forControlEvents: UIControlEvents.TouchUpInside)
        searchView.addSubview(buttonewm)
    }
    
    func ewmpress(sender:UIButton){
        println("3")
        var cont = ggviewEWM()
        self.presentViewController(cont, animated: false, completion: nil)
    }
    
    //scrollview设置方法
    func scrollViewSetting() {
        var framescroll = CGRectMake(0, 50, width, height-100)
        self.scrollView.frame = framescroll
        self.scrollView.backgroundColor = colorall
        self.view.addSubview(scrollView)
        //图片循环VIEW
        picviewSetting()
        //四条信息VIEW
        sitiaoViewSetting()
        //先注掉，外网测试访问数据问题
        daohangViewSetting()
        //精品VIEW
        jingpingSetting()
        //聚划算
        jhsVeiwSetting()
        self.scrollView.contentSize = CGSize(width: width, height: 1330)
        self.scrollView.tag = 999
        self.scrollView.scrollEnabled = true
        
    }
    //scroll   1  滚动图片VIEW 150
    func picviewSetting(){
        var framescroll = CGRectMake(0, 0, width, 150)
        self.picview.frame = framescroll
        self.picview.backgroundColor = UIColor.redColor()
        self.scrollView.addSubview(picview)
        
    }
    //scroll  2  四条view 100
    func sitiaoViewSetting(){
        var farame = CGRectMake(0, 150, width, 100)
        self.sitiaoView.frame = farame
        self.sitiaoView.backgroundColor = UIColor.clearColor()
        self.scrollView.addSubview(sitiaoView)
        
        var frame1 = CGRectMake(0, 0, width/4, 100)
        var frame2 = CGRectMake(width/4, 0, width/4, 100)
        var frame3 = CGRectMake(width/2, 0, width/4, 100)
        var frame4 = CGRectMake(width/4*3, 0, width/4, 100)
        
        self.smallview1.frame = frame1
        smallview1.backgroundColor = whitecolor
        var image1 = UIImage(named: "s-1.png")
        var image1view = UIImageView(frame: CGRectMake(10, 5, width/4-20, width/4-20))
        image1view.image = image1
        image1view.layer.cornerRadius = width/8-10
        image1view.layer.shadowOffset = CGSize(width: 5, height: 5)
        image1view.layer.shadowOpacity = 1
        smallview1.addSubview(image1view)
        var labels12 = UILabel(frame: CGRectMake(0, 75, width/4, 22))
        labels12.textAlignment = NSTextAlignment.Center
        labels12.text = "招聘信息"
        labels12.font = UIFont(name: "Arial-BoldItalicMT", size: 13)
        image1view.layer.masksToBounds = true
        smallview1.addSubview(labels12)
        
        self.smallview2.frame = frame2
        smallview2.backgroundColor = whitecolor
        var image12 = UIImage(named: "s-2.png")
        var image1view2 = UIImageView(frame: CGRectMake(10, 5, width/4-20, width/4-20))
        image1view2.image = image12
        image1view2.layer.shadowOffset = CGSize(width: 5, height: 5)
        image1view2.layer.shadowOpacity = 1
        image1view2.layer.cornerRadius = width/8-10
        image1view2.layer.masksToBounds = true
        smallview2.addSubview(image1view2)
        var labels1 = UILabel(frame: CGRectMake(0, 75, width/4, 22))
        labels1.textAlignment = NSTextAlignment.Center
        labels1.text = "房屋信息"
        labels1.font = UIFont(name: "Arial-BoldItalicMT", size: 13)
        smallview2.addSubview(labels1)
        
        
        self.smallview3.frame = frame3
        smallview3.backgroundColor = whitecolor
        var image13 = UIImage(named: "s-3.png")
        var image1view3 = UIImageView(frame: CGRectMake(10, 5, width/4-20, width/4-20))
        image1view3.image = image13
        image1view3.layer.shadowOffset = CGSize(width: 5, height: 5)
        image1view3.layer.shadowOpacity = 1
        image1view3.layer.cornerRadius = width/8-10
        image1view3.layer.masksToBounds = true
        smallview3.addSubview(image1view3)
        var labels13 = UILabel(frame: CGRectMake(0, 75, width/4, 22))
        labels13.textAlignment = NSTextAlignment.Center
        labels13.text = "转让信息"
        labels13.font = UIFont(name: "Arial-BoldItalicMT", size: 13)
        smallview3.addSubview(labels13)
        
        self.smallview4.frame = frame4
        smallview4.backgroundColor = whitecolor
        var image14 = UIImage(named: "s-4.png")
        var image1view4 = UIImageView(frame: CGRectMake(10, 5, width/4-20, width/4-20))
        image1view4.image = image14
        image1view4.layer.shadowOffset = CGSize(width: 5, height: 5)
        image1view4.layer.shadowOpacity = 1
        image1view4.layer.cornerRadius = width/8-10
        image1view4.layer.masksToBounds = true
        smallview4.addSubview(image1view4)
        var labels14 = UILabel(frame: CGRectMake(0, 75, width/4, 22))
        labels14.textAlignment = NSTextAlignment.Center
        labels14.text = "信贷理财"
        labels14.font = UIFont(name: "Arial-BoldItalicMT", size: 13)
        smallview4.addSubview(labels14)
        
        
        sitiaoView.addSubview(smallview4)
        sitiaoView.addSubview(smallview3)
        sitiaoView.addSubview(smallview2)
        sitiaoView.addSubview(smallview1)
    }
    
    //scroll  3 导航VIEW 160
    func daohangViewSetting(){
        var farame = CGRectMake(0, 260, self.width, 150)
        daohangView.frame = farame
        daohangView.backgroundColor = colorall
        self.scrollView.addSubview(daohangView)
        //导航VIEW下面加滚动VIEW
        var url = "http://qlgg.net:8888/PhoneAPI/PhoneAPI.asmx/FindTypes?mParams={\"CT_nParentID\":0}"
        url = url.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        let NSUrl:NSURL = NSURL(string: url)!
        let request:NSURLRequest = NSURLRequest(URL: NSUrl)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response,data,error)->Void in
            if(data != nil){
            var result = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
            if result["result"] != nil{
                self.leftdata = result["result"] as NSArray
                //nei内部滚动试图的VIEW
                var frame1 = CGRectMake(0, 0, self.width, 150)
                self.daohangscroll.frame = frame1
                self.daohangscroll.tag = 99
                self.daohangscroll.delegate = self
                self.daohangscroll.backgroundColor = UIColor.whiteColor()
                self.daohangscroll.layer.cornerRadius = 2
                self.daohangscroll.layer.masksToBounds = true
                self.daohangscroll.showsHorizontalScrollIndicator = false
                self.daohangscroll.pagingEnabled = true
                self.daohangscroll.alpha = 1
                var count = self.leftdata.count
                var widtheach = 120
                //每个项目高 120 宽120
                var view3:UIView
                //给TU图片赋值
                for(var k = 0;k<count;k++){
                    var rowdata = self.leftdata[k] as NSDictionary
                    var m = 8
                    if(k == 0 ){
                        m = 0
                    }else{
                        m = 8
                    }
                    var imageview5 = UIImageView(frame: CGRect(x:0,y:7,width:100,height:100))
                    imageview5.layer.cornerRadius = 10
                    imageview5.layer.masksToBounds = true
                    imageview5.image = UIImage(named: "scroll-\(k+1).png")
                    //在每个图片上添加一个按钮，为了记录是哪个图片被点击
                    var butm = UIButton(frame: CGRect(x:0,y:7,width:100,height:100))
                    butm.tag = k
                    butm.alpha = 0.1
                    butm.backgroundColor = UIColor.blackColor()
                    butm.layer.cornerRadius = 10
                    butm.addTarget(self, action: "pressmeaction:", forControlEvents: UIControlEvents.TouchUpInside)
                    //显示姓名的label
                    var xmlabel = UILabel(frame: CGRect(x:0,y:116,width:100,height:25))
                    xmlabel.text = rowdata["CT_strDescription"] as? String
                    xmlabel.backgroundColor = self.colorall
                    xmlabel.textAlignment = NSTextAlignment.Center
                    xmlabel.alpha = 1
                    xmlabel.layer.cornerRadius = 5
                    xmlabel.layer.masksToBounds = true
                    xmlabel.font = UIFont(name: "Arial-BoldItalicMT", size: 14)
                    view3 = UIView(frame: CGRect(x:100*k+m*k,y:0,width:100,height:150))
                    view3.layer.cornerRadius = 10
                    view3.backgroundColor = UIColor.clearColor()
                    view3.addSubview(imageview5)
                    view3.addSubview(butm)
                    view3.addSubview(xmlabel)
                    self.daohangscroll.addSubview(view3)
                }
                self.daohangscroll.contentSize = CGSize(width: 108*count, height: 150)
                self.daohangscroll.scrollEnabled = true
                self.daohangView.addSubview(self.daohangscroll)
            }
            }
        })
    }
    //滚动条上单个小方块点击的事件
    func pressmeaction(sender:UIButton){
                var tag = sender.tag
                println(tag)
        println("press2")
        picchange = 1
        var contro = adlistView()
        self.presentViewController(contro, animated: false) { () -> Void in
        }
    }
    //MARK: --精品商品
    //scroll  4 精品VIEW   260
    func jingpingSetting(){
        var frame = CGRectMake(0, 420, width, 250)
        self.jingpingView.frame = frame
        self.jingpingView.backgroundColor = colorall
        self.scrollView.addSubview(jingpingView)
        
        var frame1 = CGRectMake(0, 0, width, 25)
        var frame2 = CGRectMake(0, 25, width/5*2, 225)
        var frame3 = CGRectMake(width/5*2+2, 25, width/5*3-2, 75)
        var frame4 = CGRectMake(width/5*2+2, 100+2, width/5*3/2-2, 150-2)
        var frame5 = CGRectMake(width/5*3/2+width/5*2+2, 100+2, width/5*3/2-2, 150-2)
        
        jingpindaohangview.frame = frame1
        jingpindaohangview.backgroundColor = UIColor.whiteColor()
        var redsmallview = UIView(frame: CGRectMake(0, 0, 15, 25))
        redsmallview.backgroundColor = UIColor.redColor()
        jingpindaohangview.addSubview(redsmallview)
        var jplabel = UILabel(frame: CGRectMake(20, 0, 150, 25))
        jplabel.text = "精品商品"
        jplabel.font = UIFont(name: "Arial-BoldItalicMT", size: 14)
        jingpindaohangview.addSubview(jplabel)
        var jplabel1 = UILabel(frame: CGRectMake(width-50, 0, 50, 25))
        jplabel1.text = "更多>>"
        jplabel1.textColor = UIColor.redColor()
        jplabel1.font = UIFont(name: "Arial-BoldItalicMT", size: 14)
        jingpindaohangview.addSubview(jplabel1)
        //左侧大图
        jingpinletview.frame = frame2
        jingpinletview.backgroundColor = whitecolor
         leftlabel.frame = CGRectMake(10, 0, width/5*2-10, 30)
        leftlabel.text = "LenovoPC"
        leftlabel.font = uifont1
        leftlabel.textColor = UIColor.blackColor()
        jingpinletview.addSubview(leftlabel)
         leftimageview.frame = CGRectMake(0, 100, width/5*2, 100)
        leftimageview.image = UIImage(named: "jingpinshangpin-1.png")
        jingpinletview.addSubview(leftimageview)
        jingpinletview.layer.borderColor = UIColor.grayColor().CGColor
        jingpinletview.layer.borderWidth = CGFloat(1)
        //右侧顶部
        jingpinrighttop.frame = frame3
        jingpinrighttop.backgroundColor = whitecolor
         leftlabel1.frame = CGRectMake(10, 0, 100, 30)
        leftlabel1.text = "香奈儿No.5"
        leftlabel1.font = uifont1
        leftlabel1.textColor = UIColor.blackColor()
        jingpinrighttop.addSubview(leftlabel1)
         leftimageview1.frame = CGRectMake(width/5*2-5, 5, width/5, 60)
        leftimageview1.image = UIImage(named: "jingpinshangpin-2.png")
        jingpinrighttop.addSubview(leftimageview1)
        jingpinrighttop.layer.borderColor = UIColor.grayColor().CGColor
        jingpinrighttop.layer.borderWidth = CGFloat(1)
        //右侧下面左侧
        jingpinrightbotleft.frame = frame4
        jingpinrightbotleft.backgroundColor = colorall
        jingpinrightbotleft.layer.borderColor = UIColor.grayColor().CGColor
        jingpinrightbotleft.layer.borderWidth = CGFloat(1)
         leftlabel12.frame = CGRectMake(10, 5, width/5, 30)
        leftlabel12.text = "阿Adidas"
        leftlabel12.font = uifont1
        leftlabel12.textColor = UIColor.blackColor()
        jingpinrightbotleft.addSubview(leftlabel12)
         leftimageview12.frame = CGRectMake(5, 40, width/5*3/2-10, 80)
        leftimageview12.image = UIImage(named: "jingpinshangpin-4.png")
        jingpinrightbotleft.addSubview(leftimageview12)
        //右面下册右边
        jingpinrightbotright.frame = frame5
        jingpinrightbotright.backgroundColor = colorall
        jingpinrightbotright.layer.borderColor = UIColor.grayColor().CGColor
        jingpinrightbotright.layer.borderWidth = CGFloat(1)
         leftlabel123.frame = CGRectMake(10, 5, width/5, 30)
        leftlabel123.text = "耐克√"
        leftlabel123.font = uifont1
        leftlabel123.textColor = UIColor.blackColor()
        jingpinrightbotright.addSubview(leftlabel123)
         leftimageview13.frame = CGRectMake(5, 40, width/5*3/2-10, 80)
        leftimageview13.image = UIImage(named: "jingpinshangpin-3.png")
        jingpinrightbotright.addSubview(leftimageview13)
        
        self.jingpingView.addSubview(jingpindaohangview)
        self.jingpingView.addSubview(jingpinletview)
        self.jingpingView.addSubview(jingpinrighttop)
        self.jingpingView.addSubview(jingpinrightbotleft)
        self.jingpingView.addSubview(jingpinrightbotright)
        
        //开新的线程加载数据
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            //这里写需要一直执行的代码（2秒扫描一次数据库）
            self.jpspasyAddgoods()
                //返回主线程跳转才可以成功（UI提示也只有在主线程中才会成功）
//            dispatch_async(dispatch_get_main_queue(), {
//                println("...")
//            })
        })
    }
    //scroll 5 jhs   650
    func jhsVeiwSetting(){
        var frame = CGRectMake(0, 680, width, 650)
        self.jhsView.frame = frame
        self.jhsView.backgroundColor = colorall
        self.scrollView.addSubview(jhsView)
        //导航
        var frame1 = CGRectMake(0, 0, width, 25)
        var jhsdaohangview = UIView(frame: CGRectZero)
//        jhsdaohangview.layer.borderColor = UIColor.blackColor().CGColor
//        jhsdaohangview.layer.borderWidth = 1
        jhsdaohangview.frame = frame1
        jhsdaohangview.backgroundColor = UIColor.whiteColor()
        var redsmallview = UIView(frame: CGRectMake(0, 0, 15, 25))
        redsmallview.backgroundColor = UIColor.redColor()
        jhsdaohangview.addSubview(redsmallview)
        var jplabel = UILabel(frame: CGRectMake(20, 0, 150, 25))
        jplabel.text = "划算"
        jplabel.font = UIFont(name: "Arial-BoldItalicMT", size: 14)
        jhsdaohangview.addSubview(jplabel)
        var jplabel1 = UILabel(frame: CGRectMake(width-50, 0, 50, 25))
        jplabel1.text = "更多>>"
        jplabel1.textColor = UIColor.redColor()
        jplabel1.font = UIFont(name: "Arial-BoldItalicMT", size: 14)
        jhsdaohangview.addSubview(jplabel1)
        //循环物品（循环的VIEW 不用SCROLL   TABLEVIEW)
        let Parameters = [
            "mparams":"{}"
        ]
        Alamofire.request(.POST,
            "http://qlgg.net:8888/PhoneAPI/PhoneAPI.asmx/FindBottomRecommendGoods",
            parameters: Parameters)
            .responseString{(request,response,string4,error) in
                if(string4 != ""){
                var nsdata = string4?.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
                var result = NSJSONSerialization.JSONObjectWithData(nsdata!, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
                if(result["result"] != nil){
                var arr = result["result"] as NSArray
//                    println(arr)
                for var i = 0 ; i < 5 ; i++ {
                    var wview1 = UIView(frame: CGRectMake(0, CGFloat(125*i+25), self.width, 120))
                    wview1.layer.borderColor = self.colorall.CGColor
                    wview1.layer.borderWidth = 1
                    wview1.backgroundColor = UIColor.whiteColor()
                    self.jhsView.addSubview(wview1)
                    if(i < arr.count){
                    //单个VIEW的信息
                        var imgurl = (arr[i] as NSDictionary)["GoodsPicUrl"] as String
//                        println(imgurl)
                        var nsd = NSData(contentsOfURL:NSURL(string: imgurl)!)
                        var goodImage  = UIImageView(frame: CGRectMake(2, 15, self.width/4, 80))
                        goodImage.image = UIImage(data: nsd!)
                        
                        var namelabel = UILabel(frame: CGRectMake(self.width/4+4, 5, self.width/3, 30))
                        namelabel.text = (arr[i] as NSDictionary)["GoodsName"] as? String
                        namelabel.font = self.uifont1
                        
                        var namelabel2 = UILabel(frame: CGRectMake(self.width/4+4, 40, self.width/4*3, 30))
                        var flo = ((arr[i] as NSDictionary)["GoodsMarketPrice"]) as Double
                        var flonow = ((arr[i] as NSDictionary)["GoodsPrice"]) as Double
                        var priceString:NSString =  NSString(format: "%.02f元", flo)
                        var priceStringnow:NSString = NSString(format: "%.02f元", flonow)
                        namelabel2.text = "原价：\(priceString) 现价：\(priceStringnow)"
                        namelabel2.font = self.uifont1
                        wview1.addSubview(namelabel)
                        wview1.addSubview(goodImage)
                        wview1.addSubview(namelabel2)
                    }
                    }
                }
                }
                println("...")
            }
        
        //添加
        jhsView.addSubview(jhsdaohangview)
        
    }
    
    //SCROLLVIEW到顶部的事件
    func scrollViewDidScroll(scrollView: UIScrollView){
        //初始
        if(scrollView.tag == 999){
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
        }
        //横线滚动的SCROLLVIEW 滚动到最后一个，自动滚回第一个。
        if(scrollView.tag == 99){
//            println("scroll")
//            println(scrollView.contentSize)
//            println(scrollView.contentOffset.x)
//            if(scrollView.contentOffset.x == 1728){
//                scrollView.contentOffset.x = 0
//                println("to last")
//            }
        }
    }
    
    //天气VIEW 出现
    func tianqiSet(){
        flag2 = 0
        var frame = CGRectMake(0, 50, width, 150)
        UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                        self.tianqiViewdid.frame = frame
                        }, completion: nil)
        var frame2 = CGRectMake(0, 200, width, height-225)
        UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.scrollView.frame = frame2
            }, completion: nil)
        scrollView.contentOffset = CGPoint(x: 0, y: 0)
        println(flag2)
        getWeatherData()
    }
    
    //天气VIEW 消退(有可能在下滑的过程中这个方法执行多次）
    func tianqiDel(){
        println("xiaotui\(flag2)")
        var frame = CGRectMake(0, 0, 0, 0)
        UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.tianqiViewdid.frame = frame
            }, completion: nil)
        var framescroll = CGRectMake(0, 50, width, height-100)
        UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.scrollView.frame = framescroll
            }, completion: nil)
        //消亡的时候防止SCROLLVIEW滚动到下面去。
        if(flag2 == 0) {
            scrollView.contentOffset = CGPoint(x: 0, y: 0)
            flag2 = 1
        }
    }
    //MARK: 天气图片的交替
    //滚动图片的线程
    //界面控制流程————开启异步执行方法（线程打印no字符串）判定是否可以滚动
    func thread2()->Void{
        var frameshow = CGRectMake(0, 0, width, 150)
        var framehidden = CGRectMake(-width, 0, width, 150)
        self.picview1.frame = frameshow
        //self.picview1.backgroundColor = UIColor(patternImage: UIImage(named: "a.png")!)
        var pic1 = UIImageView(frame: CGRectMake(0, 0, width, 150))
        pic1.image = UIImage(named: "gundong-1.png")
        self.picview1.addSubview(pic1)
        
        
        
        self.picview2.frame = framehidden
        //self.picview2.backgroundColor = UIColor(patternImage: UIImage(named: "b.png")!)
        var pic2 = UIImageView(frame: CGRectMake(0, 0, width, 150))
        pic2.image = UIImage(named: "gundong-2.png")
        self.picview2.addSubview(pic2)
        self.picview.addSubview(picview1)
        self.picview.addSubview(picview2)
        //调到别的界面就关闭这个线程了
        if( picchange == 0 ){
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            //这里写需要一直执行的代码（2秒扫描一次数据库）
            for var i = 0 ; i > -1 && picchange == 0 ; i++ {
                sleep(4);
                //返回主线程跳转才可以成功（UI提示也只有在主线程中才会成功）
                dispatch_async(dispatch_get_main_queue(), {
                    println("这里返回主线程，写需要主线程执行的代码")
                    if(i%2 == 0){
                        self.picTogglenow()
                    }else{
                        self.picTogglelater()
                    }
                    })
                }
        })
        }
    }
    
    //图片替换方法 a
    func picTogglenow(){
        var frameshow = CGRectMake(0, 0, width, 150)
        var framehidden = CGRectMake(-width, 0, width, 150)
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.picview1.frame = framehidden
            }, completion: nil)
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.picview2.frame = frameshow
            }, completion: nil)
    }
    //图片替换方法 b
    func picTogglelater(){
        var frameshow = CGRectMake(0, 0, width, 150)
        var framehidden = CGRectMake(-width, 0, width, 150)
        UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.picview2.frame = framehidden
            }, completion: nil)
        UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.picview1.frame = frameshow
            }, completion: nil)
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
    }
    //导航按钮事件 b
    func but2press(sender:UIButton){
        println("press2")
        picchange = 1
        var contro = adlistView()
        self.presentViewController(contro, animated: false) { () -> Void in
            
        }
    }
    //导航按钮事件 c
    func but3press(sender:UIButton){
        var contro = allInfopush()
        picchange = 1
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
    
    
    //天气的获取
    func getWeatherData(){
//        var url = "http://m.weather.com.cn/data/101010100.html"
        var url = "http://wthrcdn.etouch.cn/weather_mini?city=%E6%B5%8E%E5%8D%97"
        var nsurl = NSURL(string: url)
        var request:NSURLRequest = NSURLRequest(URL: nsurl!)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response,data,error)->Void in
            var jsonData = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
            var mmmm = jsonData["data"] as NSDictionary
            var mmmm1 = mmmm["forecast"] as NSArray
            //今天 mmmm["forecast"] as NSArray 存储的是未来一周的天气情况，只去第一天。
            var mmmm11 = mmmm1[0] as NSDictionary
            println(mmmm1[0])
            if(mmmm11["date"] != nil){
                self.weatherdata = mmmm1[0] as? NSDictionary
//                var city: AnyObject? = self.weatherdata?.objectForKey("city")!
//                println(city!)
                self.tianqi1.text = "城市：济南" as String
                var data: AnyObject? = self.weatherdata?.objectForKey("date")!
                println(data!)
                self.tianqi2.text = "日期：\(data!)" as String
                var week: AnyObject? = self.weatherdata?.objectForKey("fengli")!
                println(week!)
                self.tianqi3.text = "风力：\(week!)" as String
                var wendu : AnyObject? = self.weatherdata?.objectForKey("high")!
                var wendul : AnyObject? = self.weatherdata?.objectForKey("low")!
                println(wendu!)
                self.tianqi4.text = "温度：\(wendu!)~\(wendul!)" as String
            }
            
        })
    }
    
    
    //interger
    func getdefault(){
        var m = NSUserDefaults.standardUserDefaults()
        if(m.objectForKey("myinterger") != nil){
        var k = m.objectForKey("myinterger") as Int
        println(k)
        }
    }
    
    //textfield的返回按钮关闭键盘事件(xie写查找的逻辑）
    func textFieldShouldReturn(textField: UITextField) -> Bool{
        println("return")
        textField.resignFirstResponder()
        return true
    }
    
    //最外的一个LAYER添加一个VIEW (小邮箱的图标）
    func zLastview(){
        var view = UIView(frame: CGRectMake(width-100, height-90, 40, 40))
            var postview = UIImageView(frame: CGRectMake(0, 0, 40, 40))
            postview.image = UIImage(named: "smallPost-1.png")
        view.addSubview(postview)
        self.view.addSubview(view)
        //给他添加手势，让他移动
        var getture = UIPanGestureRecognizer(target: self, action: "getturepress:")
        view.addGestureRecognizer(getture)
    }
    //小邮箱拖动的事件
    func getturepress(sender:UIPanGestureRecognizer){
        var point = sender.translationInView(self.view) as CGPoint
        //println(point)
        var xxx = sender.view?.center.x
        var yyy = sender.view?.center.y
        sender.view?.center = CGPointMake( xxx! + point.x, yyy!)
        sender.setTranslation(CGPointZero, inView: self.view)
    }
    
    //MARK: --WEBVIEW DELEGATE
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool{
        if(navigationType == UIWebViewNavigationType.LinkClicked){
            println("linkClicked")
            //新建一个窗口LOADREQUEST 并且返回FALSE
            return false
        }
        else{
            return true
        }
    }
    
    
    //MARK: --精品上品异步加载数据方法（开心的线程加载）
    func jpspasyAddgoods(){
        if(jpspflag == 0){
        var url = "http://qlgg.net:8888/PhoneAPI/PhoneAPI.asmx/FindRecommendGoods?mParams={}"
        url = url.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        let NSUrl:NSURL = NSURL(string: url)!
        let request:NSURLRequest = NSURLRequest(URL: NSUrl)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response,data,error)->Void in
            if(data != nil){
                var result = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
                if result["result"] != nil{
                    //println(result["result"])
                    var array5:NSArray = result["result"] as NSArray
                    //a
                    var arr51 = array5[0] as NSDictionary
                    self.leftlabel.text = arr51["GoodsName"] as? String
                        var imgurl = arr51["GoodsPicUrl"] as String
                        var nsd = NSData(contentsOfURL:NSURL(string: imgurl)!)
                        self.leftimageview.image = UIImage(data: nsd!)
                    //b
                    var arr52 = array5[1] as NSDictionary
                    self.leftlabel1.text = arr52["GoodsName"] as? String
                        var imgurl1 = arr52["GoodsPicUrl"] as String
                        var nsd1 = NSData(contentsOfURL:NSURL(string: imgurl1)!)
                        self.leftimageview1.image = UIImage(data: nsd1!)
                    //c
                    var arr53 = array5[2] as NSDictionary
                    self.leftlabel12.text = arr53["GoodsName"] as? String
                    var imgurl13 = arr53["GoodsPicUrl"] as String
                    var nsd13 = NSData(contentsOfURL:NSURL(string: imgurl13)!)
                    self.leftimageview12.image = UIImage(data: nsd13!)
                    //d
                    var arr54 = array5[3] as NSDictionary
                    self.leftlabel123.text = arr54["GoodsName"] as? String
                    var imgurl134 = arr54["GoodsPicUrl"] as String
                    var nsd134 = NSData(contentsOfURL:NSURL(string: imgurl134)!)
                    self.leftimageview13.image = UIImage(data: nsd134!)
                    
                }
            }
        })
            //不需要重复加载数据
            self.jpspflag = 1
        }
    }

}
