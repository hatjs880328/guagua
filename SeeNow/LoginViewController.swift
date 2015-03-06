

import UIKit
import Foundation
var userid = ""
var zjidnew = ""
class LoginViewController: UIViewController,UITextFieldDelegate ,HttpProtocol{
    
    var FzList:NSArray?
    
    var eHttp:HttpController = HttpController()
    
    let txtUserName:UITextField = UITextField()
    let txtPassWord:UITextField = UITextField()
    @IBAction func btnLogin(sender: AnyObject) {
        println("...")
        let UserName = txtUserName.text
        let Pwd = txtPassWord.text
        if(UserName != ""&&Pwd != ""){
            eHttp.delegate = self
            //登陆
            var httpLogin = getall+"which=jiemi&yhm=\(UserName)&mm=\(Pwd)"
            eHttp.onSearch(httpLogin)
           
        }else{
            let stoploadConfirm = UIAlertView(title: "警告", message: "用户名或密码不能为空", delegate: self, cancelButtonTitle: "好的")
            stoploadConfirm.show()
        }
       
    }
    //接收返回的数据
    func didReceiveResult(result: NSDictionary) {
        println(result)
        if(result.allKeys[0] as String == "FzList"){
            
        }else if(result.allKeys[0] as String == "customer1"){
            //println(result["customer"])
            if result["customer"] as NSObject != 0{
                //登陆成功
                userid = result["customer"] as NSString
                zjidnew = result["customer1"] as NSString
                println(zjidnew)
                var MyStoryBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                var twoController = MyStoryBoard.instantiateViewControllerWithIdentifier("CyList") as ListViewController
                self.presentViewController(twoController, animated: true, completion: nil)
            }else{
                //登录失败
                let stoploadConfirm = UIAlertView(title: "警告", message: "用户名或密码不正确", delegate: self, cancelButtonTitle: "好的")
                stoploadConfirm.show()            }
            
        }else if(result.allKeys[0] as String == "error"){
            let stoploadConfirm = UIAlertView(title: "警告", message: "用户名或密码不正确", delegate: self, cancelButtonTitle: "好的")
            stoploadConfirm.show()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
         eHttp.delegate = self
        //获取分组数据
//        let FzUrl = GetService + "which=FzList"
//        dispatch_async(dispatch_get_main_queue(), {self.eHttp.onSearch(FzUrl)})

        let BackGroundImage = UIImage(named: "LoginImageH4.jpg")!
        self.view.backgroundColor = UIColor(patternImage: BackGroundImage)
        //用户名
         txtUserName.frame = CGRectMake(386, 290, 252, 55)
        txtUserName.background = UIImage(named: "inputbox.png")
        txtUserName.delegate = self
        txtUserName.borderStyle = UITextBorderStyle.None
        let imageName = UIImageView(image: UIImage(named: "people2.png"))
        txtUserName.leftView = imageName
        txtUserName.leftViewMode = UITextFieldViewMode.Always
        self.view.addSubview(txtUserName)
        //密码
        txtPassWord.frame = CGRectMake(386, 364, 252, 55)
        txtPassWord.background = UIImage(named: "inputbox.png")
        txtPassWord.delegate = self
        txtPassWord.borderStyle = UITextBorderStyle.None
        txtPassWord.secureTextEntry = true
        let imagePwd = UIImageView(image: UIImage(named: "key2.png"))
        txtPassWord.leftView = imagePwd
        txtPassWord.leftViewMode = UITextFieldViewMode.Always
        self.view.addSubview(txtPassWord)
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
