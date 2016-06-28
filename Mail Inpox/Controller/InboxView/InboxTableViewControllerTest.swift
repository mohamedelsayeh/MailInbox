//
//  InboxTableViewControllerTest.swift
//  Mail Inbox
//
//  Created by Mohammed on 6/27/16.
//  Copyright © 2016 Good News 4 Me. All rights reserved.
//

import UIKit
import XCTest


class InboxTableViewControllerTest: XCTestCase {
    
    var inboxTableViewController : InboxTableViewController!
    
    override func setUp() {
        super.setUp()
        
        inboxTableViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("inboxView") as! InboxTableViewController
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
