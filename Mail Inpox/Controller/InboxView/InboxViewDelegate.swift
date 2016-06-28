//
//  InboxViewDelegate.swift
//  Mail Inbox
//
//  Created by Mohammed on 6/26/16.
//  Copyright © 2016 Good News 4 Me. All rights reserved.
//

import Foundation

protocol InboxViewDelegate {
    func isConnected(result : Bool)
    func reloadEmailsWith(emailsList : [Email])
}