
import UIKit
//接收数据的路径
var GetService = "http://123.232.119.125:8081/HWZP/GetHandler.ashx?"
//返回数据的路径
var SetService = "http://123.232.119.125:8081/HWZP/SetHandler.ashx?"
//总评地址
var HWZPUrl:NSString = "http://123.232.119.125:8081/hwtpzp/"
//附件地址
var FjUrl:NSString = "http://123.232.119.125:8081/file/"

//登陆账号信息（dic）
var loginInfo:NSDictionary?

var getall = "http://172.16.10.23:8044/gethandler.ashx?"
//申报书地址
var sbsurl = "http://172.16.10.23/hyps/frames/projectsview/"