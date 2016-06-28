//
//  EmailDetailsViewController.swift
//  Mail Inbox
//
//  Created by Mohammed on 6/26/16.
//  Copyright © 2016 Good News 4 Me. All rights reserved.
//

import UIKit

class EmailDetailsViewController: UIViewController {

    @IBOutlet weak var lblFrom: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblContent: UITextView!
    
    var email : Email!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = email.from
        lblFrom.text = email.from
        lblTime.text = email.time
        lblContent.text = email.content
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
