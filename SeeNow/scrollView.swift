import UIKit

var mmm3 = 0
class scrollView: UIViewController,HttpProtocol {
    var flag:Int = 0
    var cxlistarray1:NSArray = []
    var re:NSDictionary?
    var ehttp:HttpController = HttpController()
    let color4 = UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1)
    var leftdata:NSArray = []
    var xmarrar = [String]()
    var back = 4
    //san三个大的VIEW
    let naView  = UIView(frame: CGRect(x:0,y:0,width:1024,height:65))
    let midView = UIView(frame: CGRect(x:0,y:65,width:1024,height:550))
    let botView = UIView(frame: CGRect(x:0,y:615,width:1024,height:153))
    //中部VIEW里面的小VIEW
    let midsmallview = UIView(frame: CGRect(x:150,y:30,width:724,height:500))
    let midsmallviewleft = UIView(frame: CGRect(x:-100,y:80,width:200,height:250))
    let midsmallviewright = UIView(frame: CGRect(x:924,y:80,width:200,height:250))
    let framemid = CGRect(x:150,y:30,width:724,height:500)
    let frameleft = CGRect(x:-100,y:80,width:200,height:250)
    let frameright = CGRect(x:924,y:80,width:200,height:250)
    let smallpicture = UIImageView(frame: CGRect(x:0,y:0,width:200,height:250))
    let smallpicture1 = UIImageView(frame: CGRect(x:0,y:0,width:200,height:250))
    //大图层上面的IMAGE,LABEL
    let imageview_big = UIImageView(frame: CGRect(x:20,y:20,width:200,height:280))
    let but_big = UIButton(frame: CGRect(x:20,y:330,width:200,height:30))
    let rx_big = UILabel(frame: CGRect(x:250,y:20,width:280,height:50))
    let ssly_big = UILabel(frame: CGRect(x:250,y:80,width:280,height:50))
    let sbdw_big = UILabel(frame: CGRect(x:250,y:140,width:400,height:50))
    let psfz_big = UILabel(frame: CGRect(x:250,y:200,width:280,height:50))
    let yjsm_big = UILabel(frame: CGRect(x:250,y:260,width:80,height:50))
    let yjsm_big1 = UITextField(frame: CGRect(x:320,y:270,width:380,height:100))
    let savebtn = UIButton(frame: CGRect(x:320,y:385,width:120,height:30))
    let commitbtn = UIButton(frame: CGRect(x:450,y:385,width:120,height:30))
    //最底下的VIEW中得东西
    let scrollview = UIScrollView(frame: CGRect(x:32,y:4,width:960,height:152))
    //隐藏的申报书查看webview
    let sbsview = UIWebView(frame: CGRect(x:1025,y:768,width:0,height:0))
    //导航栏中得搜索按钮
    let searchField = UITextField(frame: CGRect(x:400,y:30,width:224,height:20))
    let but1 = UIButton(frame: CGRect(x:924,y:30,width:30,height:30))
    let but2 = UIButton(frame: CGRect(x:956,y:30,width:30,height:30))
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        //获取数据
        var url = GetService+"which=CyList&PszId=280"
        ehttp.delegate  = self
        ehttp.onSearch(url)
        //顶部的VIEW
        navagitionView()
        //ZHONG中部的VIEW(1)
        midView2()
        //底部的VIEW
        botView3()
        //检测线程
        //thread2()
        //隐藏的查看申报书WEBVIEW
        sbswebView()
        //today
        //todayText()
        
    }
    
    //x需要实现的方法
    func didReceiveResult(result:NSDictionary){
        println("")
        var ui = UIAlertView(title: "msg", message: "start info....", delegate: self, cancelButtonTitle: "cancle")
        //ui.show()
        //println(result)
        if(result.allKeys[0] as String == "CyList"){
            if (result["CyList"] != nil){
                self.leftdata = result["CyList"] as NSArray
                //println(self.leftdata[0])
            }
        }
        addinfomidFunc()
        botviewSetting()
        xmarray()
    }
    //将名字放在一个数组中
    func xmarray(){
        var counts = leftdata.count
        println(counts)
        for (var i = 0; i < counts ;i++){
            var xmdata = leftdata[i] as NSDictionary
            self.xmarrar.append(xmdata["Xm_zw"] as String)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //上面导航栏
    func navagitionView(){
        let imview = UIImageView(image: UIImage(named: "topng.png"))
        naView.addSubview(imview)
        naView.alpha = 0.8
        //在中间加一个搜索框
        searchField.backgroundColor = UIColor.whiteColor()
        searchField.layer.cornerRadius = 10
        searchField.text = "输入姓名进行搜索"
        
        searchField.textAlignment = NSTextAlignment.Center
        self.naView.addSubview(searchField)
        self.view.addSubview(naView)
        //
        let searchButton = UIButton(frame: CGRect(x:625,y:30,width:50,height:20))
        var imageframe = CGRect(x:0,y:0,width:20,height:20)
        var imageview = UIImageView(frame: imageframe)
        imageview.image = UIImage(named: "seac.png")
        searchButton.addSubview(imageview)
        searchButton.addTarget(self, action: "searchbuttonpress:", forControlEvents: UIControlEvents.TouchUpInside)
        naView.addSubview(searchButton)
        //导航栏切换按钮
        
        but1.layer.cornerRadius = 4
        but1.tag = 1
        but1.addTarget(self, action: "tag1:", forControlEvents: UIControlEvents.TouchUpInside)
        let but1image = UIImageView(frame: CGRect(x:0,y:0,width:28,height:28))
        but1image.image = UIImage(named: "piclist.png")
        but1.addSubview(but1image)
        
        
        //but2.backgroundColor = UIColor.whiteColor()
        but2.layer.cornerRadius = 4
        but2.tag = 2
        but2.addTarget(self, action: "tag2:", forControlEvents: UIControlEvents.TouchUpInside)
        let but2image = UIImageView(frame: CGRect(x:0,y:0,width:28,height:28))
        but2image.image = UIImage(named: "piclist.png")
        but2.addSubview(but2image)
        naView.addSubview(but1)
        naView.addSubview(but2)
    }
    
    func tag1(sender:UIButton){
        println("..")
        self.but1.backgroundColor = UIColor.whiteColor()
        self.but2.backgroundColor = UIColor.clearColor()
    }
    func tag2(sender:UIButton){
        println("...")
        self.but2.backgroundColor = UIColor.whiteColor()
        self.but1.backgroundColor = UIColor.clearColor()
    }
    //搜索按钮
    func searchbuttonpress(sender:UIButton){
        println("...")
        println(self.searchField.text)
        var flag1 = -1
        for (var i = 0;i<self.xmarrar.count;i++){
            var xm = self.xmarrar[i] as String
            var xm1 = self.searchField.text as String
            if(xm == xm1){
                flag1 = i;
                self.flag = i
            }
        }
        if(flag1 != -1){
            println(flag)
            addinfomidFunc()
            //给添加上动画效果
            self.midsmallview.frame = CGRect(x:512,y:615,width:0,height:0)
            UIView.animateWithDuration(2, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                self.midsmallview.frame = self.framemid
                }, completion: nil)
        }else{
            let alert = UIAlertView(title: "提示！", message: "没有查找到您所查找的人。", delegate: self, cancelButtonTitle: "好")
            alert.show()
        }
    }
    
    //中部的大VIEW
    func midView2(){
        let midimage = UIImageView(frame: CGRect(x:0,y:0,width:1025,height:550))
        let image3 = UIImage(named: "lansebg.png")
        midimage.image = image3
        midView.addSubview(midimage)
        //        midView.layer.shadowOffset = CGSizeMake(14, 14)
        //        midView.layer.shadowOpacity = 0.8
        //        midView.layer.shadowRadius = 4
        self.view.addSubview(midView)
        //中间三个view的添加方法
        midviewfunc()
    }
    
    //下部VIEW
    func botView3(){
        botView.backgroundColor = UIColor.clearColor()
        botView.layer.cornerRadius = 10
        botView.layer.masksToBounds = true
        self.view.addSubview(botView)
    }
    
    //中部的VIEW中得方法
    func midviewfunc(){
        midsmallview.backgroundColor = color4
        
        midsmallview.alpha = 0.9
        midView.addSubview(midsmallview)
        var swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: "midscrollright:")
        swipeLeftGesture.direction = UISwipeGestureRecognizerDirection.Right
        midsmallview.addGestureRecognizer(swipeLeftGesture)
        var swipeLeftGesture1 = UISwipeGestureRecognizer(target: self, action: "midscrollleft:")
        swipeLeftGesture1.direction = UISwipeGestureRecognizerDirection.Left
        midsmallview.addGestureRecognizer(swipeLeftGesture1)
        //左边的view
        midsmallviewleft.backgroundColor = color4
        smallpicture.image = UIImage(named: "newss.png")
        midsmallviewleft.addSubview(smallpicture)
        midsmallviewleft.alpha = 0.5
        midsmallviewleft.layer.cornerRadius = 20
        midsmallviewleft.layer.shadowOffset = CGSize(width: 4, height: 4)
        midsmallviewleft.layer.shadowOpacity = 1
        midView.addSubview(midsmallviewleft)
        //右边的view
        midsmallviewright.backgroundColor = color4
        smallpicture1.image = UIImage(named: "newss.png")
        midsmallviewright.addSubview(smallpicture1)
        midsmallviewright.alpha = 0.5
        midsmallviewright.layer.cornerRadius = 20
        midsmallviewright.layer.shadowOffset = CGSize(width: 4, height: 4)
        midsmallviewright.layer.shadowOpacity = 1
        //        midsmallviewright.layer.masksToBounds = true
        midView.addSubview(midsmallviewright)
        
    }
    
    //最中间VIEW里面的图片，信息添加方法
    func addinfomidFunc(){
        //先添加label等空间
        var image_big:UIImage?
        self.midsmallview.addSubview(rx_big)
        self.midsmallview.addSubview(ssly_big)
        self.midsmallview.addSubview(sbdw_big)
        self.midsmallview.addSubview(psfz_big)
        self.midsmallview.addSubview(yjsm_big)
        self.midsmallview.addSubview(yjsm_big1)
        self.midsmallview.addSubview(but_big)
        //
        var flag = self.flag
        var nd = self.leftdata[flag] as NSDictionary
        if nd["Fjlj"] == nil{
            image_big = UIImage(named: "seac.png")
            self.imageview_big.image = image_big
        }else
        {
            let picRelative = nd["Fjlj"] as NSString
            if 2==3{
            }else{
                //个人照片地址
                let pic = FjUrl + picRelative
                let imgUrl = NSURL(string: pic)!
                let request:NSURLRequest = NSURLRequest(URL: imgUrl)
                NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response,data,error)->Void in
                    let img = UIImage(data: data)
                    if(data != nil){
                        image_big = img
                        self.imageview_big.image = image_big
                    }else{
                        image_big = UIImage(named: "seac.png")
                        self.imageview_big.image = image_big
                    }
                })
            }
        }
        self.midsmallview.addSubview(imageview_big)
        self.midsmallview.layer.cornerRadius = 20
        //self.midsmallview.layer.masksToBounds = true
        self.midsmallview.layer.shadowOffset = CGSizeMake(11, 11)
        self.midsmallview.layer.shadowOpacity = 1
        self.midsmallview.layer.shadowRadius = 4
        self.imageview_big.layer.cornerRadius = 20
        self.imageview_big.layer.masksToBounds = true
        var xm = nd["Xm_zw"] as String
        var dw = nd["Qymc"] as String
        var ly = nd["Ssly"] as String
        var fz = nd["Pszmc"] as String
        self.rx_big.text = "申报人选 : \(xm)"
        self.rx_big.font = UIFont(name: "Arial-BoldItalicMT", size: 20)
        self.sbdw_big.text = "申报单位 : \(dw)"
        self.ssly_big.text = "所属领域 : \(ly)"
        self.psfz_big.text = "评审组名 : \(fz)"
        self.yjsm_big.text = "意见说明"
        self.yjsm_big1.backgroundColor = UIColor.whiteColor()
        self.yjsm_big1.alpha = 0.7
        self.yjsm_big1.layer.borderWidth = 1
        self.yjsm_big1.layer.cornerRadius = 10
        //建议通过
        self.yjsm_big1.text = ""
        self.yjsm_big1.textAlignment = NSTextAlignment.Natural
        self.but_big.layer.cornerRadius = 10
        self.but_big.layer.masksToBounds = true
        self.but_big.titleLabel?.font = UIFont(name: "Arial-BoldItalicMT", size: 20)
        self.but_big.setTitle("查看申报书", forState: UIControlState.Normal)
        self.but_big.backgroundColor = UIColor(red: 97/255, green: 181/255, blue: 248/255, alpha: 1)
        self.but_big.addTarget(self, action: "pressme:", forControlEvents: UIControlEvents.TouchUpInside)
        //
        self.savebtn.setTitle("保存", forState: UIControlState.Normal)
        self.savebtn.backgroundColor = UIColor(red: 97/255, green: 181/255, blue: 248/255, alpha: 1)
        self.savebtn.layer.cornerRadius = 10
        self.savebtn.titleLabel?.font = UIFont(name: "Arial-BoldItalicMT", size: 20)
        midsmallview.addSubview(savebtn)
        self.commitbtn.setTitle("提交", forState: UIControlState.Normal)
        self.commitbtn.backgroundColor = UIColor(red: 97/255, green: 181/255, blue: 248/255, alpha: 1)
        self.commitbtn.layer.cornerRadius = 10
        self.commitbtn.titleLabel?.font = UIFont(name: "Arial-BoldItalicMT", size: 20)
        midsmallview.addSubview(commitbtn)
        self.savebtn.addTarget(self, action: "savecommitpress:", forControlEvents: UIControlEvents.TouchUpInside)
        self.commitbtn.addTarget(self, action: "savecommitpress:", forControlEvents: UIControlEvents.TouchUpInside)
        
    }
    
    func savecommitpress(sender:UIButton){
        let alert = UIAlertView(title: "保存成功", message: "保存成功，请点击关闭此窗口", delegate: self, cancelButtonTitle: "好")
        alert.show()
    }
    
    //查看申报书按钮点击事件
    func pressme(sender:UIButton){
        //添加一个后退的按钮
        var butGoback = UIButton(frame: CGRect(x:10,y:130,width:100,height:30))
        butGoback.setTitle("Back", forState: UIControlState.Normal)
        butGoback.backgroundColor = UIColor.blueColor()
        butGoback.layer.cornerRadius = 10
        butGoback.alpha = 0.2
        //退出按钮
        sbsview.addSubview(butGoback)
        var butGoback1 = UIButton(frame: CGRect(x:914,y:130,width:100,height:30))
        butGoback1.setTitle("Exit", forState: UIControlState.Normal)
        butGoback1.backgroundColor = UIColor.blueColor()
        butGoback1.layer.cornerRadius = 10
        butGoback1.alpha = 0.2
        sbsview.addSubview(butGoback1)
        //前进按钮
        var butGoback2 = UIButton(frame: CGRect(x:10,y:175,width:100,height:30))
        butGoback2.setTitle("Forward", forState: UIControlState.Normal)
        butGoback2.backgroundColor = UIColor.blueColor()
        butGoback2.layer.cornerRadius = 10
        butGoback2.alpha = 0.2
        sbsview.addSubview(butGoback2)
        
        butGoback.addTarget(self, action: "gabackmethod:", forControlEvents: UIControlEvents.TouchUpInside)
        butGoback1.addTarget(self, action: "goextibut:", forControlEvents: UIControlEvents.TouchUpInside)
        butGoback2.addTarget(self, action: "gabackmethod1:", forControlEvents: UIControlEvents.TouchUpInside)
        
        println("....pressme....")
        var alert = UIAlertView(title: "申报书查看", message: "没有申报书可以查看", delegate: self, cancelButtonTitle: "好")
        //alert.show()
        //将隐藏的webiview显示出来
        UIView.animateWithDuration(2, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            var frame = CGRect(x:0,y:0,width:1024,height:768)
            self.sbsview.frame = frame
            self.sbsview.alpha = 1
            }, completion: nil)
    }
    //后退按钮
    func gabackmethod(sender:UIButton){
        self.sbsview.goBack()
        println("goback")
    }
    //前进按钮
    func gabackmethod1(sender:UIButton){
        self.sbsview.goForward()
        println("goForward")
    }
    //关闭按钮
    func goextibut(sender:UIButton){
        println("exit")
        UIView.animateWithDuration(2, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            var frame = CGRect(x:768,y:1024,width:1024,height:768)
            self.sbsview.frame = frame
            self.sbsview.alpha = 1
            }, completion: nil)
    }
    func midscrollright(sender:UISwipeGestureRecognizer){
        println(".right.")
        //先把右边的IVEW隐藏在最左边
        self.midsmallviewright.alpha = 0
        self.midsmallviewright.frame.origin.x = -200
        self.midsmallviewright.frame.origin.y = 80
        self.midsmallviewright.frame.size.width = 200
        self.midsmallviewright.frame.size.height = 250
        UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping:0.5, initialSpringVelocity:0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            //中间的滚动到右边
            self.midsmallview.backgroundColor = self.color4
            self.midsmallview.frame.origin.x = 924
            self.midsmallview.frame.origin.y = 80
            self.midsmallview.frame.size.width = 200
            self.midsmallview.frame.size.height = 250
            //左边的滚动到中间
            self.midsmallviewleft.backgroundColor = self.color4
            self.midsmallviewleft.frame.origin.x = 150
            self.midsmallviewleft.frame.origin.y = 30
            self.midsmallviewleft.frame.size.width = 724
            self.midsmallviewleft.frame.size.height = 500
            //右边的直接隐藏
            self.midsmallviewright.alpha = 1
            //self.midsmallviewright.backgroundColor = UIColor.grayColor()
            self.midsmallviewright.frame.origin.x = -100
            self.midsmallviewright.frame.origin.y = 80
            self.midsmallviewright.frame.size.width = 200
            self.midsmallviewright.frame.size.height = 250
            }, completion: nil)
        //在还原到原来的位置，但是不要被发现
        self.midsmallview.frame = framemid
        self.midsmallviewleft.frame = frameleft
        self.midsmallviewright.frame = frameright
        if(self.flag == 0){
            self.flag = 0
        }else{
            self.flag--
        }
        addinfomidFunc()
    }
    
    func midscrollleft(sender:UISwipeGestureRecognizer){
        println(".left.")
        //先把左边的IVEW隐藏在最左边
        self.midsmallviewleft.alpha = 0
        self.midsmallviewleft.frame.origin.x = 1024
        self.midsmallviewleft.frame.origin.y = 80
        self.midsmallviewleft.frame.size.width = 200
        self.midsmallviewleft.frame.size.height = 250
        UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping:0.5, initialSpringVelocity:0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            //中间的滚动到左边
            //self.midsmallview.backgroundColor = UIColor.grayColor()
            self.midsmallview.frame.origin.x = -100
            self.midsmallview.frame.origin.y = 80
            self.midsmallview.frame.size.width = 200
            self.midsmallview.frame.size.height = 250
            //由边的滚动到中间
            //self.midsmallviewright.backgroundColor = UIColor.grayColor()
            self.midsmallviewright.frame.origin.x = 150
            self.midsmallviewright.frame.origin.y = 30
            self.midsmallviewright.frame.size.width = 724
            self.midsmallviewright.frame.size.height = 500
            //左边的直接隐藏
            self.midsmallviewleft.alpha = 1
            //self.midsmallviewleft.backgroundColor = UIColor.grayColor()
            self.midsmallviewleft.frame.origin.x = 924
            self.midsmallviewleft.frame.origin.y = 80
            self.midsmallviewleft.frame.size.width = 200
            self.midsmallviewleft.frame.size.height = 250
            }, completion: nil)
        self.midsmallview.frame = framemid
        self.midsmallviewleft.frame = frameleft
        self.midsmallviewright.frame = frameright
        if(self.flag == self.leftdata.count-1){
            self.flag = self.leftdata.count-1
        }else{
            self.flag++
        }
        addinfomidFunc()
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
            var imageview5 = UIImageView(frame: CGRect(x:0,y:0,width:140,height:130))
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
            xmlabel.text = rowdata["Xm_zw"] as? String
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
            
            var str = FjUrl+(rowdata["Fjlj"] as String)
            var url = NSURL(fileURLWithPath: str)
            if rowdata["Fjlj"] == nil{
            }else
            {
                let picRelative = rowdata["Fjlj"] as NSString
                if 2==3{
                }else{
                    //个人照片地址
                    let pic = FjUrl + picRelative
                    let imgUrl = NSURL(string: pic)!
                    let request:NSURLRequest = NSURLRequest(URL: imgUrl)
                    NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response,data,error)->Void in
                        let img = UIImage(data: data)
                        if(data != nil){
                            imageview5.image = img
                        }
                    })
                }
            }
        }
        //添加内容
        scrollview.contentSize = CGSize(width: 160*count, height: 133)
        scrollview.scrollEnabled = true
        self.botView.addSubview(scrollview)
    }
    
    //图片上按钮点击事件（需要执行动画)
    func pressmeaction(sender:UIButton){
        var tag = sender.tag
        println(tag)
        flag = tag
        addinfomidFunc()
        //给添加上动画效果
        self.midsmallview.frame = CGRect(x:512,y:615,width:0,height:0)
        UIView.animateWithDuration(2, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.midsmallview.frame = self.framemid
            }, completion: nil)
    }
    
    //界面控制流程————开启异步执行方法（线程打印no字符串）一直到死
