//
//  ListViewController.swift
//  SeeNow
//
//  Created by apple on 14/12/23.
//  Copyright (c) 2014年 apple. All rights reserved.
//

import UIKit

class ListViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,HttpProtocol,UITextFieldDelegate,UIWebViewDelegate {
    var iftp = 0
    var nsdic:NSDictionary?
    var xmid = ""
    var _whichPersonIndex = 0
    //个人详细信息
    var perInfoView = UIView(frame: CGRectMake(1024, 65, 1024, 703))
    let frame0 = CGRectMake(1024, 65, 0, 703)
    let frame1 = CGRectMake(0, 65, 1024, 703)
    let frame2 = CGRectMake(264, 768, 760, 0)
    //个人信息的标签和背景图
    let btnClose = UIButton(frame: CGRectMake(980, 4, 29, 29))
    let lblName = UILabel(frame: CGRectMake(37, 3, 800, 27))
    //初评分组
    let lblCpfz = UILabel(frame: CGRectMake(37, 3, 800, 27))
    //定型意见
    let lblDxyj = UILabel(frame: CGRectMake(37, 3, 200, 27))
    //所属领域
    let lblSsly = UILabel(frame: CGRectMake(62, 75, 800, 27))
    //组内平均分
    let lblPjf = UILabel(frame: CGRectMake(62, 148, 200, 27))
    //意见说明
    let lblyj = UILabel(frame: CGRectMake(62, 148, 100, 27))
    let txtYj = UITextField(frame: CGRectMake(166, 148, 380, 60))
    let savebtn = UIButton(frame: CGRectMake(166, 218, 100, 30))
    let View1 = UIView(frame: CGRectMake(25, 37, 1024, 33))
    let View3 = UIView(frame: CGRectMake(25, 110, 1024, 33))
    let View5 = UIView(frame: CGRectMake(25, 183, 1024, 33))
    let webView = UIWebView(frame: CGRectMake(0, 300, 1024, 403))
    //接收数据
    var CyList:NSArray = NSArray()
    //评审组ID
    var PszId = 280
    //图片缓存
    var imageCache = Dictionary<String,UIImage>()
    var eHttp:HttpController = HttpController()
    //姓名数组
    var xnarray = [String]()
//    @IBOutlet weak var btnList: UIButton!
//    @IBOutlet weak var btnPic: UIButton!
    //搜索的框
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet var submitbutton: UIButton!
    @IBAction func allsubmit(sender: UIButton) {
        println("...");
        //全部提交的方法就是将打分表中的提交状态全部设为001001
    }
    //打分前后按钮
    let buttongo = UIButton(frame: CGRect(x:10,y:400,width:100,height:30))
    let buttonback = UIButton(frame: CGRect(x:914,y:400,width:100,height:30))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.delegate = self
        txtSearch.delegate = self
        mainTableView.delegate = self
        mainTableView.dataSource = self
//        btnPic.addTarget(self, action: "toScrollView:", forControlEvents: UIControlEvents.TouchUpInside)
        //初始化页面上的控件属性
        initView()
        self.view.addSubview(perInfoView)
        let CyListUrl = getall + "which=getall&zjid=\(userid)&zjidnew=\(zjidnew)"
        self.mainTableView.separatorStyle = UITableViewCellSeparatorStyle.None
        //初始化个人详细信息页面
        drawPerView()
        eHttp.delegate = self
        eHttp.onSearch(CyListUrl)
        txtSearch.clearsOnBeginEditing = true
        //全部提交按钮的样式设定
        submitbutton.layer.cornerRadius = 7
        submitbutton.alpha = 0.4
        submitbutton.backgroundColor = UIColor.grayColor()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        thread2()
    }
    
    func toScrollView(sender:UIButton){
        var svc = scrollView()
        self.presentViewController(svc, animated: true, completion: nil)
    }

    
    //接收返回的数据
    func didReceiveResult(result: NSDictionary) {
        nsdic = result
        
        if(result.allKeys[0] as NSString == "customer"){
            //println(result)
            if result["customer"] != nil{
                self.CyList = result["customer"] as NSArray
                self.mainTableView.reloadData()
            }
        }
        var count = CyList.count
        for var i = 0 ; i<count;i++ {
            var dic = self.CyList[i] as NSDictionary
            self.xnarray.append(dic["jzmc"] as String)
            println(dic["psjl"])
        }
        //初始化几个数组
        
    }
    //输入完毕后执行的事件
    func textFieldDidEndEditing(textField: UITextField){
        println("..输入你需要添加的事件..")
        
        var flag = 0
        var xm = self.txtSearch.text
        for var i = 0;i<self.CyList.count;i++ {
            if(self.xnarray[i] == xm){
                println("true")
                flag = 1
                let rowData = CyList[i] as NSDictionary
                loadData(rowData)
                UIView.animateWithDuration(0.3, animations: {()->Void in
                    self.perInfoView.frame = self.frame1
                })
                
                //添加一个后退的按钮
                var butGoback = UIButton(frame: CGRect(x:10,y:130,width:100,height:30))
                butGoback.setTitle("Back", forState: UIControlState.Normal)
                butGoback.backgroundColor = UIColor.blueColor()
                butGoback.layer.cornerRadius = 10
                butGoback.alpha = 0.3
                //退出按钮
                perInfoView.addSubview(butGoback)
                var butGoback1 = UIButton(frame: CGRect(x:914,y:130,width:100,height:30))
                butGoback1.setTitle("Exit", forState: UIControlState.Normal)
                butGoback1.backgroundColor = UIColor.blueColor()
                butGoback1.layer.cornerRadius = 10
                butGoback1.alpha = 0.3
                //perInfoView.addSubview(butGoback1)
                //前进按钮
                var butGoback2 = UIButton(frame: CGRect(x:10,y:175,width:100,height:30))
                butGoback2.setTitle("Forward", forState: UIControlState.Normal)
                butGoback2.backgroundColor = UIColor.blueColor()
                butGoback2.layer.cornerRadius = 10
                butGoback2.alpha = 0.3
                perInfoView.addSubview(butGoback2)
                butGoback.addTarget(self, action: "gabackmethod:", forControlEvents: UIControlEvents.TouchUpInside)
                butGoback1.addTarget(self, action: "goextibut:", forControlEvents: UIControlEvents.TouchUpInside)
                butGoback2.addTarget(self, action: "gabackmethod1:", forControlEvents: UIControlEvents.TouchUpInside)
            }else{
                
            }
        }
        if(flag == 0){
            var alert = UIAlertView(title: "提示", message: "没有找到此项目！", delegate: self, cancelButtonTitle: "好")
            alert.show()
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //tableviewdelegate1
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CyList.count
    }
    //tableviewdelegate2
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if(indexPath.row == 10){
            println("11ge")
        }
        let cell = tableView.dequeueReusableCellWithIdentifier("CyCell", forIndexPath: indexPath) as PerCell
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        let rowData = CyList[indexPath.row] as NSDictionary
        cell.lblName.text = rowData["Xmmc_zw"] as NSString
        cell.lblName.textColor = UIColor.blueColor()
        var jzmc = "奖种名称:"+(rowData["jzmc"] as NSString)
        cell.DetailLabel.text = jzmc
        var psdy = "评审单元:"+(rowData["psdy"] as NSString)
        cell.detaillabel1.text = psdy
        
        cell.perImageView.text = (String)(indexPath.row+1)
        cell.perImageView.font = UIFont(name: "American Typewriter", size: 45)
        cell.perImageView.textColor = UIColor(red: 244/255, green: 211/255, blue: 200/255, alpha: 1)
        //照片路径
//        if rowData["jzmc"] != nil{
//            
//        }else
//        {
//            let picRelative = rowData["Fjlj"] as NSString
//            let image = imageCache[picRelative]
//            if image != nil{
//                //cell.perImageView.image = image!
//            }else{
//                //个人照片地址
//                let pic = FjUrl + picRelative
//                let imgUrl = NSURL(string: pic)!
//                let request:NSURLRequest = NSURLRequest(URL: imgUrl)
//                NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response,data,error)->Void in
//                    let img = UIImage(data: data)
//                    //cell.perImageView.image = img!
//                    self.imageCache[picRelative] = img
//                })
//            }
//        }
        //(为了解决投票时候莫名其妙出现两次的BUG)
        cell.button1.backgroundColor = UIColor(patternImage: UIImage(named: "eye.png")!)
        cell.button2.backgroundColor = UIColor(patternImage: UIImage(named: "graypen.png")!)
        cell.button3.backgroundColor = UIColor(patternImage: UIImage(named: "graydh.png")!)
        cell.button4.backgroundColor = UIColor(patternImage: UIImage(named: "graydh.png")!)
        //
        if(rowData["psjl"] as String == "028002    "){
            println("....eye.....")
            
            cell.button1.backgroundColor = UIColor(patternImage: UIImage(named: "eye.png")!)
            cell.button2.backgroundColor = UIColor(patternImage: UIImage(named: "graypen.png")!)
            cell.button3.backgroundColor = UIColor(patternImage: UIImage(named: "graydh.png")!)
            cell.button4.backgroundColor = UIColor(patternImage: UIImage(named: "graydh.png")!)
            cell.button1.backgroundColor = UIColor(patternImage: UIImage(named: "blueicon.png")!)
        }else if(rowData["psjl"] as String == "028003    "){
            println("....pen.....")
            
            cell.button1.backgroundColor = UIColor(patternImage: UIImage(named: "eye.png")!)
            cell.button2.backgroundColor = UIColor(patternImage: UIImage(named: "graypen.png")!)
            cell.button3.backgroundColor = UIColor(patternImage: UIImage(named: "graydh.png")!)
            cell.button4.backgroundColor = UIColor(patternImage: UIImage(named: "graydh.png")!)
            cell.button2.backgroundColor = UIColor(patternImage: UIImage(named: "bulepen.png")!)
        }else if(rowData["psjl"] as String == "028004    "){
            println("....gui.....")
            cell.button1.backgroundColor = UIColor(patternImage: UIImage(named: "eye.png")!)
            cell.button2.backgroundColor = UIColor(patternImage: UIImage(named: "graypen.png")!)
            cell.button3.backgroundColor = UIColor(patternImage: UIImage(named: "graydh.png")!)
            cell.button4.backgroundColor = UIColor(patternImage: UIImage(named: "graydh.png")!)
            
            cell.button3.backgroundColor = UIColor(patternImage: UIImage(named: "greendh.png")!)
        }else if(rowData["psjl"] as String == "028001    "){
            println("....gui.....")
            
            cell.button1.backgroundColor = UIColor(patternImage: UIImage(named: "eye.png")!)
            cell.button2.backgroundColor = UIColor(patternImage: UIImage(named: "graypen.png")!)
            cell.button3.backgroundColor = UIColor(patternImage: UIImage(named: "graydh.png")!)
            cell.button4.backgroundColor = UIColor(patternImage: UIImage(named: "graydh.png")!)
            cell.button4.backgroundColor = UIColor(patternImage: UIImage(named: "eye.png")!)
        }else{
            println("...")
        }
        cell.button1.tag = indexPath.row
        cell.button1.addTarget(self, action: "cellbutton1:", forControlEvents: UIControlEvents.TouchUpInside)
        cell.button2.tag = indexPath.row
        cell.button2.addTarget(self, action: "cellbutton2:", forControlEvents: UIControlEvents.TouchUpInside)
        cell.button3.tag = indexPath.row
        cell.button3.addTarget(self, action: "cellbutton3:", forControlEvents: UIControlEvents.TouchUpInside)
        cell.button4.tag = indexPath.row
        cell.button4.addTarget(self, action: "cellbutton4:", forControlEvents: UIControlEvents.TouchUpInside)
        return cell
    }
    
    
    
    //每个单元格上得小按钮被点击执行的事件
    func cellbutton1(sender:UIButton){
        if(self.iftp == 1){
        var count = CyList.count
        for var i = 0;i<count;i++ {
            if(sender.tag == i){
                println("eye\(i)")
                let rowData = CyList[i] as NSDictionary
                let xmid = rowData["Xmid"] as String
                let url = getall + "which=tp&xmid="+xmid+"&zjid=\(zjidnew)&tpzl=028002"
                let NSUrl:NSURL = NSURL(string: url)!
                let request:NSURLRequest = NSURLRequest(URL: NSUrl)
                NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response,data,error)->Void in
                    var result = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
                    if result["customer"] != nil{
                        println(result["customer"])
                        if(result["customer"]! as NSObject == 1 ){
                            println("tpok")
                            self.reloadinfo()
                        }else{
                            var alert = UIAlertView(title: "提示", message: "保存失败", delegate: self, cancelButtonTitle: "好")
                            alert.show()
                        }
                    }
                })
                //保存好之后重载
            }
        }
        }else{
            var aler = UIAlertView(title: "提示框", message: "打分过程还没结束，暂时不可进行投票", delegate: self, cancelButtonTitle: "好")
            aler.show()
        }
    }
    
    func cellbutton2(sender:UIButton){
        if(self.iftp == 1){
        var count = CyList.count
        for var i = 0;i<count;i++ {
            if(sender.tag == i){
                println("pen\(i)")
                let rowData = CyList[i] as NSDictionary
                let xmid = rowData["Xmid"] as String
                let url = getall + "which=tp&xmid="+xmid+"&zjid=\(zjidnew)&tpzl=028003"
                let NSUrl:NSURL = NSURL(string: url)!
                let request:NSURLRequest = NSURLRequest(URL: NSUrl)
                NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response,data,error)->Void in
                    var result = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
                    if result["customer"] != nil{
                        println(result["customer"])
                        if(result["customer"]! as NSObject == 1 ){
                            println("tpok")
                            self.reloadinfo()
                        }else{
                            var alert = UIAlertView(title: "提示", message: "保存失败", delegate: self, cancelButtonTitle: "好")
                            alert.show()
                        }
                    }
                })
                //保存好之后重载
                
            }
        }
        }else{
            var aler = UIAlertView(title: "提示框", message: "打分过程还没结束，暂时不可进行投票", delegate: self, cancelButtonTitle: "好")
            aler.show()
        }

    }
    
    func cellbutton3(sender:UIButton){
        if(self.iftp == 1){
        var count = CyList.count
        for var i = 0;i<count;i++ {
            if(sender.tag == i){
                println("gui\(i)")
                let rowData = CyList[i] as NSDictionary
                let xmid = rowData["Xmid"] as String
                let url = getall + "which=tp&xmid="+xmid+"&zjid=\(zjidnew)&tpzl=028004"
                let NSUrl:NSURL = NSURL(string: url)!
                let request:NSURLRequest = NSURLRequest(URL: NSUrl)
                NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response,data,error)->Void in
                    var result = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
                    if result["customer"] != nil{
                        println(result["customer"])
                        if(result["customer"]! as NSObject == 1 ){
                            println("tpok")
                            self.reloadinfo()
                        }else{
                            var alert = UIAlertView(title: "提示", message: "保存失败", delegate: self, cancelButtonTitle: "好")
                            alert.show()
                        }
                    }
                })
                //保存好之后重载
            }
        }
        }else{
            var aler = UIAlertView(title: "提示框", message: "打分过程还没结束，暂时不可进行投票", delegate: self, cancelButtonTitle: "好")
            aler.show()
        }

    }
    
    func cellbutton4(sender:UIButton){
        if(self.iftp == 1){
        var count = CyList.count
        for var i = 0;i<count;i++ {
            if(sender.tag == i){
                println("gui\(i)")
                let rowData = CyList[i] as NSDictionary
                let xmid = rowData["Xmid"] as String
                let url = getall + "which=tp&xmid="+xmid+"&zjid=\(zjidnew)&tpzl=028001"
                let NSUrl:NSURL = NSURL(string: url)!
                let request:NSURLRequest = NSURLRequest(URL: NSUrl)
                NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response,data,error)->Void in
                    var result = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
                    if result["customer"] != nil{
                        println(result["customer"])
                        if(result["customer"]! as NSObject == 1 ){
                            println("tpok")
                            self.reloadinfo()
                        }else{
                            var alert = UIAlertView(title: "提示", message: "保存失败", delegate: self, cancelButtonTitle: "好")
                            alert.show()
                        }
                    }
                })
                //保存好之后重载
            }
        }
        }else{
            var aler = UIAlertView(title: "提示框", message: "打分过程还没结束，暂时不可进行投票", delegate: self, cancelButtonTitle: "好")
            aler.show()
        }

    }
    
    //写一个方法，如果是这一个，其他三个要恢复原来的（方法是先把所有的恢复，就可以了）
    func  resetall(){
        
    }
    
    //点击投票之后需要重载数据的方法
    func reloadinfo(){
        let url = getall + "which=getall&zjid=\(userid)&zjidnew=\(zjidnew)"
        let NSUrl:NSURL = NSURL(string: url)!
        let request:NSURLRequest = NSURLRequest(URL: NSUrl)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response,data,error)->Void in
            var result = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
            if(result.allKeys[0] as NSString == "customer"){
                if result["customer"] != nil{
                    println(result)
                    self.CyList = result["customer"] as NSArray
                    self.mainTableView.reloadData()
                }
            }
        })
    }
    //初始化页面控件
    func initView(){
//        btnPic.frame = CGRectMake(985, 30, 29, 29)
//        btnList.frame = CGRectMake(946, 30, 29, 29)
        txtSearch.frame = CGRectMake(422, 30, 160, 25)
        txtSearch.leftView = UIImageView(image: UIImage(named: "seac.png"))
        txtSearch.leftViewMode = UITextFieldViewMode.Always
        txtSearch.background = UIImage(named: "seacrh.png")
        txtSearch.borderStyle = UITextBorderStyle.None
        topView.backgroundColor = UIColor(patternImage: UIImage(named: "topng.png")!)
        perInfoView.backgroundColor = UIColor.whiteColor()
        
    }
    //初始化个人信息页面控件
    func drawPerView(){
        perInfoView.layer.cornerRadius = 5
        perInfoView.layer.borderWidth = 2
        perInfoView.layer.borderColor = UIColor(red: 248/255, green: 248/255, blue: 248/255, alpha: 0.5).CGColor
        btnClose.backgroundColor = UIColor(patternImage: UIImage(named: "shut.png")!)
        btnClose.addTarget(self, action: "closePerInfoView:", forControlEvents: UIControlEvents.AllTouchEvents)
        perInfoView.addSubview(btnClose)
        View1.backgroundColor = UIColor(red: 248/255, green: 248/255, blue: 248/255, alpha: 1)
        View3.backgroundColor = UIColor(red: 248/255, green: 248/255, blue: 248/255, alpha: 1)
        View5.backgroundColor = UIColor(red: 248/255, green: 248/255, blue: 248/255, alpha: 1)
        //保存按钮的添加
        savebtn.layer.cornerRadius = 10
        savebtn.setTitle("保存", forState: UIControlState.Normal)
        savebtn.backgroundColor = UIColor.blueColor()
        savebtn.addTarget(self, action: "svaefunction:", forControlEvents: UIControlEvents.TouchUpInside)
        savebtn.alpha = 0.5
        perInfoView.addSubview(savebtn)
        lblName.text = "sfdsfasdfdasf"
        View1.addSubview(lblName)
        perInfoView.addSubview(View1)
        lblCpfz.text = "sdfsdf"
        View3.addSubview(lblCpfz)
        perInfoView.addSubview(View3)
        lblDxyj.text = "ss"
        View5.addSubview(lblDxyj)
        lblDxyj.text = "初评意见：优先推荐"
        lblyj.text = "分       数："
        txtYj.layer.borderWidth = 1
        txtYj.layer.cornerRadius = 10
        txtYj.textAlignment = NSTextAlignment.Left
        txtYj.backgroundColor = UIColor.whiteColor()
        perInfoView.addSubview(txtYj)
        perInfoView.addSubview(lblSsly)
        //perInfoView.addSubview(lblPjf)
        perInfoView.addSubview(lblyj)
        perInfoView.addSubview(webView)
    }
    
    //保存按钮单机事件
    func svaefunction(sender:UIButton){
        //项目ID
        let rowData = CyList[_whichPersonIndex] as NSDictionary
        var xmidnow = rowData["Xmid"] as String
        
        //专家ID
        var useridnow = userid as String
        useridnow = "EF7B6BB2-47C2-4F12-A662-59DACCE63362"
        var fz = txtYj.text as String
//        println(xmidnow)
//        println(useridnow)
//        println(fz)
        println(zjidnew)
        //保存逻辑
        let url = getall + "which=save&xmid="+xmidnow+"&zjid="+zjidnew+"&fz="+fz
        let NSUrl:NSURL = NSURL(string: url)!
        let request:NSURLRequest = NSURLRequest(URL: NSUrl)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response,data,error)->Void in
            var result = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
            if result["customer"] != nil{
                println(result["customer"])
                if(result["customer"]! as NSObject == 1 ){
                    println("ok")
                }else{
                    var alert = UIAlertView(title: "提示", message: "保存失败", delegate: self, cancelButtonTitle: "好")
                    alert.show()
                }
            }
        })
    }
    //个人信息数据加载
    func loadData(rowData:NSDictionary){
        //设置下拉不出现黑色底色
        webView.scrollView.bounces = false
        var useridnow = userid
        self.xmid = rowData["Xmid"] as String
        //申报书地址添加
        var jzid = rowData["Jzid"] as String
        var SbsUrl = sbsurl
        if(jzid == "b9bf883e-2d0f-4eee-b900-543998012869"){
            SbsUrl = SbsUrl + "ProjectView_Zrkx.aspx?Xmid=" + xmid
        }else if(jzid == "17a9909e-9a9f-4250-9da0-6b6060efa5a8"){
            SbsUrl = SbsUrl + "ProjectView_Jsfm.aspx?Xmid=" + xmid
        }else if(jzid == "1d36a3eb-8c61-4a29-82fc-b13eb72774d9" || jzid == "b33534d7-e570-448a-a21a-907f5e698020" || jzid == "689482bb-746d-4ca7-b330-47bb1355fe4d"){
            SbsUrl = SbsUrl + "ProjectView_Kjjb.aspx?Xmid=" + xmid
        }
        let url = NSURL(string: SbsUrl)!
        let request = NSURLRequest(URL: url)
        webView.tag = 1009
        webView.loadRequest(request)
        let Xm = rowData["Xmmc_zw"] as NSString
        lblName.text = "项目名称：\(Xm)"
        let Ssly = rowData["jzmc"] as NSString
        lblSsly.text = "奖       种：\(Ssly)"
        let Pszmc = rowData["psdy"] as NSString
        lblCpfz.text = "评审单元：\(Pszmc)"
    }
    
    func closePerInfoView(sender:UIButton)
    {
        UIView.animateWithDuration(2, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            var frame = CGRect(x:768,y:1024,width:1024,height:768)
            self.perInfoView.frame = frame
            self.perInfoView.alpha = 1
            }, completion: nil)
    }
    //单元格点击执行的事件
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        _whichPersonIndex = indexPath.row
        let rowData = CyList[indexPath.row] as NSDictionary
        loadData(rowData)
        self.perInfoView.alpha = 0
        UIView.animateWithDuration(2, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.perInfoView.frame = self.frame1
            self.perInfoView.alpha = 1
            }, completion: nil)
        //添加一个后退的按钮
        var butGoback = UIButton(frame: CGRect(x:10,y:130,width:100,height:30))
        butGoback.setTitle("Back", forState: UIControlState.Normal)
        butGoback.backgroundColor = UIColor.blueColor()
        butGoback.layer.cornerRadius = 10
        butGoback.alpha = 0.1
        //退出按钮
        perInfoView.addSubview(butGoback)
        var butGoback1 = UIButton(frame: CGRect(x:914,y:130,width:100,height:30))
        butGoback1.setTitle("Exit", forState: UIControlState.Normal)
        butGoback1.backgroundColor = UIColor.blueColor()
        butGoback1.layer.cornerRadius = 10
        butGoback1.alpha = 0.1
        //perInfoView.addSubview(butGoback1)
        //前进按钮
        var butGoback2 = UIButton(frame: CGRect(x:10,y:175,width:100,height:30))
        butGoback2.setTitle("Forward", forState: UIControlState.Normal)
        butGoback2.backgroundColor = UIColor.blueColor()
        butGoback2.layer.cornerRadius = 10
        butGoback2.alpha = 0.1
        perInfoView.addSubview(butGoback2)
        butGoback.addTarget(self, action: "gabackmethod:", forControlEvents: UIControlEvents.TouchUpInside)
        butGoback1.addTarget(self, action: "goextibut:", forControlEvents: UIControlEvents.TouchUpInside)
        butGoback2.addTarget(self, action: "gabackmethod1:", forControlEvents: UIControlEvents.TouchUpInside)
        dfbutton();
    }
    
    //后退按钮
    func gabackmethod(sender:UIButton){
        self.webView.goBack()
        println("goback")
    }
    //前进按钮
    func gabackmethod1(sender:UIButton){
        self.webView.goForward()
        println("goForward")
    }
    //关闭按钮
    func goextibut(sender:UIButton){
        println("exit")
        UIView.animateWithDuration(2, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            var frame = CGRect(x:768,y:1024,width:1024,height:768)
            self.perInfoView.frame = frame
            self.perInfoView.alpha = 1
            }, completion: nil)
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    
    //数据加载时，列表的效果
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1)
        UIView.animateWithDuration(0.4, animations: { () -> Void in
            cell.layer.transform = CATransform3DMakeScale(1, 1, 1)
        })
    }
    
    //打分界面前后按钮
    func dfbutton(){
        buttongo.setTitle("上一个", forState: UIControlState.Normal)
        buttongo.backgroundColor = UIColor.blueColor()
        buttongo.alpha = 0.5
        buttongo.layer.cornerRadius = 10
        buttongo.addTarget(self, action: "dfbuttongo:", forControlEvents: UIControlEvents.TouchUpInside)
        buttonback.setTitle("下一个", forState: UIControlState.Normal)
        buttonback.backgroundColor = UIColor.blueColor()
        buttonback.alpha = 0.5
        buttonback.layer.cornerRadius = 10
        buttonback.addTarget(self, action: "dfbuttonback:", forControlEvents: UIControlEvents.TouchUpInside)
        perInfoView.addSubview(buttongo)
        perInfoView.addSubview(buttonback)
    }
    func dfbuttongo(sender:UIButton){
        if(_whichPersonIndex == 0){
            //不变
        }else{
            _whichPersonIndex = _whichPersonIndex-1
            let rowData = CyList[_whichPersonIndex] as NSDictionary
            loadData(rowData)
            //现将原来的关闭
            UIView.animateWithDuration(0.1, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                var frame = CGRect(x:1024,y:765,width:1024,height:768)
                self.perInfoView.frame = frame
                self.perInfoView.alpha = 1
                }, completion: nil)
            //再打开新一个
            UIView.animateWithDuration(1.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                self.perInfoView.frame = self.frame1
                self.perInfoView.alpha = 1
                }, completion: nil)
        }
        
    }
    func dfbuttonback(sender:UIButton){
        if(_whichPersonIndex == CyList.count-1){
            //不变
        }else{
        _whichPersonIndex = _whichPersonIndex+1
            let rowData = CyList[_whichPersonIndex] as NSDictionary
            loadData(rowData)
            //现将原来的关闭
            UIView.animateWithDuration(0.1, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                var frame = CGRect(x:1024,y:765,width:1024,height:768)
                self.perInfoView.frame = frame
                self.perInfoView.alpha = 1
                }, completion: nil)
            //再打开新一个
            UIView.animateWithDuration(1.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                self.perInfoView.frame = self.frame1
                self.perInfoView.alpha = 1
                }, completion: nil)
        }
    }
    
        //界面控制流程————开启异步执行方法（线程打印no字符串）判定是否可以投票
        func thread2()->Void{
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            //这里写需要一直执行的代码（2秒扫描一次数据库）
            for var i = 0 ; i > -1 ; i++ {
                sleep(2);
                let url = getall + "which=iftp&pszid="+userid
                let NSUrl:NSURL = NSURL(string: url)!
                let request:NSURLRequest = NSURLRequest(URL: NSUrl)
                NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response,data,error)->Void in
                    var result = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
                    if result["customer"] != nil{
                        if(result["customer"]! as NSObject == 1 ){
                            self.iftp = 1
                        }else{
                            self.iftp = 0
                        }
                    }
                })
                if(self.iftp == 1){
                    break
                }
            }
            //返回主线程跳转才可以成功（UI提示也只有在主线程中才会成功）
                dispatch_async(dispatch_get_main_queue(), {
                    println("这里返回主线程，写需要主线程执行的代码")
                    var al = UIAlertView(title: "提醒框", message: "检测到打分过程已经结束，可以进行投票！", delegate: self, cancelButtonTitle: "好")
                    al.show()
                })
            })
        }
    
}
