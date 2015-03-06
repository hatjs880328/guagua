//
//  userCenter.swift
//  SeeNow
//
//  Created by apple on 15/2/3.
//  Copyright (c) 2015 apple. All rights reserved.
//

import UIKit
import QuartzCore

class userCenter: UIViewController,UITextFieldDelegate {
    //全局变量开始
    var width:CGFloat = 0
    var height:CGFloat = 0
    let topview = UIView(frame: CGRectZero)
    let topuserviewe = UIView(frame: CGRectZero)
    let botview = UIView(frame: CGRectZero)
    let topbarView = UIView(frame: CGRectMake(0, 0, 0, 0))
    let barview1 = UIView(frame: CGRectMake(0, 0, 0, 0))
    let barview2 = UIView(frame: CGRectMake(0, 0, 0, 0))
    let barview3 = UIView(frame: CGRectMake(0, 0, 0, 0))
    let barview4 = UIView(frame: CGRectMake(0, 0, 0, 0))
    var colorall = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1)
    var bgcolorall = UIColor(red: 85/255, green: 169/255, blue: 254/255, alpha: 1)
    var uifont1 = UIFont(name: "Arial-BoldItalicMT", size: 14)
    var label = UITextField(frame: CGRectZero)
    var label1 = UITextField(frame: CGRectZero)
    var stringarr = [String]()
    //全局变量结束
    
    //MARK: -SYS FUNCS
    override func viewDidLoad() {
        super.viewDidLoad()
        width = self.view.bounds.width
        height = self.view.bounds.height
        stringarr.append("我的收藏")
        stringarr.append("我的订单")
        stringarr.append("检查更新")
        stringarr.append("注册信息")
        stringarr.append("预留添加")
        stringarr.append("预留添加")
    }

    override func viewDidAppear(animated: Bool) {
        topsetting()
        top2Settting()
        botSetting()
        botViewbar()
        
    }
    //收到内存警告信息
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: -VIEW SETTING
    //top1
    func topsetting(){
        let frame = CGRectMake(0, 0, width, 20)
        self.topview.frame = frame
        self.topview.backgroundColor = colorall
        self.view.addSubview(topview)
    }
    
    //top2
    func top2Settting(){
        let frame = CGRectMake(0, 20, width, 150)
        self.topuserviewe.frame = frame
        self.topuserviewe.backgroundColor = UIColor(patternImage: UIImage(named: "loginBg-1.png")!)
        self.view.addSubview(topuserviewe)
        //登录LOYGEC
        let midbigview = UIView(frame: CGRectMake(15, 5, width/3*2, 71))
        midbigview.backgroundColor = UIColor.whiteColor()
        midbigview.layer.cornerRadius = 10
        midbigview.layer.shadowColor = UIColor.blackColor().CGColor
        midbigview.layer.shadowOffset = CGSize(width: 2, height: 2)
        midbigview.layer.shadowRadius = 10
        midbigview.layer.shadowOpacity = 0.5
        self.topuserviewe.addSubview(midbigview)
        
        label = UITextField(frame: CGRectMake(0, 0, width/3*2, 35))
        label.delegate = self
            let leftpic = UIImageView(frame: CGRectMake(2, 2, 40, 30))
            leftpic.image = UIImage(named: "LASTREN-41.png")
        label.leftView = leftpic
        label.leftViewMode = UITextFieldViewMode.Always
        label.contentVerticalAlignment = UIControlContentVerticalAlignment.Center
        label.backgroundColor = UIColor.whiteColor()
        label.layer.shadowOffset = CGSize(width: 1, height: 1)
        label.layer.shadowRadius = 5
        label.layer.shadowColor = UIColor.blackColor().CGColor
        label.layer.cornerRadius = 7
        label.text = "username"
        label.textColor = colorall
        label.font = uifont1
        
        let midview = UIView(frame: CGRectMake(0, 35, width/3*2, 1))
        midview.backgroundColor = colorall
        midbigview.addSubview(midview)
        
        label1 = UITextField(frame: CGRectMake(0, 36, width/3*2, 35))
        label1.delegate = self
            let leftpic1 = UIImageView(frame: CGRectMake(2, 2, 40, 30))
            leftpic1.image = UIImage(named: "LASTSUO-41.png")
        label1.leftView = leftpic1
        label1.leftViewMode = UITextFieldViewMode.Always
        label1.contentVerticalAlignment = UIControlContentVerticalAlignment.Center
        label1.backgroundColor = UIColor.whiteColor()
        label1.layer.cornerRadius = 7
        label1.text = "password"
        label1.textColor = colorall
        label1.font = uifont1
        midbigview.addSubview(label)
        midbigview.addSubview(label1)
        //用户头像
        let headInfoview = UIImageView(frame: CGRectMake(width-60,5 , 50, 50))
        headInfoview.image = UIImage(named: "yonghutouxiang-1.png")
        headInfoview.layer.cornerRadius = 25
        headInfoview.layer.masksToBounds = true
        headInfoview.layer.borderColor = colorall.CGColor
        headInfoview.layer.borderWidth = 1
        self.topuserviewe.addSubview(headInfoview)
        let loginIf = UILabel(frame: CGRectMake(width-60, 55, 50, 20))
        loginIf.text = "未登录"
        loginIf.textAlignment = NSTextAlignment.Center
        loginIf.font = uifont1
        loginIf.textColor = UIColor.redColor()
        self.topuserviewe.addSubview(loginIf)
        //login按钮
        let loginView = UILabel(frame: CGRectMake(15, 90, width/3*2, 36))
        loginView.backgroundColor = bgcolorall
        loginView.text = "Login in"
        loginView.textColor = UIColor.whiteColor()
        loginView.textAlignment = NSTextAlignment.Center
        loginView.layer.cornerRadius = 7
        loginView.layer.masksToBounds = true
        self.topuserviewe.addSubview(loginView)
        
        
        //没有用到的内部动态阴影
        var anim = CABasicAnimation(keyPath: "innerShadowOpacity")
        anim.duration = 1.0
        anim.fromValue = 1.0
        anim.toValue = 0.0
        anim.repeatCount = 10
        anim.autoreverses = true
        
        var skinner = SKInnerShadowLayer()
        skinner.colors = [UIColor(white: 0.98, alpha: 1).CGColor,UIColor(white: 0.9, alpha: 1).CGColor]
        skinner.frame = CGRectMake(0, 0, width/3*2, 35)
        skinner.cornerRadius = 5
        skinner.innerShadowOpacity = 1
        skinner.innerShadowColor = UIColor.darkGrayColor().CGColor
        skinner.borderWidth = 0
        //skinner.addAnimation(anim, forKey: "innerShadowOpacity")
        
        var skinner1 = SKInnerShadowLayer()
        skinner1.colors = [UIColor(white: 0.98, alpha: 1).CGColor,UIColor(white: 0.9, alpha: 1).CGColor]
        skinner1.frame = CGRectMake(0, 0, width/3*2, 35)
        skinner1.cornerRadius = 5
        skinner1.innerShadowOpacity = 1
        skinner1.innerShadowColor = UIColor.darkGrayColor().CGColor
        skinner1.borderWidth = 0
        //skinner1.addAnimation(anim, forKey: "innerShadowOpacity")
//        label1.layer.addSublayer(skinner)
//        label.layer.addSublayer(skinner1)
        
        
        
        
    }
    
    //bottom
    func botSetting(){
        let frame = CGRectMake(0, 170, width, height-220)
        self.botview.frame = frame
        self.botview.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(botview)
        //shoucang
        for var i:CGFloat = 0;i<2;i++ {
            for var j:CGFloat = 0;j<2;j++ {
                var width1:CGFloat = (width+100)/3*j+(width-200)/3
                var height1:CGFloat = 120 * i+20
                var scview = UIView(frame: CGRectMake(width1, height1, 100, 100))
                    scview.backgroundColor = bgcolorall
                    scview.layer.cornerRadius = 10
                    scview.layer.shadowColor = UIColor.blackColor().CGColor
                    scview.layer.shadowOffset = CGSize(width: 2, height: 2)
                    scview.layer.shadowRadius = 10
                    scview.layer.shadowOpacity = 0.5
                    self.botview.addSubview(scview)
                var mm = Int(2*i+j)
                var namelabel = UILabel(frame: CGRectMake(10, 10, 80, 80))
                namelabel.font = self.uifont1
                namelabel.textColor = UIColor.whiteColor()
                namelabel.text = self.stringarr[mm] as String
                namelabel.textAlignment = NSTextAlignment.Center
                scview.addSubview(namelabel)
            }
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
    
    
    
    
    //MARK: -ACTION
    func textFieldShouldReturn(textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }
    
    //导航按钮事件 a
    func but1press(sender:UIButton){
        println("press1")
        var cont = ggview()
        self.presentViewController(cont, animated: false, completion: nil)
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
    
    

}
