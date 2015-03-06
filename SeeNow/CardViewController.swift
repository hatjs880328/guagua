//
//  CardViewController.swift
//  SeeNow
//
//  Created by apple on 14/12/13.
//  Copyright (c) 2014年 apple. All rights reserved.
//

import UIKit

class CardViewController: UIViewController {

    //所有信息列表
    var InfoList:NSArray = NSArray()
    //计数器
    var count:Int = 0
    //图片缓存
    var imageCache = Dictionary<String,UIImage>()
    
    //卡片效果的初始化
    let leftView = UIView(frame: CGRectMake(0, 20, 1024, 748))
    let frame00 = CGRectMake(0, 20, 0, 748)
    let frame10240  = CGRectMake(1024, 20, 0, 748)
    let frame = CGRectMake(0, 20, 1024, 748)
    

    let downView = UIView(frame: CGRectMake(0, 0, 1024, 0))
    let downFrame = CGRectMake(262, 100, 500, 300)
    let initDownFrame = CGRectMake(0, 0, 1024, 0)
    let lblDfInfo = UILabel(frame: CGRectMake(30, 50, 200, 20))
    let txtDf = UITextField(frame: CGRectMake(250, 50, 200, 20))
    
    //绘制个人信息标签
    let lblForName = UILabel(frame: CGRectMake(10, 20, 60, 20))
    let btnName = UIButton(frame: CGRectMake(80, 20, 100, 20))
     let PicImg = UIImageView(frame: CGRectMake(800, 20, 140, 200))
    let WebSbsView = UIWebView(frame: CGRectMake(112, 360, 800, 400))
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        
        //将打分的View加到leftView当中
        downView.backgroundColor = UIColor.grayColor()
        downView.alpha = 0.3
        downView.hidden = true
        downView.addSubview(self.lblDfInfo)
        downView.addSubview(self.txtDf)
        leftView.addSubview(self.downView)
        //初始化的数据
        let rowData = InfoList[count] as NSDictionary
       
        //加载控件属性
        initView()
        //加载控件数据
        initViewData(rowData)
        //加载打分视图
        drawDownView(rowData)
        leftView.backgroundColor = UIColor(patternImage: UIImage(named: "bg.jpg")!)
        //leftView.alpha = 0.5
        //左划手势
        let leftSwip = UISwipeGestureRecognizer(target: self, action: "leftSwip:")
        leftSwip.direction = UISwipeGestureRecognizerDirection.Left
        leftView.addGestureRecognizer(leftSwip)
        //右划手势
        let rightSwip = UISwipeGestureRecognizer(target: self, action: "rightSwip:")
        rightSwip.direction = UISwipeGestureRecognizerDirection.Right
        //下划手势
        let downSwip = UISwipeGestureRecognizer(target: self, action: "downSwip:")
        downSwip.direction = UISwipeGestureRecognizerDirection.Down
        leftView.addGestureRecognizer(downSwip)
        leftView.addGestureRecognizer(rightSwip)
        //将左视图初始化进View
        self.view.addSubview(leftView)
    }
    //左滑动的方法,类似卡片的动画
    func leftSwip(sender:UIView){

        if count+1 >= InfoList.count {
         let EndAlert = UIAlertView(title: "提示", message:"这是最后一页了", delegate: self, cancelButtonTitle: "好的")
            EndAlert.show()
        }else
        {
            UIView.animateWithDuration(0.5, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {()->Void in
                self.downView.hidden = true
                self.leftView.frame = self.frame00
                self.leftView.alpha = 0
                self.count++
                //self.leftView.frame = self.frame
                }, completion: {(bool)->Void in
                    UIView.animateWithDuration(0, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {()->Void in
                        self.leftView.frame = self.frame10240
                        // self.leftView.frame = self.frame
                        }, completion: {(bool)->Void in
                            UIView.animateWithDuration(0.5, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {()->Void in
                                // self.leftView.frame = self.frame10240
                                //更新数据
                                self.initViewData(self.InfoList[self.count] as NSDictionary)
                                //打分视图
                                self.drawDownView(self.InfoList[self.count] as NSDictionary)
                                self.leftView.frame = self.frame
                                //self.leftView.backgroundColor = UIColor.greenColor()
                                self.leftView.alpha = 1
                                }, completion: nil)
                    })
            })
        }
    
    }
    
    //右滑
    func rightSwip(sender:UIView){
        if count == 0{
            UIView.animateWithDuration(1, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {()->Void in
                let listController = MyViewController()
                 self.leftView.frame = self.frame10240
                self.presentViewController(listController, animated: true, completion: nil)
                }, completion: nil)
        
        }else
        {
            UIView.animateWithDuration(0.5, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {()->Void in
                self.downView.hidden = true
                self.leftView.frame = self.frame10240
                self.leftView.alpha = 0
                self.count--
                //self.leftView.frame = self.frame
                }, completion: {(bool)->Void in
                    UIView.animateWithDuration(0, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {()->Void in
                        self.leftView.frame = self.frame00
                        // self.leftView.frame = self.frame
                        //self.leftView.backgroundColor = UIColor.greenColor()
                        }, completion: {(bool)->Void in
                            UIView.animateWithDuration(0.5, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {()->Void in
                                // self.leftView.frame = self.frame10240
                                self.leftView.frame = self.frame
                                //更换下一个人的数据
                                self.initViewData(self.InfoList[self.count] as NSDictionary)
                                //打分视图
                                self.drawDownView(self.InfoList[self.count] as NSDictionary)
                                
                                self.leftView.alpha = 1
                                }, completion: nil)
                    })
            })
        }
    }
    //下划手势
    func downSwip(sender:UIView){
        UIView.animateWithDuration(0.4, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {()->Void in
            self.downView.hidden = false
            self.downView.frame = self.downFrame
        }, completion: nil)
    }
    func drawDownView(rowData:NSDictionary){
        let Name = rowData["Xm_zw"] as NSString
        lblDfInfo.text = "请为\(Name)打分"
    }
    //初始化leftView 上的控件属性
    func initView(){
        lblForName.text = "姓  名:"
        lblForName.textAlignment = NSTextAlignment.Right
        self.leftView.addSubview(lblForName)
       
        btnName.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        
        self.leftView.addSubview(btnName)
        self.leftView.addSubview(PicImg)
        self.leftView.addSubview(WebSbsView)
    }
    //初始化数据
    func initViewData(rowData:NSDictionary){
       
         //btnName.titleLabel?.text = rowData["Xm_zw"] as NSString
        btnName.setTitle( rowData["Xm_zw"] as NSString, forState: UIControlState.Normal)
        
        //照片路径
        if rowData["Fjlj"] == nil{
            PicImg.image = UIImage(named: "11.png")!
        }else
        {
            let picRelative = rowData["Fjlj"] as NSString
            let image = imageCache[picRelative]
            if image != nil{
                PicImg.image = image!
            }else{
                //个人照片地址
                let pic = FjUrl + picRelative
                let imgUrl = NSURL(string: pic)!
                let request:NSURLRequest = NSURLRequest(URL: imgUrl)
                NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response,data,error)->Void in
                    let img = UIImage(data: data)
                    self.PicImg.image = img!
                    self.imageCache[picRelative] = img
                })
            }
        }
        //网页版申报书
        let SbsUrl = HWZPUrl + "CySbs/CySbs.aspx?Sbbh=" + (rowData["Sbsid"] as NSString)
        let url = NSURL(string: SbsUrl)!
        let request = NSURLRequest(URL: url)
        WebSbsView.loadRequest(request)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
