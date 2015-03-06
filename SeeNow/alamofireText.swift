//
//  alamofireText.swift
//  SeeNow
//
//  Created by apple on 15/1/27.
//  Copyright (c) 2015年 apple. All rights reserved.
//

import UIKit
import Alamofire
class alamofireText: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let Parameters = [
            "mparams":"{\"CurrPage\":\"1\",\"PageSize\":\"5\",\"CT_nParentID\":308,\"KeyWords\":\"政府\",\"NoKeyWords\":\"好人998\"}"
        ]
        Alamofire.request(.POST,
            "http://qlgg.net:8888/PhoneAPI/PhoneAPI.asmx/FindAdDocumentByConditions",
            parameters: Parameters)
            .responseString{(request,response,string,error) in
                println(string!)
                println("....g'.....")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
