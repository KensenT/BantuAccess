//
//  RegisteringViewController.swift
//  Bantu
//
//  Created by Resky Javieri on 10/10/18.
//  Copyright © 2018 Resky Javieri. All rights reserved.
//

import UIKit

class RegisteringViewController: UIViewController {

    @IBOutlet weak var registerButton: UIButton!
    
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    var fullName: String!
    var phone: String!
    var email: String!
    var password: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerButton.buttonDesign()
    }
    
    func createOkAlert(title: String, message: String, onComplete: @escaping () -> ()){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
            onComplete()
        }
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func createNewUser(){
        let hashedPassword: String = SHA1.hexString(from: self.password)!
        
        let newUser = User(userId: 0, levelId: 2, fullName: self.fullName!, phone: self.phone, email: self.email, password: hashedPassword)
        
        UserServices.postUser(newUser: newUser) { (inserted) in
            if (inserted == true){
                UserServices.getUsers() { (users) in
                    for singleUser in users{
                        if (singleUser.email == self.email){
                            GlobalSession.loggedInUser = singleUser
                            GlobalSession.isLoggedIn = true
                            DispatchQueue.main.async {
                                self.createOkAlert(title: "Berhasil", message: "Akun anda sudah terdaftar di Bantu!"){
                                    // go back to profile page
                                    self.navigationController?.popViewController(animated: false)
                                }
                            }
                        }
                    }
                }
                
            }
            else{
                DispatchQueue.main.async {
                    self.createOkAlert(title: "Daftar Gagal", message: "Koneksi ke database sedang offline!") {}
                }
            }
        }
    }
    
    func checkEmailExist(){
        let currEmail: String = self.emailTextField.text!
        
        UserServices.getUsers { (users) in
            for singleUser in users{
                if (currEmail == singleUser.email){
                    DispatchQueue.main.async {
                        self.createOkAlert(title: "Daftar Gagal", message: "Email sudah pernah terdaftar!"){}
                    }
                    return
                }
            }
            self.createNewUser()
        }
    }
    
    @IBAction func registerButtonClicked() {
        if (self.fullNameTextField.text == "" || self.phoneTextField.text == "" || self.emailTextField.text == "" || self.passwordTextField.text == "" || self.confirmPasswordTextField.text == ""){
            self.createOkAlert(title: "Daftar Gagal", message: "Mohon isi semua field!"){}
        }
        else if (self.passwordTextField.text != self.confirmPasswordTextField.text){
            self.createOkAlert(title: "Daftar Gagal", message: "Konfirmasi kata sandi tidak sesuai!"){}
        }
        else{
            self.fullName = self.fullNameTextField.text!
            self.phone = self.phoneTextField.text!
            self.email = self.emailTextField.text!
            self.password = self.passwordTextField.text!
            self.checkEmailExist()
        }
    }
    
}
