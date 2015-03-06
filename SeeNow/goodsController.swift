//
//  goodsController.swift
//  SeeNow
//
//  Created by apple on 15/2/9.
//  Copyright (c) 2015年 apple. All rights reserved.
//

import UIKit

class goodsController: UIViewController {

    //  MARK: --全局变量
    var width:CGFloat = 0
    var height:CGFloat = 0
    let topview = UIView(frame: CGRectZero)
    let navview = UIView(frame: CGRectZero)
    let botsaveview = UIView(frame: CGRectZero)
    let colorall = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
    let bgcolorall = UIColor(red: 85/255, green: 169/255, blue: 254/255, alpha: 1)
    
    //MARK: SYS FUNC
    override func viewDidLoad() {
        super.viewDidLoad()
        self.width = self.view.bounds.width
        self.height = self.view.bounds.height
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(animated: Bool) {
        settopview()
        navviewsetting()
        bigPic()
        bigPic2()
        botSc()
    }
    
    //MARK:  VIEW SET
    func settopview(){
        self.topview.frame = CGRectMake(0, 0, width, 20)
        self.topview.backgroundColor = colorall
        self.view.addSubview(topview)
    }
    
    func navviewsetting(){
        self.navview.frame = CGRectMake(0, 20, width, 30)
        self.navview.backgroundColor = bgcolorall
        self.view.addSubview(navview)
        
        var returnbut = UIButton(frame: CGRectMake(10, 0, 29, 29))
        returnbut.backgroundColor = UIColor(patternImage: UIImage(named: "ocrBack.png")!)
        returnbut.addTarget(self, action: "goback:", forControlEvents: UIControlEvents.TouchUpInside)
        self.navview.addSubview(returnbut)
    }
    //中间商品
    func bigPic(){
        
    }
    //猜你喜欢
    func bigPic2(){
        
    }
    //底部收藏
    func botSc(){
        self.botsaveview.frame = CGRectMake(0, height-50, width, 50)
        self.botsaveview.backgroundColor = colorall
        self.view.addSubview(botsaveview)
    }
    
    //MARK: ACTION ...
    func goback(sender:UIButton){
        var con = allInfopush()
        self.presentViewController(con, animated: false, completion: nil)
    }

}
