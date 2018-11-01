//
//  LogInViewController.swift
//  Bantu
//
//  Created by Resky Javieri on 10/10/18.
//  Copyright © 2018 Resky Javieri. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {

    @IBOutlet weak var logInButton: UIButton!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var email: String!
    var password: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.logInButton.buttonDesign()

    }
    
    func createOkAlert(title: String, message: String, onComplete: @escaping () -> ()){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
            onComplete()
        }
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }

    @IBAction func logInButtonClicked() {
        self.email = self.emailTextField.text!
        self.password = self.passwordTextField.text!
        
        let hashedPassword: String = SHA1.hexString(from: self.password)!
        
        if (self.emailTextField.text == "" || self.passwordTextField.text == ""){
            self.createOkAlert(title: "Masuk Gagal", message: "Mohon isi semua field!"){}
        }
        else{
            UserServices.getUsers { (users) in
                for singleUser in users{
                    if (singleUser.email == self.email){
                        if (singleUser.password == hashedPassword){
                            DispatchQueue.main.async {
                                
                                self.createOkAlert(title: "Berhasil", message: "Anda telah masuk!"){
                                    // to profile page
                                    GlobalSession.isLoggedIn = true
                                    GlobalSession.loggedInUser = singleUser
                                    self.navigationController?.popViewController(animated: false)
                                }
                            }
                        }
                        else{
                            DispatchQueue.main.async {
                                self.createOkAlert(title: "Masuk Gagal", message: "Kata sandi tidak sesuai!"){}
                            }
                            
                        }
                        return
                    }
                }
                DispatchQueue.main.async {
                    self.createOkAlert(title: "Masuk Gagal", message: "E-mail tidak terdaftar dalam aplikasi Bantu!"){}
                }
            }
        }
    }
    
}
