//
//  AddDraftViewController.swift
//  Bantu
//
//  Created by Resky Javieri on 08/10/18.
//  Copyright © 2018 Resky Javieri. All rights reserved.
//

import UIKit

class AddDraftViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var schoolNameTextField: UITextField!
    @IBOutlet weak var aboutTextView: UITextView!
    @IBOutlet weak var needsLabel: UILabel!
    @IBOutlet weak var needsHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var postButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.postButton.buttonDesign()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Simpan", style: .plain, target: self, action: #selector(saveButtonTapped))
        
        addTextFieldPadding(to: schoolNameTextField)
        
        
    }
    
    @objc func saveButtonTapped() {
        
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let fixedWidth = textView.frame.size.width
        textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        let newSize = textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        var newFrame = textView.frame
        newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
        textView.frame = newFrame
        
        needsLabel.topAnchor.constraint(equalTo: aboutTextView.bottomAnchor).isActive = true
    }

    
    
    func addTextFieldPadding(to textfield: UITextField) {
        let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 20, height: 2.0))
        textfield.leftView = leftView
        textfield.leftViewMode = .always
    }
    

}

