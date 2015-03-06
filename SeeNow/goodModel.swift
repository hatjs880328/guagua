//
//  goodModel.swift
//  SeeNow
//
//  Created by apple on 15/2/9.
//  Copyright (c) 2015年 apple. All rights reserved.
//

import Foundation


class goodModel{
    var goodid:Int = 0
    var goodName:String = ""
    var goodpicurl:String = ""
    
    func setModel(goodid:Int,goodname:String,goodpicurl:String){
        self.goodid = goodid
        self.goodName = goodname
        self.goodpicurl = goodpicurl
    }
}
