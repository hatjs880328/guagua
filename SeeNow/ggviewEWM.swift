//
//  ggviewEWM.swift
//  SeeNow
//
//  Created by apple on 15/2/3.
//  Copyright (c) 2015年 apple. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation

class ggviewEWM: UIViewController,AVCaptureMetadataOutputObjectsDelegate {

    let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
    let session = AVCaptureSession()
    var layer: AVCaptureVideoPreviewLayer?
    var bgcolorall = UIColor(red: 189/255, green: 231/255, blue: 254/255, alpha: 1)
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.clearColor()
//        let imageView = UIImageView(frame:CGRectMake(0, 0, 100, 100))
//        imageView.image = UIImage(named:"")
//        self.view.addSubview(imageView)
        let but = UIButton(frame: CGRectMake(0, 100, 100, 30))
        but.backgroundColor = bgcolorall
        but.addTarget(self, action: "goback:", forControlEvents: UIControlEvents.TouchUpInside)
        but.setTitle("返回首页", forState: UIControlState.Normal)
        but.layer.cornerRadius = 10
        self.view.addSubview(but)
    }
    
    func goback(sender:UIButton){
        var con = ggview()
        self.presentViewController(con, animated: false, completion: nil)
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
        layer!.frame = CGRectMake(self.view.bounds.width/2-100,self.view.bounds.height/2-100,200,200);
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
        alertView.show()
        var mmm = stringValue!
        var xm = (mmm as NSString).substringToIndex(8)
        var pwd  = (mmm as NSString).substringFromIndex(9)
        setupCamera()
    }
    
}
