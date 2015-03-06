//
//  LoginNew.swift
//  SeeNow
//
//  Created by apple on 15/1/15.
//  Copyright (c) 2015年 apple. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation

class LoginNew: UIViewController , AVCaptureMetadataOutputObjectsDelegate  {

    
    let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
    let session = AVCaptureSession()
    var layer: AVCaptureVideoPreviewLayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "login3.png")!)
        let imageView = UIImageView(frame:CGRectMake(384, 365, 260, 260))
        imageView.image = UIImage(named:"pick_bg")
        self.view.addSubview(imageView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    //摄像头方法
    func setupCamera(){
        self.session.sessionPreset = AVCaptureSessionPresetHigh
        var error : NSError?
        let input = AVCaptureDeviceInput(device: device, error: &error)
        if (error != nil) {
            println(error?.description)
            return
        }
        if session.canAddInput(input) {
            session.addInput(input)
        }
        layer = AVCaptureVideoPreviewLayer(session: session)
        layer!.videoGravity = AVLayerVideoGravityResizeAspectFill
        layer!.frame = CGRectMake(384,365,260,260);
        self.view.layer.insertSublayer(self.layer, atIndex: 0)
        let output = AVCaptureMetadataOutput()
        output.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
        if session.canAddOutput(output) {
            session.addOutput(output)
            output.metadataObjectTypes = [AVMetadataObjectTypeQRCode];
        }
        session.startRunning()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.setupCamera()
        self.session.startRunning()
    }
    //二维码方法
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!){
        var stringValue:String?
        if metadataObjects.count > 0 {
            var metadataObject = metadataObjects[0] as AVMetadataMachineReadableCodeObject
            stringValue = metadataObject.stringValue
        }
        self.session.stopRunning()
        println("code is \(stringValue)")
        var alertView = UIAlertView()
        alertView.delegate=self
        alertView.title = "二维码"
        alertView.message = "扫到的二维码内容为:\(stringValue)"
        alertView.addButtonWithTitle("确认")
        //alertView.show()
        var mmm = stringValue!
        var xm = (mmm as NSString).substringToIndex(8)
        println(xm)
        var pwd  = (mmm as NSString).substringFromIndex(9)
        println(pwd)
        
//        var httpLogin = getall+"which=jiemi&yhm=\(xm)&mm=\(pwd)"
//        let NSUrl:NSURL = NSURL(string: httpLogin)!
//        let request:NSURLRequest = NSURLRequest(URL: NSUrl)
//        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response,data,error)->Void in
//            var result = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
//            if(result.allKeys[0] as String == "customer1"){
//                if result["customer"] as NSObject != 0{
//                    //登陆成功
//                    userid = result["customer"] as NSString
//                    zjidnew = result["customer1"] as NSString
//                    println(zjidnew)
//                    var MyStoryBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//                    var twoController = MyStoryBoard.instantiateViewControllerWithIdentifier("CyList") as ListViewController
//                    self.presentViewController(twoController, animated: true, completion: nil)
//                }else{
//                    //登录失败
//                    let stoploadConfirm = UIAlertView(title: "警告", message: "用户名或密码不正确,请确认是否是正确的二维码图片", delegate: self, cancelButtonTitle: "好的")
//                    stoploadConfirm.show()            }
//                
//            }else if(result.allKeys[0] as String == "error"){
//                let stoploadConfirm = UIAlertView(title: "警告", message: "用户名或密码不正确,请确认是否是正确的二维码图片", delegate: self, cancelButtonTitle: "好的")
//                stoploadConfirm.show()
//            }
//
//        })
        if(mmm == "65365367,77427246"){
            
        }else{
            
        }
    }

}
