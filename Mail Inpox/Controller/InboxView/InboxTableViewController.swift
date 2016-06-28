//
//  InboxTableViewController.swift
//  Mail Inpox
//
//  Created by Mohammed on 6/26/16.
//  Copyright © 2016 Good News 4 Me. All rights reserved.
//

import UIKit

class InboxTableViewController: UITableViewController, InboxViewDelegate {

    var emailsList : [Email]?
    var emailDbManager : EmailDAO?
    var networkManager : NetworkManager?
    
    var activityIndicator : UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Inbox"
        emailsList = Array<Email>()
        
        activityIndicatorVisibility(true)
        
        networkManager = NetworkManager()
        networkManager?.viewDelegate = self
        networkManager?.checkReachapility()
        
        emailDbManager = EmailDAO(managedObjectContext: (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext)

        //this call will be refered to the call back funcion isConnected() below
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (emailsList?.count)!
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("mailCell", forIndexPath: indexPath)

        // Configure the cell...
        (cell.viewWithTag(10) as! UILabel).text = emailsList![indexPath.row].from
        (cell.viewWithTag(11) as! UILabel).text = emailsList![indexPath.row].header
        (cell.viewWithTag(12) as! UILabel).text = emailsList![indexPath.row].time
        if emailsList![indexPath.row].isRead?.boolValue == true {
            (cell.viewWithTag(13) as! UIImageView).hidden = true
        }
        return cell
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let selectedEmail = emailsList![(tableView.indexPathForSelectedRow?.row)!]
        (segue.destinationViewController as! EmailDetailsViewController).email = selectedEmail
        emailDbManager?.markAsRead(selectedEmail)
        tableView.reloadData()
    }
    
    var isConnectedToInternet : Bool = false
    
    func isConnected(result: Bool) {
        isConnectedToInternet = result
        if isConnectedToInternet {
            networkManager!.fetchAllEmails()
        } else {
            reloadEmailsWith(emailDbManager!.selectAll())
        }
    }
    
    func reloadEmailsWith(emailsList : [Email]) {
        self.emailsList = emailsList
        self.tableView.reloadData()
        //Resave in database if it is just retrieved from the internet
        if isConnectedToInternet {
            emailDbManager?.save(emailsList)
        }
        activityIndicatorVisibility(false)
    }
    
    func activityIndicatorVisibility(visible : Bool) {
        if visible {
            activityIndicator = UIActivityIndicatorView.init(activityIndicatorStyle: .WhiteLarge)
            activityIndicator.center = self.view.center;
            activityIndicator.startAnimating()
            self.view.addSubview(activityIndicator)
        } else {
            activityIndicator.removeFromSuperview()
        }
    }
}
