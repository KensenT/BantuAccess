//
//  LogViewController.swift
//  Bantu
//
//  Created by Resky Javieri on 10/10/18.
//  Copyright © 2018 Resky Javieri. All rights reserved.
//

import UIKit

class LogViewController: UIViewController {

    
    @IBAction func cancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerButton.buttonDesign()
        self.signInButton.buttonSecondDesign()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if (GlobalSession.isLoggedIn == true){
            self.navigationController?.popViewController(animated: false)
        }
    }
    
    @IBAction func registerButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "logToRegister", sender: nil)
        
    }
    
    @IBAction func logInButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "logToLogIn", sender: nil)
    }
    
}
