//
//  ggmap.swift
//  SeeNow
//
//  Created by apple on 15/1/30.
//  Copyright (c) 2015年 apple. All rights reserved.
//

import UIKit

class ggmap: UIViewController,MAMapViewDelegate,AMapSearchDelegate {

    var location:CLLocation?
    override func viewDidLoad() {
        super.viewDidLoad()
        mapinit()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func mapinit(){
        
        MAMapServices.sharedServices().apiKey = "9c481dabdb3748d52f032b519a7efd16"
        var mapview = MAMapView(frame: CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height))
        mapview.delegate = self
        mapview.showsUserLocation = true  // default is closed........
        mapview.setUserTrackingMode(MAUserTrackingModeFollow, animated: true)
        self.view.addSubview(mapview)
        //返回按钮
        var button = UIButton(frame: CGRectMake(0, 0, 100, 50))
        button.backgroundColor = UIColor.redColor()
        button.setTitle("mapback", forState: UIControlState.Normal)
        button.addTarget(self, action: "pressmap:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(button)
        //查找按钮
        var searchbut = UIButton(frame: CGRectMake(100, 0, 100, 50))
        searchbut.backgroundColor = UIColor.yellowColor()
        searchbut.setTitle("search", forState: UIControlState.Normal)
        searchbut.addTarget(self, action: "pressmap1:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(searchbut)
    }
    
    //map anniu按钮
    func pressmap(sender:UIButton){
        var con = ggview()
        self.presentViewController(con, animated: true, completion: nil)
    }
    //search but
    func pressmap1(sender:UIButton){
        println("here")
        var searchser = AMapSearchAPI(searchKey: "9c481dabdb3748d52f032b519a7efd16", delegate: self)
        //searchser.language = AMapSearchLanguage.zh_CN
        
        var amprequest = AMapPlaceSearchRequest()
        amprequest.searchType = AMapSearchType.PlaceKeyword
        amprequest.city = ["济南"]
//        amprequest.keywords = "餐饮"
        
        amprequest.keywords = "李嫂龙虾"
        
        searchser.AMapPlaceSearch(amprequest)
        println("???")
        

    }
    
    func mapView(mapView: MAMapView!, didUpdateUserLocation userLocation: MAUserLocation!, updatingLocation: Bool) {
        if(updatingLocation){
//           println("当前坐标为：\(userLocation.coordinate.latitude),\(userLocation.coordinate.longitude)")
            location = userLocation.location.copy() as? CLLocation
        }
    }
    
    //搜索完毕执行事件
    func onPlaceSearchDone(request: AMapPlaceSearchRequest!, response: AMapPlaceSearchResponse!) {
        if(response.pois.count != 0){
            println("5")
            return
        }
        println(request)
        println(response)
        
        
        
    }

}
