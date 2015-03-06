//
//  jnwspringController.swift
//  SeeNow
//
//  Created by apple on 15/1/16.
//  Copyright (c) 2015年 apple. All rights reserved.
//

import UIKit

class jnwspringController: UIViewController {

    let frameview = UIView(frame: CGRectMake(0, 100, 100, 100))
    override func viewDidLoad() {
        super.viewDidLoad()
        self.frameview.backgroundColor = UIColor.redColor()
        self.view.addSubview(frameview)
        //旋转
        let scale = JNWSpringAnimation(keyPath: "transform.rotation")
        scale.mass = 5
        scale.damping = 15
        scale.stiffness = 100
        scale.fromValue = 0
        scale.toValue = M_PI_2
        frameview.layer.addAnimation(scale, forKey: scale.keyPath)
        frameview.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_2))
        //  移动
        let scale2 = JNWSpringAnimation(keyPath: "transform.translation")
        scale2.mass = 5
        scale2.damping = 10
        scale2.stiffness = 60
        scale2.fromValue = 0
        scale2.toValue = 250
        frameview.layer.addAnimation(scale2, forKey: scale2.keyPath)
        frameview.transform = CGAffineTransformMakeTranslation(250, 250)
        
        //变化（放大缩小）
        let scale3 = JNWSpringAnimation(keyPath: "transform.scale")
        scale3.mass = 6
        scale3.stiffness = 50
        scale3.damping = 33
        scale3.fromValue = 1
        scale3.toValue = 3
        frameview.layer.addAnimation(scale3, forKey: scale3.keyPath)
        frameview.transform = CGAffineTransformMakeScale(3,3)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
