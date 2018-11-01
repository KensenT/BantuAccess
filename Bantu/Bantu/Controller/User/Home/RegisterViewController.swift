//
//  RegisterViewController.swift
//  Bantu
//
//  Created by Resky Javieri on 08/10/18.
//  Copyright © 2018 Resky Javieri. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    //MARK: Outlet UILabel
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var lastEducationLabel: UILabel!
    @IBOutlet weak var homeAddressLabel: UILabel!
    @IBOutlet weak var medicalRecordLabel: UILabel!
    @IBOutlet weak var reasonToJoinLabel: UILabel!
    
    
    //MARK: Outlet UITextField
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var lastEducationTextField: UITextField!
    @IBOutlet weak var homeAddressTextField: UITextField!
    @IBOutlet weak var medicalRecordTextField: UITextField!
    @IBOutlet weak var reasonToJoinTextField: UITextField!
    
    
    //MARK: Outlet UIButton
    @IBOutlet weak var applyButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.applyButton.buttonDesign()
        
        self.setAllDynamicUILabel()
        self.setallDynamicUITextField()

    }
    
    
    func setAllDynamicUILabel() {
        self.fullNameLabel.setDynamic(fontFamily: "Helvetica", size: 14, style: "bold", type: .subheadline)
        self.phoneNumberLabel.setDynamic(fontFamily: "Helvetica", size: 14, style: "bold", type: .subheadline)
        self.lastEducationLabel.setDynamic(fontFamily: "Helvetica", size: 14, style: "bold", type: .subheadline)
        self.homeAddressLabel.setDynamic(fontFamily: "Helvetica", size: 14, style: "bold", type: .subheadline)
        self.medicalRecordLabel.setDynamic(fontFamily: "Helvetica", size: 14, style: "bold", type: .subheadline)
        self.reasonToJoinLabel.setDynamic(fontFamily: "Helvetica", size: 14, style: "bold", type: .subheadline)
    }
    
    
    func setallDynamicUITextField() {
        self.fullNameTextField.setDynamic(fontFamily: "Helvetica", size: 14, style: "", type: .body)
        self.phoneNumberTextField.setDynamic(fontFamily: "Helvetica", size: 14, style: "", type: .body)
        self.lastEducationTextField.setDynamic(fontFamily: "Helvetica", size: 14, style: "", type: .body)
        self.homeAddressTextField.setDynamic(fontFamily: "Helvetica", size: 14, style: "", type: .body)
        self.medicalRecordTextField.setDynamic(fontFamily: "Helvetica", size: 14, style: "", type: .body)
        self.reasonToJoinTextField.setDynamic(fontFamily: "Helvetica", size: 14, style: "", type: .body)
    }
}
