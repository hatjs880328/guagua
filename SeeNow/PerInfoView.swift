//
//  PerInfoView.swift
//  SeeNow
//
//  Created by apple on 14/12/23.
//  Copyright (c) 2014年 apple. All rights reserved.
//

import UIKit


class PerInfoView: UIView {
    
    var labelName = UILabel(frame: CGRectMake(40, 200, 100, 25))
    
    override func awakeFromNib() {
        self.backgroundColor = UIColor.whiteColor()
        self.addSubview(labelName)
        labelName.text = "asdfadsfasfa"
    }
    
//    override func addSubview(view: UIView) {
//        labelName.text = "zhesfsdfsd"
//        self.addSubview(labelName)
//    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
