import UIKit

protocol HttpProtocol{
    func didReceiveResult(result:NSDictionary)
}

class HttpController: NSObject {
    var delegate:HttpProtocol?
    func onSearch(url:NSString){
        
        var NSUrl:NSURL = NSURL(string: url)!
        var request:NSURLRequest = NSURLRequest(URL: NSUrl)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response,data,error)->Void in
            var jsonData = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
            self.delegate?.didReceiveResult(jsonData)
        })
    }
}