//    func thread2()->Void{
//        
//        var time:UInt32 = 0
//        if(mmm3==0){
//            time = 3
//        }else{
//            time = 9
//        }
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
//            //这里写需要大量时间的代码
//            for var i = 0; i < 500; i--
//            {
//                sleep(time);
//                println("no")
//                if(i == -3){
//                    println("检测到已经打分完毕，所以循环结束。如果从别的界面跳转回本页面此线程将重新执行。")
//                    break
//                }
//            }
//            //返回主线程跳转才可以成功（提示也只有在主线程中才会成功）
//            dispatch_async(dispatch_get_main_queue(), {
//                println("这里返回主线程，写需要主线程执行的代码")
//                var al = UIAlertView(title: "自动跳转", message: "监听线程检测到打分过程已经结束，自动跳转到投票界面", delegate: self, cancelButtonTitle: "好")
//                al.show()
//                let controller = votecontroller()
//                self.govote()
//            })
//        })
//    }
//    func govote()->Void{
//        var con = votecontroller()
//        con.backv = self
//        self.presentViewController(con, animated: true) { () -> Void in
//            println("goforit...")
//        }
//    }
    func backvalue1(stringms:Int){
        back = stringms
        println(back)
    }
    
    
    //查看申报书的WEBVIEW
    func sbswebView(){
        var sbsid = self.flag
        sbsview.alpha = 0.1
        var url = HWZPUrl + "CySbs/CySbs.aspx?Sbbh=3925ba20-5bc9-4962-a7b9-d4235bf528eb"
        var nsrul:NSURL = NSURL(string: url)!
        var request = NSURLRequest(URL: nsrul)
        sbsview.loadRequest(request)
        self.view.addSubview(sbsview)
        //向右滑动是隐藏整个SBSVIEW
        var swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: "webviewscroll:")
        swipeLeftGesture.direction = UISwipeGestureRecognizerDirection.Right
        sbsview.addGestureRecognizer(swipeLeftGesture)
        //向左滑动是为了退回到上一步
        var tag = UISwipeGestureRecognizer(target: self, action: "webviewgoback:")
        tag.direction = UISwipeGestureRecognizerDirection.Left
        sbsview.addGestureRecognizer(tag)
    }
    //隐藏申报书view的滑动时间
    func webviewscroll(sender:UISwipeGestureRecognizer){
        println("huadong")
        UIView.animateWithDuration(2, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            var frame = CGRect(x:1025,y:768,width:0,height:0)
            self.sbsview.frame = frame
            }, completion: nil)
    }
    //点击申报书（双击)后退的事件
    func webviewgoback(sender:UITapGestureRecognizer){
        println("....goback....")
        self.sbsview.goBack()
        
    }
    
    //today extension text
//    func todayText(){
//        //引入的FRAMEWORK
//        var tar = textOne()
//        tar.shan2()
//        println(tar.shan)
//        let userdefault = NSUserDefaults(suiteName: "group.com.yiyun.seenow")
//        userdefault?.setObject("shan", forKey: "xing")
//        userdefault?.setObject(tar.shan, forKey: "ming")
//        //立即写入到磁盘（一定时间段内写入磁盘，所以防止未保存，手动写入磁盘）
//        userdefault?.synchronize()
//    }
    
    
    
}
