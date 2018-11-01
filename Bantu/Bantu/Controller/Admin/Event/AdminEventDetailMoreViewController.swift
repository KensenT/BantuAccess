//
//  AdminEventDetailMoreViewController.swift
//  Bantu
//
//  Created by Resky Javieri on 17/10/18.
//  Copyright © 2018 Resky Javieri. All rights reserved.
//

import UIKit

class AdminEventDetailMoreViewController: UIViewController {

    @IBOutlet weak var aboutTextView: UITextView!
    @IBOutlet weak var includeTextView: UITextView!
    @IBOutlet weak var requirementTextView: UITextView!
    @IBOutlet weak var contactPerson: UITextView!
    @IBOutlet weak var additionalInfoTextView: UITextView!
    
    var currentEvent: Event!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setUp()
    }
    
    func setUp(){
        self.aboutTextView.text = self.currentEvent.description
        self.includeTextView.text = self.currentEvent.feeInfo
        self.requirementTextView.text = self.currentEvent.requirements
        self.contactPerson.text = self.currentEvent.contactPerson
        self.additionalInfoTextView.text = self.currentEvent.eventNotes
    }
    

    

}
