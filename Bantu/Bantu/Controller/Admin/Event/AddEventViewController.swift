//
//  AddEventViewController.swift
//  Bantu
//
//  Created by Resky Javieri on 12/10/18.
//  Copyright © 2018 Resky Javieri. All rights reserved.
//

import UIKit

class AddEventViewController: UIViewController {

    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var eventTitleTextField: UITextField!
    @IBOutlet weak var schoolTitleTextField: UITextField!
    @IBOutlet weak var aboutEventTextView: UITextView!
    @IBOutlet weak var startDateTextField: UITextField!
    @IBOutlet weak var endDateTextField: UITextField!
    @IBOutlet weak var volunteerTextField: UITextField!
    
    @IBOutlet weak var postEventButton: UIButton!
    let datePicker = UIDatePicker()
    
    var acceptedPosts: [Post] = []
    
    var selectedPost: Post?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createDateToolbar()
        createDatePicker()
        
        createSchoolPicker()
        createSchoolToolbar()
        
        self.postEventButton.buttonDesign()

    
        self.acceptedPosts = GlobalSession.submissions.filter({$0.statusName == "Accepted"})
    }
    
    func createDatePicker() {
        startDateTextField.inputView = datePicker
        endDateTextField.inputView = datePicker
        datePicker.datePickerMode = .date
    }
    
    func createSchoolPicker() {
        let schoolPicker = UIPickerView()
        schoolPicker.delegate = self
        schoolTitleTextField.inputView = schoolPicker
    }
    
    func createSchoolToolbar() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismissKeyboards))
        
        toolbar.setItems([doneButton], animated: true)
        toolbar.isUserInteractionEnabled = true
        schoolTitleTextField.inputAccessoryView = toolbar
    }
    
    @objc func dismissKeyboards() {
        view.endEditing(true)
    }
    
    
    func createDateToolbar() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismissKeyboard))
        
        toolbar.setItems([doneButton], animated: true)
        toolbar.isUserInteractionEnabled = true
        startDateTextField.inputAccessoryView = toolbar
        endDateTextField.inputAccessoryView = toolbar
    }
    
    @objc func dismissKeyboard() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        startDateTextField.text = dateFormatter.string(from: datePicker.date)
        startDateTextField.text = dateFormatter.string(from: datePicker.date)
        view.endEditing(true)
    }
}

extension AddEventViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.acceptedPosts.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.acceptedPosts[row].schoolName
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedPost = self.acceptedPosts[row]
        schoolTitleTextField.text = selectedPost?.schoolName
    }
    
    
}
