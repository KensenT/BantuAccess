//
//  EventDetailMoreViewController.swift
//  Bantu
//
//  Created by Resky Javieri on 17/10/18.
//  Copyright © 2018 Resky Javieri. All rights reserved.
//

import UIKit

class EventDetailMoreViewController: UIViewController {

    //MARK: Outlet Label
    @IBOutlet weak var aboutEventLabel: UILabel!
    @IBOutlet weak var includeLabel: UILabel!
    @IBOutlet weak var requirementLabel: UILabel!
    @IBOutlet weak var additionalInformationLabel: UILabel!
    @IBOutlet weak var contactPersonLabel: UILabel!
    
    //MARK: Outlet TextView
    @IBOutlet weak var aboutTextView: UITextView!
    @IBOutlet weak var includeTextView: UITextView!
    @IBOutlet weak var requirementTextView: UITextView!
    @IBOutlet weak var contactPerson: UITextView!
    @IBOutlet weak var additionalInfoTextView: UITextView!
    
    var currentEvent: Event!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setUp()
        
        self.setAllDynamicUILabel()
        self.setAllDynamicTextView()
    }
    
    
    func setAllDynamicUILabel() {
        
        self.aboutEventLabel.setDynamic(fontFamily: "Helvetica", size: 12, style: "bold", type: .subheadline)
        self.includeLabel.setDynamic(fontFamily: "Helvetica", size: 12, style: "bold", type: .subheadline)
        self.requirementLabel.setDynamic(fontFamily: "Helvetica", size: 12, style: "bold", type: .subheadline)
        self.additionalInformationLabel.setDynamic(fontFamily: "Helvetica", size: 12, style: "bold", type: .subheadline)
        self.contactPersonLabel.setDynamic(fontFamily: "Helvetica", size: 12, style: "bold", type: .subheadline)
        
    }
    
    func setAllDynamicTextView() {
        
        self.aboutTextView.setDynamic(fontFamily: "Helvetica", size: 12, style: "", type: .body)
        self.includeTextView.setDynamic(fontFamily: "Helvetica", size: 12, style: "", type: .body)
        self.requirementTextView.setDynamic(fontFamily: "Helvetica", size: 12, style: "", type: .body)
        self.contactPerson.setDynamic(fontFamily: "Helvetica", size: 12, style: "", type: .body)
        self.additionalInfoTextView.setDynamic(fontFamily: "Helvetica", size: 12, style: "", type: .body)
    }
    
    
    func setUp(){
        self.aboutTextView.text = self.currentEvent.description
        self.includeTextView.text = self.currentEvent.feeInfo
        self.requirementTextView.text = self.currentEvent.requirements
        self.contactPerson.text = self.currentEvent.contactPerson
        self.additionalInfoTextView.text = self.currentEvent.eventNotes
    }

}
