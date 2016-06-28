//
//  NetworkManager.swift
//  Mail Inbox
//
//  Created by Mohammed on 6/26/16.
//  Copyright © 2016 Good News 4 Me. All rights reserved.
//

import Foundation
import ReachabilitySwift
import ObjectMapper
import Alamofire
import AlamofireSwiftyJSON
import SystemConfiguration
import CoreData

class NetworkManager {
    
    var viewDelegate : InboxViewDelegate!
    let serviceURL = "https://api.myjson.com/bins/xo2m"
    
    
    func fetchAllEmails() {
        Alamofire.request(.GET, serviceURL).responseJSON { (response) in
            switch response.result{
            case .Success(let json):
                var emailsList = Array<Email>()
                let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
                let entity = NSEntityDescription.entityForName("Email", inManagedObjectContext: managedObjectContext)!
                for email in json as! [NSDictionary] {
                    print(email)
                    let emailObj = Email(entity: entity, insertIntoManagedObjectContext: managedObjectContext)
                    emailObj.from = email.valueForKey("From") as? String
                    emailObj.content = email.valueForKey("Content") as? String
                    emailObj.header = email.valueForKey("Header") as? String
                    emailObj.time = email.valueForKey("Time") as? String
                    emailObj.isRead = false
                    emailsList.append(emailObj)
                }
                dispatch_async(dispatch_get_main_queue(), { 
                    self.viewDelegate.reloadEmailsWith(emailsList)
                })
                break
            case .Failure(let error):
                print(error)
                break
            }
        }
    }
    
    func checkReachapility() {
        let url = NSURL(string: "https://google.com/")
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "HEAD"
        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringLocalAndRemoteCacheData
        request.timeoutInterval = 10.0
        
        NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data:NSData?, response:NSURLResponse?, error:NSError?) in
            if let httpResponse = response as? NSHTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    self.viewDelegate.isConnected(true)
                    print("You are connected")
                }
            } else {
                self.viewDelegate.isConnected(false)
            }
        }).resume()
        
    }
}